import 'dart:convert';

import 'package:api_fussball_dart/crawler/http_client_bridge.dart';
import 'package:api_fussball_dart/dto/club_match_info_transfer.dart';
import 'package:api_fussball_dart/html/games.dart';
import 'package:api_fussball_dart/dto/response_dto.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';


class GamesController {
  final HttpClientBridge httpClientBridge;
  final GamesInterface games;

  GamesController({required this.httpClientBridge, required this.games});

  Future<Response> nextGameAction(Request request) async{

    var id = request.params['id'];
    String html = await httpClientBridge.fetchData('/ajax.club.next.games/-/id/$id/mode/PAGE');
    List<ClubMatchInfoTransfer> clubMatchInfoTransfers = games.parseHTML(html);

    ResponseSuccessDto responseSuccessDto = ResponseSuccessDto(clubMatchInfoTransfers);

    return Response.ok(jsonEncode(responseSuccessDto));
  }
}
