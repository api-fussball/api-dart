import 'dart:convert';

import 'package:api_fussball_dart/database.dart';
import 'package:api_fussball_dart/entities/user.dart';
import 'package:api_fussball_dart/dto/response_dto.dart';
import 'package:shelf/shelf.dart';

Middleware headerTokenCheckMiddleware() {
  return (Handler innerHandler) {
    return (Request request) async {

      String? token = request.headers['x-auth-token'];
      if(token == null) {
        ResponseErrorDto responseErrorDto = ResponseErrorDto('Token in header: "x-auth-token" not found');
        return Response.unauthorized(jsonEncode(responseErrorDto), headers: {'Content-Type': 'application/json'});
      }

      User? user = await findUserByToken(token);
      if (user == null) {
        ResponseErrorDto responseErrorDto = ResponseErrorDto('Token $token not found');
        return Response.unauthorized(jsonEncode(responseErrorDto), headers: {'Content-Type': 'application/json'});
      }

      int rateLimit = await RateLimitManager().get(user.id);
      if(rateLimit > 30) {
        ResponseErrorDto responseErrorDto = ResponseErrorDto('You are allowed a maximum of 30 queries per minute. Please try again later.');
        return Response(429, body: jsonEncode(responseErrorDto), headers: {'Content-Type': 'application/json'});
      }
      await RateLimitManager().add(user.id);

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
