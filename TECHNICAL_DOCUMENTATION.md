# Technische Dokumentation - API Fussball Dart

## Projektübersicht

Diese API ist ein Web-Scraping-Service für Fußballdaten von fussball.de. Das System extrahiert Spielinformationen, Tabellenstände und Vereinsdaten und stellt diese über eine REST API zur Verfügung.

## Architektur

### Technologie-Stack
- **Sprache**: Dart 3.0.6+
- **Web-Framework**: Shelf (mit shelf_router für Routing)
- **Datenbank**: Isar (NoSQL embedded Datenbank)
- **HTML-Parsing**: html-Package für DOM-Manipulation
- **Font-Dekodierung**: ttx (FontTools) für WOFF-Font-Konvertierung
- **HTTP-Client**: http-Package

### Hauptkomponenten

```
┌─────────────────────────────────────────────────────┐
│                    API Server                       │
│                  (bin/server.dart)                  │
└──────────────────┬──────────────────────────────────┘
                   │
         ┌─────────┼─────────┬──────────────┐
         │         │         │              │
    ┌────▼────┬────▼────┬───▼────┬─────────▼────┐
    │  Auth   │  API    │ Middle-│   Database   │
    │Controller│Controller│ ware  │   (Isar)    │
    └─────────┴────┬────┴────────┴──────────────┘
                   │
         ┌─────────┼──────────┬──────────────┐
         │         │          │              │
    ┌────▼────┬────▼────┬────▼────┬─────────▼────┐
    │  HTML   │  Font   │ HTTP   │    DTOs      │
    │ Parser  │ Proxy   │ Client │              │
    └─────────┴─────────┴────────┴──────────────┘
```

## Font-Dekodierung (Besonderheit!)

### Problem
Fussball.de verschleiert Spielergebnisse durch eine spezielle Font-Obfuskation. Die Zahlen werden nicht als normale Zeichen übertragen, sondern als Unicode-Zeichen, die über eine spezielle WOFF-Font auf die richtigen Ziffern gemappt werden.

### Lösung

#### 1. Font-Proxy-Pattern
```dart
class FontProxy implements FontInterface {
  // Cached Font-Informationen aus der Datenbank
  // Falls nicht vorhanden, lädt und dekodiert neue Fonts
  Future<Map<String, String>> decodeFont(String fontName)
}
```

#### 2. Font-Dekodierung Prozess
1. **WOFF-Download**: Font wird von `https://www.fussball.de/export.fontface/-/format/woff/id/{fontName}/type/font` heruntergeladen
2. **TTX-Konvertierung**: WOFF wird mit `ttx -t cmap` in XML konvertiert
3. **Character-Mapping**: XML wird geparst und Unicode-Zeichen werden auf echte Ziffern gemappt
4. **Caching**: Mapping wird in Isar-Datenbank gespeichert für zukünftige Anfragen

#### 3. Score-Dekodierung
```dart
// Beispiel: HTML enthält data-obfuscation="font123"
// und span.innerHtml="&#xe001;&#xe005;" (verschleierte "15")
String score = await scoreFont.getScore("font123", "xe001;xe005");
// Rückgabe: "15"
```

## API-Endpunkte

### Authentifizierung

#### POST `/auth/register` oder `/api/auth/register`
**Registriert einen neuen Benutzer und generiert API-Token**

Request:
```json
{
  "email": "user@example.com"
}
```

Response (200 OK):
```json
{
  "success": true,
  "data": {
    "email": "user@example.com",
    "token": "29-stelliger-zufälliger-token-mit-timestamp"
  },
  "message": "Please copy the token. After leaving the page, copying again is not possible."
}
```

### Geschützte Endpunkte (Benötigen `x-auth-token` Header)

#### GET `/api/club/{id}`
**Liefert alle Teams eines Vereins**

Response:
```json
{
  "success": true,
  "data": [
    {
      "id": "team-id",
      "name": "FC Example I",
      "ageGroup": "Herren",
      "league": "Kreisliga A"
    }
  ]
}
```

#### GET `/api/club/info/{id}`
**Liefert Vereinsübersicht mit Teams, vergangenen und kommenden Spielen**

Response:
```json
{
  "success": true,
  "data": {
    "clubs": [...],      // Liste aller Teams
    "prevGames": [...],  // Vergangene Spiele
    "nextGames": [...]   // Kommende Spiele
  }
}
```

#### GET `/api/club/next_games/{id}`
**Liefert kommende Spiele eines Vereins**

Response:
```json
{
  "success": true,
  "data": [
    {
      "date": "01.12.2024",
      "time": "15:00",
      "homeTeam": "FC Example",
      "awayTeam": "SV Sample",
      "homeLogo": "https://...",
      "awayLogo": "https://...",
      "competition": "Kreisliga A",
      "ageGroup": "Herren",
      "status": null
    }
  ]
}
```

#### GET `/api/club/prev_games/{id}`
**Liefert vergangene Spiele eines Vereins mit Ergebnissen**

Response (mit dekodierten Scores):
```json
{
  "success": true,
  "data": [
    {
      "date": "24.11.2024",
      "time": "14:30",
      "homeTeam": "FC Example",
      "awayTeam": "SV Sample",
      "homeScore": "2",
      "awayScore": "1",
      "status": "Beendet",
      "homeLogo": "https://...",
      "awayLogo": "https://...",
      "competition": "Kreisliga A"
    }
  ]
}
```

#### GET `/api/team/{id}`
**Liefert Team-Übersicht mit Tabelle, vergangenen und kommenden Spielen**

Response:
```json
{
  "success": true,
  "data": {
    "table": [...],      // Tabellenstand
    "prevGames": [...],  // Vergangene Spiele
    "nextGames": [...]   // Kommende Spiele
  }
}
```

#### GET `/api/team/next_games/{id}`
**Liefert kommende Spiele eines Teams**

#### GET `/api/team/prev_games/{id}`
**Liefert vergangene Spiele eines Teams mit Ergebnissen**

#### GET `/api/team/table/{id}`
**Liefert den aktuellen Tabellenstand der Liga**

Response:
```json
{
  "success": true,
  "data": [
    {
      "place": 1,
      "team": "FC Example",
      "img": "https://...",
      "games": 15,
      "won": 10,
      "draw": 3,
      "lost": 2,
      "goal": "35:12",
      "goalDifference": 23,
      "points": 33,
      "isPromotion": true,
      "isRelegation": false
    }
  ]
}
```

## Sicherheitsmechanismen

### 1. Token-Authentifizierung
- Jeder API-Zugriff benötigt einen gültigen Token im `x-auth-token` Header
- Token sind 29 Zeichen lang mit eingebettetem Timestamp
- Tokens werden in der Isar-Datenbank gespeichert

### 2. Rate Limiting
- **Limit**: 30 Anfragen pro Minute pro Benutzer
- **Zeitfenster**: Minutengenau (YYYYMMDDHHmm)
- **Response bei Überschreitung**: HTTP 429 (Too Many Requests)
- Implementation:
  ```dart
  class RateLimitManager {
    // Zählt Anfragen pro Benutzer pro Minute
    // Speichert in Isar-Datenbank
  }
  ```

### 3. Middleware-Stack
1. **Logging**: Protokolliert alle Anfragen
2. **JSON Response**: Setzt Content-Type Header
3. **Global Error Handler**: Fängt alle Exceptions
4. **Token Check**: Validiert Authentifizierung
5. **Rate Limit Check**: Prüft Anfrage-Limits

## Datenbank-Schema

### User Entity
```dart
@collection
class User {
  Id id = Isar.autoIncrement;
  String? email;
  String? token;
}
```

### Font Entity
```dart
@collection
class Font {
  Id id = Isar.autoIncrement;
  String? name;        // Font-Identifier
  String? info;        // JSON-String mit Character-Mapping
}
```

### RateLimit Entity
```dart
@collection
class RateLimit {
  Id id = Isar.autoIncrement;
  int? userId;
  int? time;          // Format: YYYYMMDDHHmm
}
```

## HTML-Parsing Strategie

### Games Parser
- Extrahiert Spielinformationen aus HTML-Tabellen
- Verarbeitet `tr.visible-small` für Basis-Informationen
- Extrahiert Scores aus `td.column-score` mit Font-Dekodierung
- Handhabt verschiedene Spalten-Layouts für Teams/Logos

### Table Parser
- Parst Ligatabellen aus HTML `<tr>` Elementen
- Identifiziert Aufstiegs-/Abstiegsplätze durch CSS-Klassen
- Extrahiert komplette Statistiken (Spiele, Siege, Tore, etc.)

### Club Parser
- Extrahiert Team-Listen aus Vereinsseiten
- Verarbeitet Team-IDs, Namen und Liga-Informationen

## Fehlerbehandlung

### Standard-Fehlerformat
```json
{
  "success": false,
  "data": [],
  "message": "Fehlerbeschreibung"
}
```

### HTTP-Statuscodes
- **200**: Erfolgreiche Anfrage
- **400**: Bad Request (z.B. ungültige ID)
- **401**: Unauthorized (Token fehlt/ungültig)
- **404**: Route nicht gefunden
- **429**: Rate Limit überschritten

## Deployment

### PM2 Konfiguration (ecosystem.config.json)
```json
{
  "apps": [{
    "name": "api-dart",
    "script": "dart",
    "args": "run bin/server.dart",
    "env": {
      "PORT": "8080"
    }
  }]
}
```

### GitHub Actions CI/CD
- Automatische Tests bei Pull Requests
- Deployment nur vom main-Branch
- Test-Suite mit echten fussball.de Daten

## Utility-Scripts

### bin/backup.dart
- Exportiert alle Benutzer in users.json
- Backup-Funktionalität für User-Datenbank

### bin/dump.dart
- Importiert Benutzer aus users.json
- Restore-Funktionalität für User-Datenbank

### bin/clear.dart
- Löscht alle Font-Cache-Einträge
- Maintenance-Tool für Font-Datenbank

## Performance-Optimierungen

1. **Font-Caching**: Einmal dekodierte Fonts werden dauerhaft gespeichert
2. **Runtime-Cache**: ScoreFont hält Fonts im Memory während der Request-Verarbeitung
3. **Parallele Requests**: Future.wait() für gleichzeitige API-Calls
4. **Embedded Database**: Isar bietet schnelle lokale Datenzugriffe

## Testing

### Test-Strategie
- Unit-Tests für HTML-Parser
- Integration-Tests für API-Endpunkte
- Font-Dekodierung Tests
- Rate-Limiting Tests
- Authentifizierungs-Tests

### Test-Ausführung
```bash
dart test -j 1  # Single-Process wegen Datenbank-Zugriff
```

## Besondere Herausforderungen

1. **Font-Obfuskation**: Kreative Lösung mit ttx-Tool für WOFF-Dekodierung
2. **Rate-Limiting**: Minutengenaue Zeitfenster ohne externe Dependencies
3. **HTML-Parsing**: Robustes Parsing trotz sich ändernder Website-Struktur
4. **Token-Generierung**: Sichere Token mit eingebettetem Timestamp

## Monitoring & Logging

- Shelf-Middleware loggt alle Requests mit Zeitstempel und Dauer
- Sentry-Integration für Error-Tracking (optional)
- Strukturierte Logs im Server-Output

## Sicherheitshinweise

1. Token sollten sicher aufbewahrt werden (keine Wiederherstellung möglich)
2. Rate-Limits schützen vor Missbrauch
3. Keine persönlichen Daten werden gespeichert (nur E-Mail & Token)
4. HTTPS sollte im Production-Einsatz verwendet werden

## Wartung

### Font-Cache leeren
```bash
dart run bin/clear.dart
```

### User-Backup erstellen
```bash
dart run bin/backup.dart
```

### User wiederherstellen
```bash
dart run bin/dump.dart
```

## Abhängigkeiten

### Externe Tools
- **ttx** (fonttools): Muss auf dem System installiert sein für Font-Dekodierung
- **bash**: Für Shell-Command-Ausführung

### Dart Packages
- shelf: Web-Server Framework
- shelf_router: URL-Routing
- http: HTTP-Client
- html: HTML-Parsing
- isar: NoSQL-Datenbank
- xml: XML-Parsing für Font-Dateien
- sprintf: String-Formatierung
- email_validator: E-Mail-Validierung
- sentry: Error-Tracking (optional)

## Lizenz & Rechtliches

Dieses Tool dient ausschließlich zu Bildungs- und Informationszwecken. Die Nutzung erfolgt auf eigene Verantwortung. Beachten Sie die Nutzungsbedingungen von fussball.de.