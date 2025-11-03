# API Fussball Dart - Dokumentation

Willkommen zur Dokumentation des API Fussball Dart Projekts!

## Was ist dieses Projekt?

Ein Web-Scraping-Service für Fußballdaten von fussball.de. Das System extrahiert Spielinformationen, Tabellenstände und Vereinsdaten und stellt diese über eine REST API zur Verfügung.

**Besonderheit**: Löst die Font-Obfuskation von fussball.de durch TTX-basierte WOFF-Dekodierung.

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

## Dokumentationsstruktur

### 📁 [bin-scripts.md](bin-scripts.md)
**Kommandozeilen-Tools**
- `server.dart` - Haupt-API-Server
- `backup.dart` - User-Datenbank Export
- `dump.dart` - User-Datenbank Import
- `clear.dart` - Cache-Verwaltung

### 📚 [lib-overview.md](lib-overview.md)
**Bibliotheksstruktur**
- Controller Layer (API-Handler)
- Crawler Layer (HTTP-Client)
- DTO Layer (Data Transfer Objects)
- Entities Layer (Datenbank-Modelle)
- HTML Parser Layer
- Database Layer
- Middleware Layer

### 🔐 [authentication.md](authentication.md)
**Authentifizierung & Rate-Limiting**
- Token-Generierung
- Token-Validierung
- Rate-Limiting (30 Requests/Minute)
- Sicherheitsaspekte

### 🔤 [font-decoding.md](font-decoding.md)
**Font-Dekodierung (Kernfunktionalität)**
- Problem: Font-Obfuskation
- Lösung: TTX-Konvertierung
- FontProxy Pattern
- Character-Mapping
- Performance-Optimierung

---

## Technologie-Stack

| Kategorie | Technologie | Verwendung |
|-----------|-------------|------------|
| Sprache | Dart 3.0.6+ | Backend |
| Web-Framework | Shelf | HTTP-Server |
| Routing | shelf_router | URL-Routing |
| Datenbank | Isar | NoSQL embedded DB |
| HTML-Parsing | html | DOM-Manipulation |
| Font-Tool | ttx (FontTools) | WOFF-Dekodierung |
| HTTP-Client | http | Web-Scraping |
| XML-Parsing | xml | Font-Analyse |

---

## Architektur-Übersicht

```
┌─────────────────────────────────────────────────────┐
│                    API Server                       │
│                  (bin/server.dart)                  │
│                                                     │
│  Middleware Pipeline:                              │
│  1. Logging                                        │
│  2. JSON Response                                  │
│  3. Global Error Handler                           │
│  4. Token Check + Rate Limit                       │
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

## API-Endpunkte Übersicht

### Öffentlich

| Methode | Endpunkt | Beschreibung |
|---------|----------|--------------|
| POST | `/auth/register` | Benutzerregistrierung + Token-Generierung |

### Geschützt (benötigen `x-auth-token` Header)

#### Verein-Endpunkte

| Methode | Endpunkt | Beschreibung |
|---------|----------|--------------|
| GET | `/api/club/{id}` | Alle Teams eines Vereins |
| GET | `/api/club/info/{id}` | Vereinsübersicht (Teams + Spiele) |
| GET | `/api/club/next_games/{id}` | Kommende Vereinsspiele |
| GET | `/api/club/prev_games/{id}` | Vergangene Vereinsspiele mit Scores |

#### Team-Endpunkte

| Methode | Endpunkt | Beschreibung |
|---------|----------|--------------|
| GET | `/api/team/{id}` | Team-Übersicht (Tabelle + Spiele) |
| GET | `/api/team/next_games/{id}` | Kommende Team-Spiele |
| GET | `/api/team/prev_games/{id}` | Vergangene Team-Spiele mit Scores |
| GET | `/api/team/table/{id}` | Tabellenstand der Liga |

**Hinweis**: Alle Scores werden automatisch durch Font-Dekodierung entschlüsselt!

---

## Datenbank-Schema

### User
```dart
{
  id: int (auto),
  email: string,
  token: string (29 Zeichen)
}
```

### Font
```dart
{
  id: int (auto),
  name: string,
  info: string (JSON mit Character-Mapping)
}
```

### RateLimit
```dart
{
  id: int (auto),
  userId: int,
  time: int (Format: YYYYMMDDHHmm)
}
```

---

## Font-Dekodierung (Highlight)

### Problem
Fussball.de verschleiert Spielergebnisse:
```html
<span data-obfuscation="font123">&#xe001;&#xe005;</span>
```
→ Zeigt "15" im Browser, aber HTML enthält verschleierte Unicode-Zeichen

### Lösung
```
1. WOFF-Font herunterladen
2. TTX-Konvertierung (WOFF → XML)
3. Character-Mapping extrahieren
4. In Datenbank cachen
5. Unicode → echte Ziffern dekodieren
```

**Ergebnis**: `xe001xe005` → `"15"`

Details siehe [font-decoding.md](font-decoding.md)

---

## Sicherheit

### Token-Authentifizierung
- Jeder API-Zugriff benötigt gültigen Token
- 29 Zeichen mit eingebettetem Timestamp
- Kryptographisch sicherer Zufallsgenerator

### Rate-Limiting
- **Limit**: 30 Anfragen pro Minute pro Benutzer
- **Zeitfenster**: Minutengenau (YYYYMMDDHHmm)
- **Response**: HTTP 429 bei Überschreitung

### Middleware-Stack
```
Request
  → Logging
  → JSON Response Header
  → Global Error Handler
  → Token Validation
  → Rate Limit Check
  → Handler
```

---

## Deployment

### PM2 (Production)

**ecosystem.config.json**:
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

**Befehle**:
```bash
pm2 start ecosystem.config.json
pm2 status
pm2 logs api-dart
pm2 restart api-dart
```

### GitHub Actions

- Automatische Tests bei Pull Requests
- Deployment nur vom main-Branch
- Test-Suite mit echten fussball.de Daten

---

## Utility-Scripts

```bash
# Server starten
dart run bin/server.dart

# User-Backup erstellen
dart run bin/backup.dart

# User wiederherstellen
dart run bin/dump.dart

# Font-Cache leeren
dart run bin/clear.dart
```

---

## Testing

```bash
# Alle Tests ausführen
dart test -j 1

# Spezifische Tests
dart test test/unit/html/
dart test test/integration/
dart test test/api/
```

**Hinweis**: `-j 1` ist wichtig wegen Datenbank-Zugriff (keine parallelen Tests)

---

## Performance

### Optimierungen

1. **Font-Caching**:
   - Runtime-Cache (Map in Memory)
   - Datenbank-Cache (Isar)
   - Einmal dekodiert, dauerhaft verfügbar

2. **Parallele Requests**:
   ```dart
   var results = await Future.wait([
     fetchClubs(),
     fetchPrevGames(),
     fetchNextGames()
   ]);
   ```

3. **Embedded Database**:
   - Isar bietet schnelle lokale Zugriffe
   - Keine Netzwerk-Latenz

---

## Troubleshooting

### Font-Dekodierung funktioniert nicht

**Problem**: TTX nicht installiert

**Lösung**:
```bash
pip install fonttools
ttx --version  # Prüfen
```

### Rate-Limit zu niedrig

**Lösung**: In `lib/middleware.dart` anpassen:
```dart
if (rateLimit > 100) {  // War: 30
  return Response(429, ...);
}
```

### Token funktioniert nicht

**Lösung**:
```bash
# Prüfe Datenbank
dart run bin/backup.dart
cat users.json

# Re-Registrierung
curl -X POST http://localhost:8080/auth/register \
  -H "Content-Type: application/json" \
  -d '{"email":"test@example.com"}'
```

---

## Wartung

### Regelmäßige Backups (Cron)
```bash
# Täglich um 2 Uhr morgens
0 2 * * * cd /path/to/project && dart run bin/backup.dart
```

### Cache-Cleanup (Cron)
```bash
# Täglich um 3 Uhr morgens
0 3 * * * cd /path/to/project && dart run bin/clear.dart
```

### System-Update Workflow
```bash
# 1. Backup
dart run bin/backup.dart

# 2. Update
git pull
dart pub get

# 3. Bei Problemen: Restore
dart run bin/dump.dart
```

---

## Entwicklung

### Neuen Endpunkt hinzufügen

1. **Controller-Methode** (`lib/controller/api.dart`):
   ```dart
   Future<Response> myAction(Request request) async {
     // Implementation
   }
   ```

2. **Route registrieren** (`bin/server.dart`):
   ```dart
   ..get('/api/my/<id>', (Request request) =>
     headerTokenCheckMiddleware()(controller.myAction)(request))
   ```

3. **Parser erstellen** (`lib/html/`):
   ```dart
   class MyParser {
     List<MyDto> parseHTML(String html) { ... }
   }
   ```

4. **Tests schreiben** (`test/`):
   ```dart
   test('My endpoint returns correct data', () async { ... });
   ```

---

## Lizenz & Rechtliches

Dieses Tool dient ausschließlich zu Bildungs- und Informationszwecken. Die Nutzung erfolgt auf eigene Verantwortung. Beachten Sie die Nutzungsbedingungen von fussball.de.

---

## Weitere Ressourcen

- [Dart Documentation](https://dart.dev/guides)
- [Shelf Package](https://pub.dev/packages/shelf)
- [Isar Database](https://isar.dev/)
- [FontTools TTX](https://github.com/fonttools/fonttools)

---

## Support

Bei Fragen oder Problemen:
1. Durchsuche die Dokumentation
2. Prüfe die Tests für Beispiele
3. Erstelle ein Issue auf GitHub

---

**Viel Erfolg mit dem API Fussball Dart Projekt! ⚽**
