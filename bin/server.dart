import 'dart:io';

import 'package:api_fussball_dart/controller/api.dart';
import 'package:api_fussball_dart/crawler/http_client_bridge.dart';
import 'package:api_fussball_dart/html/games.dart';
import 'package:api_fussball_dart/middleware.dart';

import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart';
import 'package:shelf_router/shelf_router.dart';

var gamesController = ApiController(httpClientBridge: HttpClientBridge(), games: Games());

// Configure routes.
final _router = Router()
  ..get('/',  _rootHandler)
  ..get('/echo/<message>', _echoHandler)
  ..get('/api/club/<id>',  (Request request) => headerTokenCheckMiddleware()(gamesController.clubAction)(request))
  ..get('/api/club/info/<id>',  (Request request) => headerTokenCheckMiddleware()(gamesController.clubInfoAction)(request))
  ..get('/api/club/next_games/<id>',  (Request request) => headerTokenCheckMiddleware()(gamesController.nextGameAction)(request))
  ..get('/api/club/prev_games/<id>',  (Request request) => headerTokenCheckMiddleware()(gamesController.prevGameAction)(request))
  ..get('/api/team/next_games/<id>',  (Request request) => headerTokenCheckMiddleware()(gamesController.nextTeamAction)(request))
  ..get('/api/team/prev_games/<id>',  (Request request) => headerTokenCheckMiddleware()(gamesController.prevTeamAction)(request))
  ..get('/api/team/table/<id>',  (Request request) => headerTokenCheckMiddleware()(gamesController.tableAction)(request))
  ..get('/api/team/<id>',  (Request request) => headerTokenCheckMiddleware()(gamesController.teamAction)(request))
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
