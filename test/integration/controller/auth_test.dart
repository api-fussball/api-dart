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

  });


  test('send incorrect json', () async {
    AuthController authController = AuthController();
    MockRequest request = MockRequest('POST', Uri.parse('http://localhost/api/auth/register'));
    request.data = '{"}';

    Response response = await authController.register(request);

    expect(response.statusCode, 400);

    String message = await response.readAsString();

    Map<String, dynamic> content = jsonDecode(message);

    expect(content['success'], isFalse);
    expect(content['message'], 'Invalid JSON payload');
  });

  test('send json with incorrect email', () async {
    AuthController authController = AuthController();
    MockRequest request = MockRequest('POST', Uri.parse('http://localhost/api/auth/register'));
    request.data = '{"email":"unit@test"}';

    Response response = await authController.register(request);

    expect(response.statusCode, 400);

    String message = await response.readAsString();

    Map<String, dynamic> content = jsonDecode(message);

    expect(content['success'], isFalse);
    expect(content['message'], 'Email unit@test is not valid');
  });

  test('send json without email', () async {
    AuthController authController = AuthController();
    MockRequest request = MockRequest('POST', Uri.parse('http://localhost/api/auth/register'));
    request.data = '{"name":"John Doe"}';

    Response response = await authController.register(request);

    expect(response.statusCode, 400);

    String message = await response.readAsString();

    Map<String, dynamic> content = jsonDecode(message);

    expect(content['success'], isFalse);
    expect(content['message'], 'Field email not found');
  });

  test('create user with token', () async {
    await deleteUserByEmail('john@doe.de');

    AuthController authController = AuthController();
    Request request = MockRequest('POST', Uri.parse('http://localhost/api/auth/register'));

    Response response = await authController.register(request);

    expect(response.statusCode, 200);

    String message = await response.readAsString();

    Map<String, dynamic> content = jsonDecode(message);

    expect(content['success'], isTrue);
    expect(content['message'], 'Please copy the token. After leaving the page, copying again is not possible.');
    expect(content['data']['email'], 'john@doe.de');

    String token = content['data']['token'];
    expect(token.length, 42);

    User? user = await findUserByToken(token);
    expect(user!.email, content['data']['email']);
    expect(user.token, token);
  });

  test('create user with token and check if another user works', () async {
    await saveUser('test@unit.com', 'unit_test_token');

    AuthController authController = AuthController();
    Request request = MockRequest('POST', Uri.parse('http://localhost/api/auth/register'));

    Response response = await authController.register(request);

    expect(response.statusCode, 200);

    User? existUser = await findUserByToken('unit_test_token');
    expect(existUser!.email, 'test@unit.com');
  });


}
