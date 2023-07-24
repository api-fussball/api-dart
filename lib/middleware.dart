import 'dart:convert';

import 'package:api_fussball_dart/database.dart';
import 'package:api_fussball_dart/entities/user.dart';
import 'package:api_fussball_dart/response_dto.dart';
import 'package:shelf/shelf.dart';

Middleware headerTokenCheckMiddleware() {
  return (Handler innerHandler) {
    return (Request request) async {

      String? token = request.headers['x-auth-token'];
      if(token == null) {
        ResponseErrorDto responseErrorDto = ResponseErrorDto('Token in header: "x-auth-token" not found');
        return Response.forbidden(jsonEncode(responseErrorDto), headers: {'Content-Type': 'application/json'});
      }

      User? user = await findUserByToken(token);
      if (user == null) {
        ResponseErrorDto responseErrorDto = ResponseErrorDto('Token $token not found');
        return Response.forbidden(jsonEncode(responseErrorDto), headers: {'Content-Type': 'application/json'});
      }

      return innerHandler(request);
    };
  };
}

Middleware jsonResponseMiddleware = createMiddleware(
  responseHandler: (Response response) {
    return response.change(headers: {'Content-Type': 'application/json'});
  },
);

Middleware globalErrorMiddleware() {
  return (Handler innerHandler) {
    return (Request request) async {
      try {
        return await innerHandler(request);
      } catch (e) {
        ResponseErrorDto responseErrorDto = ResponseErrorDto(e.toString());
        return Response.badRequest(body: jsonEncode(responseErrorDto), headers: {'Content-Type': 'application/json'});
      }
    };
  };
}
