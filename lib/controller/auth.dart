import 'dart:convert';
import 'dart:async';
import 'dart:math';

import 'package:api_fussball_dart/database.dart';
import 'package:api_fussball_dart/dto/response_dto.dart';
import 'package:email_validator/email_validator.dart';
import 'package:shelf/shelf.dart';

class AuthController {

  Future<Response> register(Request request) async {

    final payload = await request.readAsString();
    Map<String, dynamic> content = jsonDecode(payload);

    if (content['email'] == null) {
      ResponseErrorDto responseErrorDto = ResponseErrorDto('Field email not found');
      return Response.badRequest(body: jsonEncode(responseErrorDto), headers: {'Content-Type': 'application/json'});
    }

    if(!EmailValidator.validate(content['email'])){
      String email = content["email"];
      ResponseErrorDto responseErrorDto = ResponseErrorDto('Email $email is not valid');
      return Response.badRequest(body: jsonEncode(responseErrorDto), headers: {'Content-Type': 'application/json'});
    }

    String token = _generateRandomToken();

    saveUser(content['email'], token);

    content['token'] = token;

    ResponseAuthDto responseAuthDto = ResponseAuthDto(
        'Please copy the token. After leaving the page, copying again is not possible.',
        content
    );

    return Response.ok(jsonEncode(responseAuthDto));
  }

  String _generateRandomToken() {
    int length = 29;
    const characters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
    final random = Random();
    String token = List.generate(length, (index) => characters[random.nextInt(characters.length)]).join();

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
