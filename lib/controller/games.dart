import 'dart:convert';

import 'package:api_fussball_dart/crawler/http_client_brige.dart';
import 'package:api_fussball_dart/html/games.dart';
import 'package:shelf/shelf.dart';


class ResponseDto {
  late String message = '';
  late bool success;
  late List<dynamic> data;
}

class GamesController {
  final HttpClientBrige httpClientBrige;

  GamesController(this.httpClientBrige);

  Future<Response> nextGameAction(Request request) async{

    String html = await httpClientBrige.fetchData('/ajax.club.next.games/-/id/00ES8GN91400002IVV0AG08LVUPGND5I/mode/PAGE');
    List<ClubMatchInfoTransfer> clubMatchInfoTransfers = parseHTML(html);

    return Response.ok(jsonEncode(clubMatchInfoTransfers));
  }
}
