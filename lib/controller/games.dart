import 'dart:convert';

import 'package:api_fussball_dart/crawler/http_client_brige.dart';
import 'package:api_fussball_dart/html/games.dart';
import 'package:api_fussball_dart/response_dto.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';


class GamesController {
  final HttpClientBrige httpClientBrige;

  GamesController(this.httpClientBrige);

  Future<Response> nextGameAction(Request request) async{

    var id = request.params['id'];
    String html = await httpClientBrige.fetchData('/ajax.club.next.games/-/id/$id/mode/PAGE');
    List<ClubMatchInfoTransfer> clubMatchInfoTransfers = parseHTML(html);

    ResponseSuccessDto responseSuccessDto = ResponseSuccessDto(clubMatchInfoTransfers);

    return Response.ok(jsonEncode(responseSuccessDto));
  }
}
