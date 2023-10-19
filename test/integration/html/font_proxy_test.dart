import 'package:api_fussball_dart/database.dart';
import 'package:api_fussball_dart/html/font.dart';
import 'package:test/test.dart';

class MockFont implements FontInterface {
  @override
  Future<Map<String, String>> decodeFont(String fontName) async {
    return {
      'xe650': '3',
      'xe651': '3',
      'xe652': '7',
      'xe654': '5',
      'xe65a': '0',
      'xe665': '-',
    };
  }
}

class MockExceptionFont implements FontInterface {
  @override
  Future<Map<String, String>> decodeFont(String fontName) async {
    throw Exception('Not Exist');
  }
}

void main() {

  tearDown(() async {
    await FontManager().deleteAll();
  });

  test('Font proxy decode', () async {

    var font = FontProxy();
    font.font = MockFont();

    Map<String, String> result = await font.decodeFont('unit');

    expect(result['xe650'], '3');
    expect(result['xe651'], '3');
    expect(result['xe652'], '7');
    expect(result['xe654'], '5');
    expect(result['xe65a'], '0');
    expect(result['xe665'], '-');

    Map<String, String>? fontInfo = await FontManager().findByName('unit');

    expect(fontInfo!['xe650'], '3');
    expect(fontInfo['xe651'], '3');
    expect(fontInfo['xe652'], '7');
    expect(fontInfo['xe654'], '5');
    expect(fontInfo['xe65a'], '0');
    expect(fontInfo['xe665'], '-');
  });


  test('get font form db', () async {
    var info = await MockFont().decodeFont('unit');
    info['name'] = 'unit';
    await FontManager().save('unit', info);

    var font = FontProxy();
    font.font = MockExceptionFont();

    Map<String, String> result = await font.decodeFont('unit');
    expect(result['name'], 'unit');
    expect(result['xe650'], '3');
    expect(result['xe651'], '3');
    expect(result['xe652'], '7');
    expect(result['xe654'], '5');
    expect(result['xe65a'], '0');
    expect(result['xe665'], '-');
  });

}
