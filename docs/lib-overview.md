# Lib Overview - Bibliotheksstruktur

Dieses Dokument beschreibt die Struktur und Funktionalität der `lib/` Komponenten.

## Verzeichnisstruktur

```
lib/
├── controller/          # Request-Handler und Business-Logik
│   ├── api.dart        # Hauptcontroller für Fußballdaten
│   └── auth.dart       # Authentifizierungscontroller
│
├── crawler/            # HTTP-Client und Web-Scraping
│   └── http_client_bridge.dart
│
├── dto/                # Data Transfer Objects
│   ├── club_match_info_transfer.dart
│   ├── club_team_info_transfer.dart
│   └── response_dto.dart
│
├── entities/           # Datenbank-Entities (Isar)
│   ├── font.dart
│   ├── rate_limit.dart
│   ├── user.dart
│   └── *.g.dart       # Generierte Code-Behind-Dateien
│
├── html/               # HTML-Parser für fussball.de
│   ├── club.dart
│   ├── font.dart
│   ├── games.dart
│   └── table_result.dart
│
├── database.dart       # Datenbank-Manager und Queries
└── middleware.dart     # Shelf-Middleware-Funktionen
```

---

## Controller Layer

### api.dart
**Verantwortlichkeit**: Haupt-API-Controller mit allen Endpunkt-Handler

**Klasse**: `ApiController`

**Dependencies**:
- `HttpClientBridge` - Für fussball.de Requests
- `GamesInterface` - HTML-Parsing für Spiele
- `Club` - HTML-Parsing für Vereinsdaten
- `TableResult` - HTML-Parsing für Tabellen

**Methoden**:

| Methode | Route | Beschreibung |
|---------|-------|--------------|
| `clubAction()` | `/api/club/{id}` | Liste aller Teams eines Vereins |
| `clubInfoAction()` | `/api/club/info/{id}` | Vereinsübersicht mit Spielen |
| `nextGameAction()` | `/api/club/next_games/{id}` | Kommende Vereinsspiele |
| `prevGameAction()` | `/api/club/prev_games/{id}` | Vergangene Vereinsspiele |
| `teamAction()` | `/api/team/{id}` | Team-Info mit Tabelle und Spielen |
| `nextTeamAction()` | `/api/team/next_games/{id}` | Kommende Team-Spiele |
| `prevTeamAction()` | `/api/team/prev_games/{id}` | Vergangene Team-Spiele |
| `tableAction()` | `/api/team/table/{id}` | Tabellenstand der Liga |

**Pattern**: Verwendet `Future.wait()` für parallele Requests bei kombinierten Daten

**Beispiel (clubInfoAction)**:
```dart
var results = await Future.wait([
  httpClientBridge.fetchData('/ajax.club.teams/-/action/search/id/$id'),
  httpClientBridge.fetchData('/ajax.club.prev.games/-/id/$id/mode/PAGE'),
  httpClientBridge.fetchData('/ajax.club.next.games/-/id/$id/mode/PAGE')
]);
```

### auth.dart
**Verantwortlichkeit**: Authentifizierung und Benutzerregistrierung

**Details**: Siehe [authentication.md](authentication.md)

---

## Crawler Layer

### http_client_bridge.dart
**Verantwortlichkeit**: HTTP-Client-Wrapper für fussball.de

**Hauptfunktion**: `fetchData(String path)`
- Erstellt vollständige URL: `https://www.fussball.de{path}`
- Sendet GET-Request
- Gibt HTML als String zurück
- Error-Handling für HTTP-Fehler

**Verwendung**:
```dart
String html = await httpClientBridge.fetchData('/ajax.club.teams/-/action/search/id/123');
```

---

## DTO Layer (Data Transfer Objects)

### club_match_info_transfer.dart
**Struktur für Spielinformationen**

```dart
class ClubMatchInfoTransfer {
  String date;           // "01.12.2024"
  String time;           // "15:00"
  String homeTeam;
  String awayTeam;
  String? homeScore;     // Nur bei vergangenen Spielen
  String? awayScore;
  String homeLogo;       // URL
  String awayLogo;       // URL
  String competition;    // "Kreisliga A"
  String? ageGroup;      // "Herren"
  String? status;        // "Beendet", "Abgesagt", etc.
}
```

### club_team_info_transfer.dart
**Struktur für Team-Informationen**

```dart
class ClubTeamInfoTransfer {
  String id;             // Team-ID
  String name;           // "FC Example I"
  String ageGroup;       // "Herren"
  String league;         // "Kreisliga A"
}
```

### response_dto.dart
**Standard-Response-Formate**

**Erfolgreiche Response:**
```dart
class ResponseSuccessDto {
  bool success = true;
  dynamic data;
  String? message;
}
```

**Fehler-Response:**
```dart
class ResponseErrorDto {
  bool success = false;
  List data = [];
  String message;
}
```

**Spezial-Responses:**
- `ResponseInfoSuccessDto` - Für kombinierte Club-Info
- `ResponseTeamInfoSuccessDto` - Für kombinierte Team-Info

---

## Entities Layer (Datenbank-Modelle)

### user.dart
```dart
@collection
class User {
  Id id = Isar.autoIncrement;
  String? email;
  String? token;
}
```

### font.dart
```dart
@collection
class Font {
  Id id = Isar.autoIncrement;
  String? name;        // Font-Identifier (z.B. "font123")
  String? info;        // JSON-String mit Character-Mapping
}
```

### rate_limit.dart
```dart
@collection
class RateLimit {
  Id id = Isar.autoIncrement;
  int? userId;
  int? time;          // Format: YYYYMMDDHHmm (z.B. 202501301530)
}
```

**Hinweis**: `*.g.dart` Dateien werden automatisch von Isar generiert.

---

## HTML Parser Layer

### club.dart
**Verantwortlichkeit**: Extrahiert Team-Listen aus Vereinsseiten

**Hauptmethode**: `parseHTML(String html)`

**Parst**:
- Team-IDs aus Anchor-Tags
- Team-Namen
- Liga-Informationen
- Altersgruppen

### games.dart
**Verantwortlichkeit**: Extrahiert Spielinformationen aus HTML-Tabellen

**Hauptmethode**: `parseHTML(String html, bool isPastGame)`

**Parst**:
- Datum und Uhrzeit
- Heim- und Auswärtsteam
- Team-Logos
- Wettbewerb
- **Scores** (nur bei `isPastGame=true`) - mit Font-Dekodierung!

**Besonderheit**: Verwendet `ScoreFont` für verschleierte Ergebnisse

### table_result.dart
**Verantwortlichkeit**: Extrahiert Ligatabellen

**Hauptmethode**: `parseHTML(String html)`

**Parst**:
- Tabellenplatz
- Team-Namen und Logos
- Statistiken (Spiele, Siege, Niederlagen, etc.)
- Tordifferenz und Punkte
- Auf-/Abstiegsplätze (via CSS-Klassen)

### font.dart
**Verantwortlichkeit**: Font-Dekodierung für verschleierte Zahlen

**Details**: Siehe [font-decoding.md](font-decoding.md)

---

## Database Layer

### database.dart
**Zentrale Datenbank-Verwaltung**

**Klassen**:

#### Database
Singleton-Pattern für Isar-Instanz
```dart
static Future<Isar> get isarInstance
```

#### FontManager
CRUD-Operationen für Fonts
```dart
Future<Map<String, String>?> findByName(String name)
Future<void> save(String name, Map<String, String> info)
Future<List<int>> deleteAll()
```

#### RateLimitManager
Rate-Limiting-Logik
```dart
Future<int> get(int userId)           // Anzahl Requests in aktueller Minute
Future<void> add(int userId)          // Request-Counter erhöhen
Future<void> clear()                  // Alle Limits zurücksetzen
```

**Globale Funktionen**:
```dart
Future<List<User?>> findAllUser()
Future<User?> findUserByToken(String token)
Future<void> saveUser(String email, String token)
Future<void> deleteUserByEmail(String email)
Future<void> saveUsersToJson()        // Für Backups
Future<List<String>> importUsersFromJson()  // Für Restore
```

---

## Middleware Layer

### middleware.dart
**Shelf-Middleware-Funktionen**

#### headerTokenCheckMiddleware()
**Zweck**: Token-Authentifizierung und Rate-Limiting

**Prüft**:
1. `x-auth-token` Header vorhanden?
2. Token in Datenbank vorhanden?
3. Rate-Limit (30 Requests/Minute) nicht überschritten?

**Responses**:
- `401 Unauthorized` - Token fehlt oder ungültig
- `429 Too Many Requests` - Rate-Limit überschritten

#### jsonResponseMiddleware
**Zweck**: Setzt `Content-Type: application/json` Header

#### globalErrorMiddleware()
**Zweck**: Globale Exception-Handler

**Fängt alle Fehler und gibt strukturierte Response**:
```json
{
  "success": false,
  "data": [],
  "message": "Fehlermeldung"
}
```

---

## Datenfluss-Beispiel

**Request**: `GET /api/club/info/012345678901234`

```
1. server.dart (Router)
   ↓
2. middleware.dart (Token-Check, Rate-Limit)
   ↓
3. api.dart (clubInfoAction)
   ↓
4. http_client_bridge.dart (3x parallel fetchData)
   ↓
5. HTML-Parser (club.dart, games.dart)
   ↓
6. font.dart (Score-Dekodierung falls nötig)
   ↓
7. DTO-Konvertierung
   ↓
8. JSON-Response zurück an Client
```

---

## Best Practices

### Performance-Optimierung
- Nutze `Future.wait()` für parallele Requests
- Cache Fonts in Datenbank
- Runtime-Cache in `ScoreFont`

### Fehlerbehandlung
- Alle Parser sollten robustes Error-Handling haben
- Nutze `globalErrorMiddleware` für unerwartete Fehler

### Datenbank-Zugriff
- Immer über Manager-Klassen (FontManager, RateLimitManager)
- Nutze Transaktionen für Write-Operationen

### Testing
- Unit-Tests für alle Parser
- Integration-Tests für Controller
- Mock `HttpClientBridge` für Tests

---

## Erweiterung der API

**Neuen Endpunkt hinzufügen:**

1. **Controller-Methode** in `api.dart`:
   ```dart
   Future<Response> myNewAction(Request request) async {
     // Implementation
   }
   ```

2. **Route** in `server.dart`:
   ```dart
   ..get('/api/my/new/<id>', (Request request) =>
     headerTokenCheckMiddleware()(gamesController.myNewAction)(request))
   ```

3. **Parser** in `lib/html/` (falls nötig)

4. **DTO** in `lib/dto/` (falls nötig)

5. **Tests** in `test/`
