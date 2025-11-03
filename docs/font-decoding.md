# Font-Dekodierung - Kernfunktionalität

## Problem

Fussball.de verschleiert Spielergebnisse durch eine spezielle **Font-Obfuskation**. Die Zahlen werden nicht als normale Zeichen übertragen, sondern als Unicode-Zeichen, die über eine spezielle WOFF-Font auf die richtigen Ziffern gemappt werden.

### Beispiel

**HTML-Code:**
```html
<span data-obfuscation="font123" style="font-family: 'font123';">
  &#xe001;&#xe005;
</span>
```

**Sichtbar im Browser**: `15` (durch Font-Rendering)

**Tatsächlicher Inhalt**: `xe001xe005` (Unicode-Zeichen)

---

## Lösung: 3-Schritt-Prozess

```
┌─────────────────────────────────────────────┐
│  1. WOFF-Font von fussball.de herunterladen │
└──────────────────┬──────────────────────────┘
                   │
                   ▼
┌─────────────────────────────────────────────┐
│  2. TTX-Konvertierung (WOFF → XML)          │
│     Extrahiert Character-Mapping            │
└──────────────────┬──────────────────────────┘
                   │
                   ▼
┌─────────────────────────────────────────────┐
│  3. Mapping speichern & Score dekodieren    │
│     Unicode → echte Ziffer                  │
└─────────────────────────────────────────────┘
```

---

## Implementierung

### 1. FontProxy Pattern (lib/html/font.dart)

```dart
class FontProxy implements FontInterface {
  Map<String, Map<String, String>> runtimeCache = {};

  Future<Map<String, String>> decodeFont(String fontName) async {
    // 1. Runtime-Cache prüfen
    if (runtimeCache.containsKey(fontName)) {
      return runtimeCache[fontName]!;
    }

    // 2. Datenbank-Cache prüfen
    var cachedFont = await FontManager().findByName(fontName);
    if (cachedFont != null) {
      runtimeCache[fontName] = cachedFont;
      return cachedFont;
    }

    // 3. Font herunterladen und dekodieren
    return await downloadAndDecodeFont(fontName);
  }
}
```

**Caching-Strategie**:
- **Level 1**: Runtime-Cache (Map in Memory)
- **Level 2**: Datenbank-Cache (Isar)
- **Level 3**: Download von fussball.de

---

### 2. Font-Download

**URL-Pattern**:
```
https://www.fussball.de/export.fontface/-/format/woff/id/{fontName}/type/font
```

**Beispiel**:
```
https://www.fussball.de/export.fontface/-/format/woff/id/font123/type/font
```

**Implementierung**:
```dart
Future<String> downloadFont(String fontName) async {
  final url = 'https://www.fussball.de/export.fontface/-/format/woff/id/$fontName/type/font';
  final response = await http.get(Uri.parse(url));

  if (response.statusCode != 200) {
    throw Exception('Failed to download font: $fontName');
  }

  // WOFF-Binärdaten speichern
  File fontFile = File('fonts/$fontName.woff');
  await fontFile.writeAsBytes(response.bodyBytes);

  return fontFile.path;
}
```

---

### 3. TTX-Konvertierung

**Tool**: [FontTools TTX](https://github.com/fonttools/fonttools)

**Installation**:
```bash
pip install fonttools
```

**Konvertierung**:
```bash
ttx -t cmap fonts/font123.woff
```

**Output**: `fonts/font123.ttx` (XML-Datei)

**Beispiel TTX-Output**:
```xml
<?xml version="1.0" encoding="UTF-8"?>
<ttFont sfntVersion="\x00\x01\x00\x00" ttLibVersion="4.0">
  <cmap>
    <tableVersion version="0"/>
    <cmap_format_4 platformID="3" platEncID="1" language="0">
      <map code="0xe001" name="one"/>   <!-- Unicode → Ziffer-Name -->
      <map code="0xe002" name="two"/>
      <map code="0xe003" name="three"/>
      <map code="0xe004" name="four"/>
      <map code="0xe005" name="five"/>
      <map code="0xe006" name="six"/>
      <map code="0xe007" name="seven"/>
      <map code="0xe008" name="eight"/>
      <map code="0xe009" name="nine"/>
      <map code="0xe000" name="zero"/>
    </cmap_format_4>
  </cmap>
</ttFont>
```

**Dart-Implementierung**:
```dart
Future<String> convertWoffToTtx(String woffPath) async {
  final result = await Process.run('ttx', ['-t', 'cmap', woffPath]);

  if (result.exitCode != 0) {
    throw Exception('TTX conversion failed: ${result.stderr}');
  }

  return woffPath.replaceAll('.woff', '.ttx');
}
```

---

### 4. Character-Mapping-Extraktion

**Ziel**: XML parsen und Mapping erstellen

**Implementierung**:
```dart
Map<String, String> extractCharacterMapping(String ttxPath) {
  final file = File(ttxPath);
  final xmlString = file.readAsStringSync();
  final document = XmlDocument.parse(xmlString);

  Map<String, String> mapping = {};

  // Alle <map> Elemente finden
  final mapElements = document.findAllElements('map');

  for (var element in mapElements) {
    String? unicode = element.getAttribute('code');    // "0xe001"
    String? name = element.getAttribute('name');       // "one"

    if (unicode != null && name != null) {
      // Unicode-Hex zu Dart-String
      String unicodeKey = unicode.replaceAll('0x', '').toLowerCase();

      // Name zu Ziffer konvertieren
      String digit = _nameToDigit(name);

      mapping[unicodeKey] = digit;
    }
  }

  return mapping;
}

String _nameToDigit(String name) {
  const nameMap = {
    'zero': '0', 'one': '1', 'two': '2', 'three': '3', 'four': '4',
    'five': '5', 'six': '6', 'seven': '7', 'eight': '8', 'nine': '9'
  };
  return nameMap[name] ?? name;
}
```

**Resultat**:
```dart
{
  "e001": "1",
  "e002": "2",
  "e003": "3",
  "e004": "4",
  "e005": "5",
  "e006": "6",
  "e007": "7",
  "e008": "8",
  "e009": "9",
  "e000": "0"
}
```

---

### 5. Datenbank-Speicherung

**Speichern des Mappings**:
```dart
Future<void> saveMapping(String fontName, Map<String, String> mapping) async {
  await FontManager().save(fontName, mapping);
}
```

**Datenbank-Struktur**:
```dart
Font {
  id: 1,
  name: "font123",
  info: '{"e001":"1","e002":"2",...}'  // JSON-String
}
```

---

### 6. Score-Dekodierung (ScoreFont)

**Hauptklasse**: `ScoreFont` in `lib/html/font.dart`

```dart
class ScoreFont {
  FontInterface fontProxy;

  Future<String> getScore(String fontName, String encodedScore) async {
    // 1. Font-Mapping laden (mit Caching)
    Map<String, String> mapping = await fontProxy.decodeFont(fontName);

    // 2. Unicode-Zeichen extrahieren
    // encodedScore = "xe001;xe005;" (aus HTML: "&#xe001;&#xe005;")
    List<String> unicodeParts = encodedScore
        .split(';')
        .where((s) => s.isNotEmpty)
        .map((s) => s.replaceAll('x', '').toLowerCase())
        .toList();

    // 3. Jedes Unicode-Zeichen zu Ziffer konvertieren
    String decodedScore = '';
    for (var unicode in unicodeParts) {
      if (mapping.containsKey(unicode)) {
        decodedScore += mapping[unicode]!;
      } else {
        print('Warning: Unicode $unicode not found in mapping');
        decodedScore += '?';
      }
    }

    return decodedScore;  // "15"
  }
}
```

---

## Verwendung in Games-Parser

**HTML-Struktur** (fussball.de):
```html
<td class="column-score">
  <span data-obfuscation="font123" style="font-family: 'font123';">
    &#xe001;&#xe005;
  </span>
  :
  <span data-obfuscation="font123" style="font-family: 'font123';">
    &#xe002;
  </span>
</td>
```

**Parser-Code** (lib/html/games.dart):
```dart
Future<List<ClubMatchInfoTransfer>> parseHTML(String html, bool isPastGame) async {
  var document = parse(html);
  var scoreFont = ScoreFont(FontProxy());

  // Score-Spalte finden
  var scoreColumn = row.querySelector('td.column-score');
  if (scoreColumn != null && isPastGame) {
    // Font-Name extrahieren
    var obfuscationSpan = scoreColumn.querySelector('[data-obfuscation]');
    String? fontName = obfuscationSpan?.attributes['data-obfuscation'];

    if (fontName != null) {
      // Alle Score-Spans finden
      var scoreSpans = scoreColumn.querySelectorAll('span[data-obfuscation]');

      // Heim-Score
      String encodedHome = scoreSpans[0].innerHtml.replaceAll('&', '');
      String homeScore = await scoreFont.getScore(fontName, encodedHome);

      // Auswärts-Score
      String encodedAway = scoreSpans[1].innerHtml.replaceAll('&', '');
      String awayScore = await scoreFont.getScore(fontName, encodedAway);

      // Transfer-Object befüllen
      transfer.homeScore = homeScore;  // "1"
      transfer.awayScore = awayScore;  // "5"
    }
  }

  return transfers;
}
```

---

## Komplettbeispiel

**Szenario**: Score `2:1` dekodieren

```dart
// 1. HTML-Input
String html = '''
<span data-obfuscation="font_abc123">&#xe002;</span>
:
<span data-obfuscation="font_abc123">&#xe001;</span>
''';

// 2. Font-Proxy initialisieren
ScoreFont scoreFont = ScoreFont(FontProxy());

// 3. Score dekodieren
String homeScore = await scoreFont.getScore('font_abc123', 'xe002');  // "2"
String awayScore = await scoreFont.getScore('font_abc123', 'xe001');  // "1"

// 4. Ergebnis
print('$homeScore:$awayScore');  // Output: "2:1"
```

**Unter der Haube passiert**:
1. FontProxy prüft Runtime-Cache → miss
2. FontProxy prüft Datenbank → miss
3. FontProxy lädt `font_abc123.woff` herunter
4. TTX konvertiert zu `font_abc123.ttx`
5. XML-Parser extrahiert Mapping
6. Mapping wird in Datenbank gespeichert
7. Mapping wird in Runtime-Cache gelegt
8. Unicode `e002` → `"2"`, `e001` → `"1"`

**Nächster Request mit gleichem Font**:
1. FontProxy prüft Runtime-Cache → **HIT** ✓
2. Direkter Return ohne Download/Konvertierung

---

## Performance-Optimierung

### 1. Zweistufiges Caching

**Runtime-Cache** (Map):
- Extrem schnell (Memory-Zugriff)
- Lebt nur während Server-Laufzeit
- Verloren bei Restart

**Datenbank-Cache** (Isar):
- Persistent über Restarts
- Schneller als Download/Konvertierung
- Vermeidet wiederholte TTX-Aufrufe

### 2. Lazy Loading

Fonts werden nur dekodiert, wenn sie tatsächlich benötigt werden.

### 3. Parallele Verarbeitung

Bei mehreren Spielen mit unterschiedlichen Fonts:
```dart
// Alle Fonts parallel laden
var fontFutures = fontNames.map((name) =>
  fontProxy.decodeFont(name)
).toList();
await Future.wait(fontFutures);
```

---

## Error-Handling

### Font-Download fehlgeschlagen
```dart
try {
  await downloadFont(fontName);
} catch (e) {
  print('Font download failed: $e');
  return {'error': 'Download failed'};
}
```

### TTX nicht installiert
```dart
try {
  await Process.run('ttx', ['--version']);
} catch (e) {
  throw Exception('TTX not installed. Please run: pip install fonttools');
}
```

### Unbekanntes Unicode-Zeichen
```dart
if (!mapping.containsKey(unicode)) {
  print('Warning: Unicode $unicode not in font $fontName');
  return '?';  // Fallback
}
```

---

## Wartung

### Font-Cache leeren

**Manuell**:
```bash
dart run bin/clear.dart
```

**Automatisch bei Fehlern**:
```dart
if (decodedScore.contains('?')) {
  // Font könnte veraltet sein
  await FontManager().deleteAll();
  // Nächster Request lädt neu
}
```

### Font-Updates erkennen

Fussball.de kann Font-Namen ändern:
- `font123` → `font124` (neue Season)
- System erkennt automatisch neuen Namen
- Alter Font bleibt in DB (kein Problem)

---

## Debugging

### Font-Mapping anzeigen
```dart
var mapping = await FontManager().findByName('font123');
print(jsonEncode(mapping));
```

### Alle cached Fonts
```dart
final isar = await Database.isarInstance;
var allFonts = await isar.fonts.where().findAll();
for (var font in allFonts) {
  print('${font.name}: ${font.info}');
}
```

### TTX-Output manuell prüfen
```bash
ttx -t cmap fonts/font123.woff
cat fonts/font123.ttx
```

---

## Abhängigkeiten

**System-Abhängigkeiten**:
- `ttx` (FontTools) - **MUSS installiert sein!**
  ```bash
  pip install fonttools
  ```

**Dart-Packages**:
- `http` - Font-Download
- `xml` - TTX-Parsing
- `isar` - Font-Caching

**Ordnerstruktur**:
```
fonts/               # Muss existieren für WOFF/TTX-Dateien
├── font123.woff
├── font123.ttx
└── ...
```

---

## Testing

### Unit-Test für Font-Dekodierung
```dart
test('Font decoding with mock mapping', () async {
  var mockProxy = MockFontProxy();
  when(mockProxy.decodeFont('font123')).thenReturn({
    'e001': '1',
    'e002': '2'
  });

  var scoreFont = ScoreFont(mockProxy);
  var score = await scoreFont.getScore('font123', 'xe001;xe002');

  expect(score, equals('12'));
});
```

### Integration-Test mit echtem Font
```dart
test('Download and decode real font', () async {
  var scoreFont = ScoreFont(FontProxy());

  // Echter Font von fussball.de
  var score = await scoreFont.getScore('font123456789012', 'xe001;xe005');

  expect(score, matches(r'^\d+$'));  // Sollte Ziffern sein
});
```

---

## Zusammenfassung

| Komponente | Zweck | Performance |
|------------|-------|-------------|
| FontProxy | Caching & Download-Management | O(1) bei Cache-Hit |
| TTX Converter | WOFF → Character-Mapping | Einmalig pro Font |
| ScoreFont | Unicode → Ziffer | O(n) wobei n = Anzahl Ziffern |
| FontManager | Persistentes Caching | Sehr schnell (Isar) |

**Key Insight**: Die Font-Obfuskation ist eine kreative Anti-Scraping-Maßnahme, aber durch TTX-Dekodierung und intelligentes Caching vollständig umgehbar. Das System ist performant durch zweistufiges Caching und robust durch umfassendes Error-Handling.
