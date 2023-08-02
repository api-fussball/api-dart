import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:sprintf/sprintf.dart';
import 'package:xml/xml.dart';

class Font {
  static const Map<String, String> map = {
    'hyphen': '-',
    'zero': '0',
    'one': '1',
    'two': '2',
    'three': '3',
    'four': '4',
    'five': '5',
    'six': '6',
    'seven': '7',
    'eight': '8',
    'nine': '9',
  };

  static const String url = 'https://www.fussball.de/export.fontface/-/format/woff/id/%s/type/font';
  static const String shellCommand = 'cd %s; ttx -t cmap %s';
  static const String convertFile = '%s/%s.ttx';
  static const String fontFilePath = '%s/%s.woff';

  http.Client client;

  Font(this.client);

  Future<Map<String, String>> decodeFont(String fontName) async {
    String url = sprintf(Font.url, [fontName]);

    String fontDir = '${Directory.current.path}/fonts';

    http.Response response = await client.get(Uri.parse(url));

    String fontWoff = sprintf(Font.fontFilePath, [fontDir, fontName]);

    final fontFile = File(fontWoff);
    await fontFile.writeAsBytes(response.bodyBytes);

    await Process.run('bash', ['-c', sprintf(Font.shellCommand, [fontDir, fontWoff])]);

    String convertFilePath = sprintf(Font.convertFile, [fontDir, fontName]);
    final convertFile = File(convertFilePath);

    XmlDocument domDocument = XmlDocument.parse(await convertFile.readAsString());

    Iterable<XmlElement> mapElements = domDocument.findAllElements('map');

    Map<String, String> info = {};

    for (XmlElement element in mapElements) {
      String code = element.getAttribute('code')!.substring(1);
      String name = element.getAttribute('name')!;

      info[code] = Font.map[name]!;
    }

    fontFile.delete();
    convertFile.delete();
    client.close();

    return info;
  }
}
