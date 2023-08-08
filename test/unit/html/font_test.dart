import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:api_fussball_dart/html/font.dart';
import 'package:test/test.dart';


class MockRequest extends http.Request{
  MockRequest(super.method, super.url);
}

void main() {

  setUp(() async {

    var sourceFile = File('${Directory.current.path}/test/unit/_data/unit.ttx');
    var destinationFile = File('${Directory.current.path}/fonts/unit.ttx');

    await sourceFile.copy(destinationFile.path);
  });

  tearDown(() async {
    var testFile = File('${Directory.current.path}/fonts/unit.ttx');
    if (testFile.existsSync()) {
      testFile.deleteSync();
    }
  });

  test('Font decode', () async {

    final client = MockClient((request) async {
      if (request.url.path == 'https://www.fussball.de/export.fontface/-/format/woff/id/unit/type/font') {
        return http.Response('Unit', 200);
      } else {
        return http.Response('Not Found', 404);
      }
    });

    var font = Font();
    font.client = client;

    Map<String, String> result = await font.decodeFont('unit');

    expect(result['xe650'], '3');
    expect(result['xe651'], '3');
    expect(result['xe652'], '7');
    expect(result['xe654'], '5');
    expect(result['xe65a'], '0');
    expect(result['xe665'], '-');

  });
}
