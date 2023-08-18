import 'dart:convert';
import 'dart:async';
import 'dart:math';

import 'package:api_fussball_dart/database.dart';
import 'package:api_fussball_dart/dto/response_dto.dart';
import 'package:email_validator/email_validator.dart';
import 'package:shelf/shelf.dart';

class AuthController {
  static const int tokenLength = 29;
  static const String characters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';

  Future<Response> register(Request request) async {
    final payload = await request.readAsString();

    Map<String, dynamic> content;
    try {
      content = jsonDecode(payload);
    } catch (e) {
      return _errorResponse('Invalid JSON payload');
    }

    if (content['email'] == null) {
      return _errorResponse('Field email not found');
    }

    if (!EmailValidator.validate(content['email'])) {
      return _errorResponse('Email ${content["email"]} is not valid');
    }

    String token = _generateRandomToken();
    await saveUser(content['email'], token);
    content['token'] = token;

    ResponseAuthDto responseAuthDto = ResponseAuthDto(
      'Please copy the token. After leaving the page, copying again is not possible.',
      content,
    );

    return Response.ok(jsonEncode(responseAuthDto), headers: {'Content-Type': 'application/json'});
  }

  Response _errorResponse(String message) {
    ResponseErrorDto responseErrorDto = ResponseErrorDto(message);
    return Response.badRequest(body: jsonEncode(responseErrorDto), headers: {'Content-Type': 'application/json'});
  }

  String _generateRandomToken() {
    final random = Random();
    String token = List.generate(tokenLength, (index) => characters[random.nextInt(characters.length)]).join();
    return _mixTimestampWithToken(token);
  }

  String _mixTimestampWithToken(String token) {
    final timestamp = DateTime.now().millisecondsSinceEpoch.toString();
    final mixedToken = StringBuffer();

    for (int i = 0; i < max(token.length, timestamp.length); i++) {
      if (i < token.length) {
        mixedToken.write(token[i]);
      }
      if (i < timestamp.length) {
        mixedToken.write(timestamp[i]);
      }
    }

    return mixedToken.toString();
  }
}
