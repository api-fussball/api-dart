import 'dart:convert';

import 'package:api_fussball_dart/controller/auth.dart';
import 'package:api_fussball_dart/database.dart';
import 'package:api_fussball_dart/entities/user.dart';
import 'package:shelf/shelf.dart';
import 'package:test/test.dart';


class MockRequest extends Request{
  MockRequest(super.method, super.requestedUri);

  String data = '{"email":"john@doe.de"}';

  @override
  Future<String> readAsString([Encoding? encoding]) async {
    return data;
  }
}

void main() {

  setUp(() async {

  });

  tearDown(() async {
    await deleteUserByEmail('john@doe.de');
  });


  test('delete all fonts', () async {

    FontManager fontManager = FontManager();
    await fontManager.save('test', {'test': 'test'});
    await fontManager.save('unit', {'unit': 'unit'});

    await fontManager.deleteAll();

    Map<String, String>? fontTest = await fontManager.findByName('test');

    expect(fontTest, null);

    Map<String, String>? fontUnit = await fontManager.findByName('unit');

    expect(fontUnit, null);
  });



}
