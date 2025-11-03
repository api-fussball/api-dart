# Bin Scripts - Kommandozeilen-Tools

Dieses Dokument beschreibt die ausführbaren Skripte im `bin/` Verzeichnis.

## Übersicht

```
bin/
├── server.dart    # Haupt-API-Server
├── backup.dart    # User-Datenbank Export
├── dump.dart      # User-Datenbank Import
└── clear.dart     # Cache-Verwaltung
```

---

## server.dart

**Zweck**: Haupt-API-Server für den Fußballdaten-Service

### Funktionalität

- Startet den HTTP-Server auf Port 8080 (oder `PORT` Umgebungsvariable)
- Registriert alle API-Routen und Endpunkte
- Konfiguriert Middleware-Pipeline:
  - `logRequests()` - Logging aller Anfragen
  - `jsonResponseMiddleware` - JSON Content-Type Header
  - `globalErrorMiddleware()` - Globale Fehlerbehandlung
  - `headerTokenCheckMiddleware()` - Token-Validierung für geschützte Routen

### Routen

**Öffentlich:**
- `POST /auth/register` - Benutzerregistrierung
- `POST /api/auth/register` - Alternative Registrierung

**Geschützt (benötigen x-auth-token):**
- `GET /api/club/{id}` - Vereinsteams abrufen
- `GET /api/club/info/{id}` - Vereinsübersicht
- `GET /api/club/next_games/{id}` - Kommende Vereinsspiele
- `GET /api/club/prev_games/{id}` - Vergangene Vereinsspiele
- `GET /api/team/{id}` - Team-Übersicht
- `GET /api/team/next_games/{id}` - Kommende Team-Spiele
- `GET /api/team/prev_games/{id}` - Vergangene Team-Spiele
- `GET /api/team/table/{id}` - Tabellenstand

### Ausführung

```bash
dart run bin/server.dart
```

**Mit PM2 (Production):**
```bash
pm2 start ecosystem.config.json
```

### Konfiguration

- **PORT**: Umgebungsvariable für Port-Konfiguration (Standard: 8080)
- **IP**: Bindet an alle IPv4-Adressen (`InternetAddress.anyIPv4`)

---

## backup.dart

**Zweck**: Exportiert alle registrierten Benutzer in eine JSON-Datei

### Funktionalität

- Liest alle User aus der Isar-Datenbank
- Erstellt eine JSON-Datei mit E-Mail/Token-Mapping
- Speichert in `users.json` im Hauptverzeichnis

### Ausführung

```bash
dart run bin/backup.dart
```

### Output-Format (users.json)

```json
{
  "user1@example.com": "29-stelliger-token-hier",
  "user2@example.com": "anderer-token-hier"
}
```

### Anwendungsfälle

- Regelmäßige Backups vor Updates
- Migration zu neuem Server
- Disaster Recovery

---

## dump.dart

**Zweck**: Importiert Benutzer aus einer JSON-Datei in die Datenbank

### Funktionalität

- Liest `users.json` aus dem Hauptverzeichnis
- Importiert alle E-Mail/Token-Paare in die Datenbank
- Überschreibt bestehende Benutzer mit gleicher E-Mail

### Ausführung

```bash
dart run bin/dump.dart
```

### Voraussetzungen

- Datei `users.json` muss existieren
- Format muss mit backup.dart kompatibel sein

### Fehlerbehandlung

Wirft Exception, wenn `users.json` nicht existiert:
```
Exception: File users.json does not exist
```

### Anwendungsfälle

- Wiederherstellung nach Datenverlust
- Initiales Setup auf neuem Server
- Migration von anderem System

---

## clear.dart

**Zweck**: Löscht zwischengespeicherte Font-Daten und Rate-Limit-Einträge

### Funktionalität

- Löscht alle Font-Einträge aus der Datenbank
- Löscht alle Rate-Limit-Einträge
- Gibt IDs der gelöschten Fonts aus

### Ausführung

```bash
dart run bin/clear.dart
```

### Was wird gelöscht?

1. **Font-Cache**: Alle dekodierten Font-Mappings
2. **Rate-Limits**: Alle Request-Zähler

### Anwendungsfälle

- Nach Font-Updates auf fussball.de
- Bei Problemen mit Font-Dekodierung
- Wartungsarbeiten / Cleanup
- Rate-Limit-Reset für alle Benutzer

### Hinweis

⚠️ **Vorsicht**: Nach dem Löschen müssen Fonts bei der nächsten Anfrage neu heruntergeladen und dekodiert werden, was Performance-Einbußen verursachen kann.

---

## Zusammenfassung

| Script | Funktion | Häufigkeit |
|--------|----------|------------|
| `server.dart` | API-Server starten | Dauerhaft laufend |
| `backup.dart` | User-Export | Regelmäßig (täglich/wöchentlich) |
| `dump.dart` | User-Import | Bei Bedarf |
| `clear.dart` | Cache leeren | Bei Problemen/Wartung |

## Wartungsworkflow

**Regelmäßige Backups:**
```bash
# Cron-Job für tägliche Backups
0 2 * * * cd /path/to/project && dart run bin/backup.dart
```

**System-Update Workflow:**
```bash
# 1. Backup erstellen
dart run bin/backup.dart

# 2. Update durchführen
git pull
dart pub get

# 3. Bei Problemen: Restore
dart run bin/dump.dart
```

**Cache-Probleme beheben:**
```bash
# Alle Caches leeren
dart run bin/clear.dart

# Server neu starten
pm2 restart api-dart
```
