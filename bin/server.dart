import 'dart:io';

import 'package:api_fussball_dart/controller/games.dart';
import 'package:api_fussball_dart/crawler/http_client_brige.dart';
import 'package:api_fussball_dart/entities/user.dart';
import 'package:isar/isar.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart';
import 'package:shelf_router/shelf_router.dart';

var gamesController = GamesController(HttpClientBrige());

class DatabaseSingleton {
  static Isar? _isarInstance;

  static Future<Isar> get isarInstance async {
    if (_isarInstance == null) {
      final dir = Directory.current.path;
      _isarInstance = await Isar.open(
        [UserSchema],
        directory: dir,
      );
    }
    return _isarInstance!;
  }
}

Middleware ensureHeaderMiddleware(String headerName, String expectedValue) {
  return (Handler innerHandler) {
    return (Request request) async {



      String? token = request.headers['x-auth-token'];
      if(token == null) {
        return Response.forbidden('No token provided');
      }

      final isar = await DatabaseSingleton.isarInstance;
      final user = await isar.users.where().filter().tokenEqualTo(token).findFirst();
      if (user == null) {
        return Response.forbidden('token falsch');
      }

      return innerHandler(request);
    };
  };
}


// Configure routes.
final _router = Router()
  ..get('/',  _rootHandler)
  ..get('/echo/<message>', _echoHandler)
  ..get('/test/',  (Request request) => ensureHeaderMiddleware('custom-header', 'expected-value')(gamesController.nextGameAction)(request))
;


Response _rootHandler(Request req) {
  return Response.ok('Hello, World!\n');
}

Response _echoHandler(Request request) {
  final message = request.params['message'];
  return Response.ok('$message\n');
}

Middleware jsonResponseMiddleware = createMiddleware(
  responseHandler: (Response response) {
    return response.change(headers: {'Content-Type': 'application/json'});
  },
);

void main(List<String> args) async {
  // Use any available host or container IP (usually `0.0.0.0`).
  final ip = InternetAddress.anyIPv4;

  // Configure a pipeline that logs requests.
  final handler = Pipeline()
      .addMiddleware(logRequests())
      .addMiddleware(jsonResponseMiddleware)
      .addHandler(_router);

  // For running in containers, we respect the PORT environment variable.
  final port = int.parse(Platform.environment['PORT'] ?? '8080');
  final server = await serve(handler, ip, port);
  print('Server listening on port ${server.port}');
}
