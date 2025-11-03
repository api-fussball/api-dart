# Technische Dokumentation - API Fussball Dart

## Projektübersicht

Diese API ist ein Web-Scraping-Service für Fußballdaten von fussball.de. Das System extrahiert Spielinformationen, Tabellenstände und Vereinsdaten und stellt diese über eine REST API zur Verfügung.

**Besonderheit**: Löst die Font-Obfuskation von fussball.de durch TTX-basierte WOFF-Dekodierung.

---

## 📚 Detaillierte Dokumentation

Die vollständige Dokumentation befindet sich im `docs/` Verzeichnis:

- **[docs/README.md](docs/README.md)** - Einstieg und Übersicht
- **[docs/bin-scripts.md](docs/bin-scripts.md)** - Kommandozeilen-Tools
- **[docs/lib-overview.md](docs/lib-overview.md)** - Bibliotheksstruktur
- **[docs/authentication.md](docs/authentication.md)** - Authentifizierung & Rate-Limiting
- **[docs/font-decoding.md](docs/font-decoding.md)** - Font-Dekodierung (Kernfunktionalität)

---

## Schnellstart

### Installation

```bash
# Dependencies installieren
dart pub get

# System-Abhängigkeit (für Font-Dekodierung)
pip install fonttools

# Server starten
dart run bin/server.dart
```

### Erste Schritte

1. **Registrieren**:
   ```bash
   curl -X POST http://localhost:8080/auth/register \
     -H "Content-Type: application/json" \
     -d '{"email":"test@example.com"}'
   ```

2. **Token kopieren** aus Response

3. **API aufrufen**:
   ```bash
   curl -H "x-auth-token: YOUR-TOKEN-HERE" \
     http://localhost:8080/api/club/012345678901234
   ```

---

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

---

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

**Mehr Details**: Siehe [docs/authentication.md](docs/authentication.md)

---

### Geschützte Endpunkte (Benötigen `x-auth-token` Header)

#### Verein-Endpunkte

| Endpunkt | Beschreibung |
|----------|--------------|
| `GET /api/club/{id}` | Alle Teams eines Vereins |
| `GET /api/club/info/{id}` | Vereinsübersicht mit Teams und Spielen |
| `GET /api/club/next_games/{id}` | Kommende Vereinsspiele |
| `GET /api/club/prev_games/{id}` | Vergangene Vereinsspiele mit Ergebnissen |

#### Team-Endpunkte

| Endpunkt | Beschreibung |
|----------|--------------|
| `GET /api/team/{id}` | Team-Übersicht mit Tabelle und Spielen |
| `GET /api/team/next_games/{id}` | Kommende Team-Spiele |
| `GET /api/team/prev_games/{id}` | Vergangene Team-Spiele mit Ergebnissen |
| `GET /api/team/table/{id}` | Tabellenstand der Liga |

**Beispiel-Response** (Vergangene Spiele mit dekodierten Scores):
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

---

## Font-Dekodierung (Besonderheit!)

### Problem
Fussball.de verschleiert Spielergebnisse durch eine spezielle Font-Obfuskation. Die Zahlen werden nicht als normale Zeichen übertragen, sondern als Unicode-Zeichen, die über eine spezielle WOFF-Font auf die richtigen Ziffern gemappt werden.

### Lösung

```
1. WOFF-Font von fussball.de herunterladen
   ↓
2. TTX-Konvertierung (WOFF → XML)
   ↓
3. Character-Mapping extrahieren
   ↓
4. In Datenbank cachen
   ↓
5. Unicode → echte Ziffern dekodieren
```

**Beispiel**:
```dart
// HTML enthält: <span data-obfuscation="font123">&#xe001;&#xe005;</span>
String score = await scoreFont.getScore("font123", "xe001;xe005");
// Rückgabe: "15"
```

**Vollständige Details**: Siehe [docs/font-decoding.md](docs/font-decoding.md)

---

## Sicherheitsmechanismen

### 1. Token-Authentifizierung
- Jeder API-Zugriff benötigt einen gültigen Token im `x-auth-token` Header
- Token sind 29 Zeichen lang mit eingebettetem Timestamp
- Kryptographisch sicherer Zufallsgenerator

### 2. Rate Limiting
- **Limit**: 30 Anfragen pro Minute pro Benutzer
- **Zeitfenster**: Minutengenau (YYYYMMDDHHmm)
- **Response bei Überschreitung**: HTTP 429 (Too Many Requests)

### 3. Middleware-Stack
```
Request → Logging → JSON Response → Error Handler → Token Check → Rate Limit → Handler
```

**Mehr Details**: Siehe [docs/authentication.md](docs/authentication.md)

---

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

---

## Utility-Scripts

### bin/server.dart
**Haupt-API-Server** - Startet den HTTP-Server mit allen Routen und Middleware

```bash
dart run bin/server.dart
# oder mit PM2:
pm2 start ecosystem.config.json
```

### bin/backup.dart
**User-Datenbank Export** - Exportiert alle Benutzer nach `users.json`

```bash
dart run bin/backup.dart
```

### bin/dump.dart
**User-Datenbank Import** - Importiert Benutzer aus `users.json`

```bash
dart run bin/dump.dart
```

### bin/clear.dart
**Cache-Verwaltung** - Löscht alle Font-Cache-Einträge und Rate-Limits

```bash
dart run bin/clear.dart
```

**Mehr Details**: Siehe [docs/bin-scripts.md](docs/bin-scripts.md)

---

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

---

## Testing

```bash
# Alle Tests ausführen (single-process wegen Datenbank)
dart test -j 1

# Spezifische Tests
dart test test/unit/html/
dart test test/integration/
dart test test/api/
```

---

## Performance-Optimierungen

1. **Font-Caching**: Einmal dekodierte Fonts werden dauerhaft gespeichert
   - Runtime-Cache (Memory)
   - Datenbank-Cache (Isar)

2. **Parallele Requests**: `Future.wait()` für gleichzeitige API-Calls
   ```dart
   var results = await Future.wait([clubs, prevGames, nextGames]);
   ```

3. **Embedded Database**: Isar bietet schnelle lokale Datenzugriffe

---

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

---

## Wartung

### Regelmäßige Backups (Cron)
```bash
# Täglich um 2 Uhr morgens
0 2 * * * cd /path/to/project && dart run bin/backup.dart
```

### Font-Cache leeren
```bash
dart run bin/clear.dart
```

### User wiederherstellen
```bash
dart run bin/dump.dart
```

---

## Abhängigkeiten

### Externe Tools
- **ttx** (fonttools): **MUSS installiert sein** für Font-Dekodierung
  ```bash
  pip install fonttools
  ```

### Dart Packages
- shelf: Web-Server Framework
- shelf_router: URL-Routing
- http: HTTP-Client
- html: HTML-Parsing
- isar: NoSQL-Datenbank
- xml: XML-Parsing für Font-Dateien
- sprintf: String-Formatierung
- email_validator: E-Mail-Validierung

---

## Besondere Herausforderungen

1. **Font-Obfuskation**: Kreative Lösung mit ttx-Tool für WOFF-Dekodierung
2. **Rate-Limiting**: Minutengenaue Zeitfenster ohne externe Dependencies
3. **HTML-Parsing**: Robustes Parsing trotz sich ändernder Website-Struktur
4. **Token-Generierung**: Sichere Token mit eingebettetem Timestamp

**Details zu jeder Komponente**: Siehe `docs/` Verzeichnis

---

## Lizenz & Rechtliches

Dieses Tool dient ausschließlich zu Bildungs- und Informationszwecken. Die Nutzung erfolgt auf eigene Verantwortung. Beachten Sie die Nutzungsbedingungen von fussball.de.

---

## Weitere Informationen

📖 **Vollständige Dokumentation**: [docs/README.md](docs/README.md)

- [Bin Scripts Details](docs/bin-scripts.md)
- [Lib Overview](docs/lib-overview.md)
- [Authentifizierung](docs/authentication.md)
- [Font-Dekodierung](docs/font-decoding.md)
