# api-fussball.de - JSON API für fussball.de Daten

Eine REST-API, die Informationen von fussball.de als strukturierte JSON-Daten bereitstellt. Hole Spielergebnisse, kommende Spiele, Tabellen und Vereinsinformationen von deutschen Fußballmannschaften.

## 🌐 Vollständige Dokumentation

Die vollständige API-Dokumentation findest du unter:

**→ [https://www.api-fussball.de](https://www.api-fussball.de)**

Dort findest du:
- Schnellstart-Anleitung
- Alle verfügbaren Endpoints
- Request/Response-Beispiele
- Authentifizierung & Token-Erstellung
- Fehlerbehandlung

## 🚀 API Nutzen

### 1. Token erstellen

Erstelle einen kostenlosen API-Token unter: [https://www.api-fussball.de/token](https://www.api-fussball.de/token)

```bash
curl -X POST https://www.api-fussball.de/api/auth/register \
  -H "Content-Type: application/json" \
  -d '{"email":"deine@email.de"}'
```

### 2. API-Anfrage senden

Mit deinem Token kannst du die API nutzen:

```bash
# Nächste Spiele eines Vereins
curl -G https://www.api-fussball.de/api/club/next_games/{club_id} \
  -H "x-auth-token: dein_token"

# Ligatabelle eines Teams
curl -G https://www.api-fussball.de/api/team/table/{team_id} \
  -H "x-auth-token: dein_token"
```

### 3. Verfügbare Endpoints

- **Club (Verein):** `/api/club/{id}`, `/api/club/info/{id}`, `/api/club/next_games/{id}`, `/api/club/prev_games/{id}`
- **Team (Mannschaft):** `/api/team/{id}`, `/api/team/table/{id}`, `/api/team/next_games/{id}`, `/api/team/prev_games/{id}`

📖 **Vollständige Endpoint-Dokumentation:** [https://www.api-fussball.de/api-uebersicht](https://www.api-fussball.de/api-uebersicht)

## 💡 Wie finde ich die IDs?

Die benötigten `club_id` und `team_id` findest du auf fussball.de in der URL:

```
https://www.fussball.de/verein/[...]/id/[CLUB_ID]
https://www.fussball.de/mannschaft/[...]/team-id/[TEAM_ID]
```

📖 **Detaillierte Anleitung:** [https://www.api-fussball.de/fussballdeid](https://www.api-fussball.de/fussballdeid)

---

## 👨‍💻 Für Entwickler

Diese Dart-Anwendung ist die Backend-Implementation der api-fussball.de. Sie crawlt fussball.de und stellt die Daten als REST-API bereit.

### Lokale Entwicklung

**Server starten:**

```bash
dart run bin/server.dart
```

Server läuft auf Port 8080.

**Test-Anfrage:**

```bash
curl http://localhost:8080/api/club/next_games/00ES8GN91400002IVV0AG08LVUPGND5I
```

**Debug-Modus:**

```bash
dart run --observe bin/server.dart
```

### Tests ausführen

```bash
dart test -j 1
dart fix --dry-run
dart analyze
```

**Hinweis:** Tests laufen nur mit einem Prozess (`-j 1`), um DB-Konflikte zu vermeiden.

### Pull Requests

Vor einem Pull Request bitte ausführen:

```bash
dart test -j 1
dart fix --dry-run
dart analyze
```

Stelle sicher, dass alle Tests erfolgreich sind.

---

## 📚 Weitere Ressourcen

- **Dokumentation:** [https://www.api-fussball.de](https://www.api-fussball.de)
- **API Übersicht:** [https://www.api-fussball.de/api-uebersicht](https://www.api-fussball.de/api-uebersicht)
- **Issues & Support:** [https://github.com/api-fussball/api-dart/issues](https://github.com/api-fussball/api-dart/issues)

## 📄 Lizenz

Private Project


