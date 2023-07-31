import 'dart:io';

import 'package:api_fussball_dart/controller/games.dart';
import 'package:api_fussball_dart/crawler/http_client_bridge.dart';
import 'package:api_fussball_dart/html/games.dart';
import 'package:api_fussball_dart/middleware.dart';

import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart';
import 'package:shelf_router/shelf_router.dart';

var gamesController = GamesController(httpClientBridge: HttpClientBridge(), games: Games());

// Configure routes.
final _router = Router()
  ..get('/',  _rootHandler)
  ..get('/echo/<message>', _echoHandler)
  ..get('/api/club/next_games/<id>',  (Request request) => headerTokenCheckMiddleware()(gamesController.nextGameAction)(request))
;


Response _rootHandler(Request req) {
  return Response.ok('Hello, World!\n');
}

Response _echoHandler(Request request) {
  final message = request.params['message'];
  return Response.ok('$message\n');
}

void main(List<String> args) async {
  final ip = InternetAddress.anyIPv4;

  final handler = Pipeline()
      .addMiddleware(logRequests())
      .addMiddleware(jsonResponseMiddleware)
      .addMiddleware(globalErrorMiddleware())
      .addHandler(_router);

  final port = int.parse(Platform.environment['PORT'] ?? '8080');
  final server = await serve(handler, ip, port);
  print('Server listening on port ${server.port}');
}
