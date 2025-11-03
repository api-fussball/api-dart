# Authentifizierung & Rate-Limiting

Dieses Dokument beschreibt das Authentifizierungs- und Rate-Limiting-System.

---

## Übersicht

```
┌──────────────────────────────────────────┐
│  User Registration (POST /auth/register) │
└───────────────┬──────────────────────────┘
                │
                ▼
        ┌───────────────┐
        │ Generate Token│ (29 Zeichen + Timestamp)
        └───────┬───────┘
                │
                ▼
        ┌───────────────┐
        │  Save to DB   │ (Isar)
        └───────────────┘
                │
                ▼
┌───────────────────────────────────────────┐
│  API Requests with x-auth-token Header    │
└───────────────┬───────────────────────────┘
                │
                ▼
        ┌───────────────┐
        │ Token Valid?  │
        └───┬───────┬───┘
         NO │       │ YES
            │       ▼
            │   ┌────────────────┐
            │   │ Rate Limit OK? │
            │   └───┬────────┬───┘
            │    NO │        │ YES
            │       │        │
            ▼       ▼        ▼
         [401]   [429]    [200]
```

---

## Token-Generierung

### Implementierung (lib/controller/auth.dart)

```dart
class AuthController {
  Future<Response> register(Request request) async {
    // 1. Request-Body parsen
    String body = await request.readAsString();
    Map<String, dynamic> data = jsonDecode(body);
    String email = data['email'];

    // 2. E-Mail validieren
    if (!EmailValidator.validate(email)) {
      return Response.badRequest(body: 'Invalid email');
    }

    // 3. Token generieren
    String token = generateToken();

    // 4. User speichern
    await saveUser(email, token);

    // 5. Response
    return Response.ok(jsonEncode({
      'success': true,
      'data': {
        'email': email,
        'token': token
      },
      'message': 'Please copy the token. After leaving the page, copying again is not possible.'
    }));
  }
}
```

### Token-Format

**Struktur**: `{random_chars}-{timestamp}`

**Beispiel**: `a7f3g9h2k4m6n8p1q5r7s-1234567890123`

**Länge**: 29 Zeichen
- 21 Zeichen zufällige Zeichen (ohne Vokale, um Wörter zu vermeiden)
- 1 Bindestrich
- 13 Zeichen Timestamp (Millisekunden seit Epoch)

**Generierung**:
```dart
String generateToken() {
  const chars = 'bcdfghjklmnpqrstvwxz0123456789';  // Ohne Vokale
  final random = Random.secure();

  // 21 zufällige Zeichen
  String randomPart = List.generate(21, (index) =>
    chars[random.nextInt(chars.length)]
  ).join();

  // Timestamp (Millisekunden)
  String timestamp = DateTime.now().millisecondsSinceEpoch.toString();

  return '$randomPart-$timestamp';
}
```

**Vorteile**:
- **Sicher**: Kryptographisch sicherer Zufallsgenerator
- **Eindeutig**: Timestamp garantiert Einzigartigkeit
- **Lesbar**: Keine Vokale → keine versehentlichen Wörter
- **Trackbar**: Timestamp ermöglicht Analyse (wann wurde registriert?)

---

## Registrierung

### Endpunkt

**POST** `/auth/register` oder `/api/auth/register`

**Request**:
```json
{
  "email": "user@example.com"
}
```

**Response (Erfolg)**:
```json
{
  "success": true,
  "data": {
    "email": "user@example.com",
    "token": "b3d5f7h9j2k4m6n8p1q5r-1704067200000"
  },
  "message": "Please copy the token. After leaving the page, copying again is not possible."
}
```

**Response (Fehler)**:
```json
{
  "success": false,
  "data": [],
  "message": "Invalid email"
}
```

### E-Mail-Validierung

**Package**: `email_validator`

```dart
import 'package:email_validator/email_validator.dart';

if (!EmailValidator.validate(email)) {
  throw Exception('Invalid email format');
}
```

**Gültige Formate**:
- `user@example.com` ✓
- `firstname.lastname@company.co.uk` ✓
- `user+tag@domain.org` ✓

**Ungültige Formate**:
- `invalid.email` ✗ (kein @)
- `@example.com` ✗ (kein lokaler Teil)
- `user@` ✗ (keine Domain)

### Datenbank-Speicherung

```dart
Future<void> saveUser(String email, String token) async {
  final isar = await Database.isarInstance;

  // Alte Einträge mit gleicher E-Mail löschen
  await isar.writeTxn(() async {
    await isar.users.where().filter().emailEqualTo(email).deleteAll();
  });

  // Neuen User anlegen
  final newUser = User()
    ..email = email
    ..token = token;

  await isar.writeTxn(() async {
    await isar.users.put(newUser);
  });
}
```

**Verhalten**:
- **Neue E-Mail**: User wird angelegt
- **Existierende E-Mail**: Alter Token wird überschrieben (Re-Registrierung)

---

## Token-Validierung (Middleware)

### headerTokenCheckMiddleware

**Datei**: `lib/middleware.dart`

```dart
Middleware headerTokenCheckMiddleware() {
  return (Handler innerHandler) {
    return (Request request) async {
      // 1. Token aus Header extrahieren
      String? token = request.headers['x-auth-token'];
      if (token == null) {
        return Response.unauthorized(
          jsonEncode(ResponseErrorDto('Token in header: "x-auth-token" not found'))
        );
      }

      // 2. Token in Datenbank suchen
      User? user = await findUserByToken(token);
      if (user == null) {
        return Response.unauthorized(
          jsonEncode(ResponseErrorDto('Token $token not found'))
        );
      }

      // 3. Rate-Limit prüfen
      int rateLimit = await RateLimitManager().get(user.id);
      if (rateLimit > 30) {
        return Response(429, body: jsonEncode(
          ResponseErrorDto('You are allowed a maximum of 30 queries per minute.')
        ));
      }

      // 4. Request zählen
      await RateLimitManager().add(user.id);

      // 5. Anfrage durchlassen
      return innerHandler(request);
    };
  };
}
```

### Verwendung in Routen

```dart
// server.dart
final _router = Router()
  ..get('/api/club/<id>',  (Request request) =>
    headerTokenCheckMiddleware()(gamesController.clubAction)(request)
  );
```

**Jede geschützte Route** läuft durch diese Middleware!

---

## Rate-Limiting

### Konzept

**Limit**: 30 Anfragen pro Minute pro Benutzer

**Zeitfenster**: Minutengenau
- `202501301530` = 30. Januar 2025, 15:30 Uhr
- `202501301531` = 30. Januar 2025, 15:31 Uhr (neues Fenster!)

**Funktionsweise**:
```
Minute 15:30:
Request 1-30  ✓  (erlaubt)
Request 31    ✗  (HTTP 429)

Minute 15:31:
Request 1-30  ✓  (neues Fenster, wieder erlaubt)
```

### Implementierung (lib/database.dart)

#### RateLimitManager

```dart
class RateLimitManager {
  // Anzahl Requests in aktueller Minute abrufen
  Future<int> get(int userId) async {
    final isar = await Database.isarInstance;

    return await isar.rateLimits
      .where()
      .filter()
      .userIdEqualTo(userId)
      .timeEqualTo(_getDate())  // Nur aktuelle Minute
      .count();
  }

  // Request-Counter erhöhen
  Future<void> add(int userId) async {
    final isar = await Database.isarInstance;

    final newRateLimit = RateLimit()
      ..userId = userId
      ..time = _getDate();

    await isar.writeTxn(() async {
      await isar.rateLimits.put(newRateLimit);
    });
  }

  // Alle Rate-Limits löschen (Wartung)
  Future<void> clear() async {
    final isar = await Database.isarInstance;
    await isar.writeTxn(() async {
      await isar.rateLimits.clear();
    });
  }

  // Zeitfenster berechnen (YYYYMMDDHHmm)
  int _getDate() {
    DateTime now = DateTime.now();
    String formatted = '${now.year}'
      '${now.month.toString().padLeft(2, '0')}'
      '${now.day.toString().padLeft(2, '0')}'
      '${now.hour.toString().padLeft(2, '0')}'
      '${now.minute.toString().padLeft(2, '0')}';
    return int.parse(formatted);
  }
}
```

### Beispiel-Datenbank-Einträge

**Tabelle: rate_limits**
```
id | userId | time
---|--------|-------------
1  | 5      | 202501301530
2  | 5      | 202501301530
3  | 5      | 202501301530
...
30 | 5      | 202501301530  ← 30. Request
31 | 7      | 202501301530  ← Anderer User
32 | 5      | 202501301531  ← Neues Zeitfenster
```

**Query**: "Wie viele Requests hat User 5 um 15:30?"
```dart
count WHERE userId = 5 AND time = 202501301530
→ 30 Einträge
```

### Automatische Cleanup

**Problem**: Alte Einträge häufen sich an

**Lösungsansätze**:

1. **Manuell** (via clear.dart):
   ```bash
   dart run bin/clear.dart
   ```

2. **Cron-Job** (empfohlen):
   ```bash
   # Täglich um 3 Uhr morgens
   0 3 * * * cd /path/to/project && dart run bin/clear.dart
   ```

3. **Code-basiert** (bei jedem Request):
   ```dart
   // Nur alte Einträge löschen (älter als 1 Stunde)
   int cutoff = _getDate() - 100;  // 100 Minuten zurück
   await isar.rateLimits.where()
     .filter()
     .timeLessThan(cutoff)
     .deleteAll();
   ```

---

## HTTP-Statuscodes

### 200 OK
**Erfolgreiche Anfrage**

Request:
```bash
curl -H "x-auth-token: valid-token-here" \
  https://api.example.com/api/club/123
```

Response:
```json
{
  "success": true,
  "data": [...]
}
```

### 401 Unauthorized
**Token fehlt oder ungültig**

**Fall 1: Token fehlt**
Request:
```bash
curl https://api.example.com/api/club/123
```

Response:
```json
{
  "success": false,
  "data": [],
  "message": "Token in header: \"x-auth-token\" not found"
}
```

**Fall 2: Token ungültig**
Request:
```bash
curl -H "x-auth-token: invalid-token" \
  https://api.example.com/api/club/123
```

Response:
```json
{
  "success": false,
  "data": [],
  "message": "Token invalid-token not found"
}
```

### 429 Too Many Requests
**Rate-Limit überschritten**

Request (31. Anfrage in derselben Minute):
```bash
curl -H "x-auth-token: valid-token-here" \
  https://api.example.com/api/club/123
```

Response:
```json
{
  "success": false,
  "data": [],
  "message": "You are allowed a maximum of 30 queries per minute. Please try again later."
}
```

**Retry-Strategie**:
- Warte bis zur nächsten Minute
- Implementiere exponentielles Backoff
- Zeige User Fehlermeldung

---

## Sicherheitsaspekte

### 1. Token-Sicherheit

**Best Practices**:
- ✓ Tokens sind lang genug (29 Zeichen)
- ✓ Kryptographisch sicherer Zufallsgenerator
- ✓ Keine Wiederverwendung bei Re-Registrierung
- ✓ Keine Token-Wiederherstellung (einmalige Anzeige)

**Risiken**:
- ✗ Keine Token-Rotation (Token bleiben für immer gültig)
- ✗ Kein Token-Ablauf (keine Expiration)
- ✗ Keine Token-Widerrufung durch Admin

**Empfehlungen für Production**:
```dart
// Token mit Ablaufdatum
class User {
  String? token;
  DateTime? tokenExpiry;  // z.B. 90 Tage
}

// Bei jedem Request prüfen
if (user.tokenExpiry.isBefore(DateTime.now())) {
  return Response.unauthorized('Token expired');
}
```

### 2. Rate-Limiting

**Aktuelle Implementierung**:
- ✓ Pro Benutzer (nicht global)
- ✓ Minutengenaue Zeitfenster
- ✓ Persistent in Datenbank

**Verbesserungsvorschläge**:
```dart
// Unterschiedliche Limits für Endpunkte
final limits = {
  '/api/club/info': 10,      // Teuer (viele Requests)
  '/api/team/table': 30,     // Standard
  '/api/team/next_games': 50 // Günstig (wenig Load)
};
```

### 3. E-Mail-Verifizierung

**Aktuell**: Keine E-Mail-Verifizierung

**Problem**:
- Jeder kann sich mit beliebiger E-Mail registrieren
- Keine Bestätigung, dass E-Mail dem User gehört

**Lösung**:
```dart
// 1. Token generieren
String verificationToken = generateToken();

// 2. E-Mail senden
await sendEmail(email, 'Verify your email', '''
  Click here to verify:
  https://api.example.com/auth/verify?token=$verificationToken
''');

// 3. User als unverified speichern
user.verified = false;

// 4. Bei API-Zugriff prüfen
if (!user.verified) {
  return Response.unauthorized('Please verify your email');
}
```

---

## Testing

### Unit-Test: Token-Generierung

```dart
test('Token has correct format', () {
  String token = generateToken();

  expect(token.length, equals(29));
  expect(token, contains('-'));

  var parts = token.split('-');
  expect(parts[0].length, equals(21));  // Random part
  expect(parts[1].length, equals(13));  // Timestamp
});
```

### Integration-Test: Authentifizierung

```dart
test('Protected endpoint requires valid token', () async {
  // Setup
  await saveUser('test@example.com', 'test-token');

  // Test without token
  var response1 = await request('GET', '/api/club/123');
  expect(response1.statusCode, equals(401));

  // Test with invalid token
  var response2 = await request('GET', '/api/club/123',
    headers: {'x-auth-token': 'invalid'}
  );
  expect(response2.statusCode, equals(401));

  // Test with valid token
  var response3 = await request('GET', '/api/club/123',
    headers: {'x-auth-token': 'test-token'}
  );
  expect(response3.statusCode, equals(200));
});
```

### Test: Rate-Limiting

```dart
test('Rate limit blocks after 30 requests', () async {
  await saveUser('test@example.com', 'test-token');

  // 30 Requests sollten funktionieren
  for (var i = 0; i < 30; i++) {
    var response = await request('GET', '/api/club/123',
      headers: {'x-auth-token': 'test-token'}
    );
    expect(response.statusCode, equals(200));
  }

  // 31. Request sollte geblockt werden
  var response = await request('GET', '/api/club/123',
    headers: {'x-auth-token': 'test-token'}
  );
  expect(response.statusCode, equals(429));
});
```

---

## Troubleshooting

### Token funktioniert nicht

**Problem**: `Token xyz not found`

**Lösungen**:
1. Prüfe Datenbank:
   ```bash
   dart run bin/backup.dart
   cat users.json
   ```

2. Re-Registrierung:
   ```bash
   curl -X POST https://api.example.com/auth/register \
     -H "Content-Type: application/json" \
     -d '{"email":"user@example.com"}'
   ```

### Rate-Limit zu niedrig

**Problem**: 30 Requests/Minute reichen nicht

**Lösung 1**: Limit erhöhen (middleware.dart):
```dart
if (rateLimit > 100) {  // War: 30
  return Response(429, ...);
}
```

**Lösung 2**: Zeitfenster vergrößern:
```dart
// Statt Minute: Stunde
int _getDate() {
  DateTime now = DateTime.now();
  return int.parse('${now.year}${now.month}${now.day}${now.hour}');
}
```

### Alte Rate-Limits blockieren

**Problem**: Datenbank ist voll mit alten Einträgen

**Lösung**:
```bash
# Manuell clearen
dart run bin/clear.dart

# Oder: Cron-Job einrichten
crontab -e
# Hinzufügen:
0 */6 * * * cd /path/to/project && dart run bin/clear.dart
```

---

## Best Practices

### Client-Implementierung

```javascript
// JavaScript-Client
class ApiClient {
  constructor(token) {
    this.token = token;
    this.requestQueue = [];
    this.requestsPerMinute = 0;
  }

  async request(endpoint) {
    // Rate-Limit-Tracking
    if (this.requestsPerMinute >= 30) {
      console.warn('Rate limit reached, waiting...');
      await this.waitForNextMinute();
    }

    const response = await fetch(`https://api.example.com${endpoint}`, {
      headers: {
        'x-auth-token': this.token
      }
    });

    if (response.status === 429) {
      console.error('Rate limit exceeded!');
      await this.waitForNextMinute();
      return this.request(endpoint);  // Retry
    }

    this.requestsPerMinute++;
    return response.json();
  }

  async waitForNextMinute() {
    const now = new Date();
    const nextMinute = new Date(now.getFullYear(), now.getMonth(),
      now.getDate(), now.getHours(), now.getMinutes() + 1, 0, 0);
    const waitTime = nextMinute - now;
    await new Promise(resolve => setTimeout(resolve, waitTime));
    this.requestsPerMinute = 0;
  }
}

// Verwendung
const client = new ApiClient('my-token-here');
const data = await client.request('/api/club/123');
```

---

## Zusammenfassung

| Komponente | Zweck | Implementierung |
|------------|-------|-----------------|
| Token-Generierung | Sichere User-Identifikation | 29 Zeichen (Random + Timestamp) |
| Token-Validierung | Zugriffskontrolle | Middleware + Datenbank-Lookup |
| Rate-Limiting | Missbrauchsschutz | 30 Requests/Minute, minutengenaue Fenster |
| E-Mail-Validierung | Datenqualität | email_validator Package |
