import 'dart:convert';
import 'dart:async';

import 'package:api_fussball_dart/crawler/http_client_bridge.dart';
import 'package:api_fussball_dart/dto/club_match_info_transfer.dart';
import 'package:api_fussball_dart/dto/club_team_info_transfer.dart';
import 'package:api_fussball_dart/html/club.dart';
import 'package:api_fussball_dart/html/games.dart';
import 'package:api_fussball_dart/dto/response_dto.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

class ApiController {
  final HttpClientBridge httpClientBridge;
  final GamesInterface games;
  final Club club = Club();

  ApiController({required this.httpClientBridge, required this.games});

  Future<Response> clubAction(Request request) async {
    var id = request.params['id'];

    String html = await httpClientBridge
        .fetchData('/ajax.club.teams/-/action/search/id/$id');
    List<ClubTeamInfoTransfer> clubTeamInfoTransfer = club.parseHTML(html);

    ResponseSuccessDto responseSuccessDto =
        ResponseSuccessDto(clubTeamInfoTransfer);

    return Response.ok(jsonEncode(responseSuccessDto));
  }

  Future<Response> clubInfoAction(Request request) async {
    var id = request.params['id'];

    var clubs =
        httpClientBridge.fetchData('/ajax.club.teams/-/action/search/id/$id');
    var prevGames =
        httpClientBridge.fetchData('/ajax.club.prev.games/-/id/$id/mode/PAGE');
    var nextGames =
        httpClientBridge.fetchData('/ajax.club.next.games/-/id/$id/mode/PAGE');

    var results = await Future.wait([clubs, prevGames, nextGames]);

    ResponseInfoSuccessDto responseSuccessDto = ResponseInfoSuccessDto(
        club.parseHTML(results[0]),
        await games.parseHTML(results[1], true),
        await games.parseHTML(results[2], false));

    return Response.ok(jsonEncode(responseSuccessDto));
  }

  Future<Response> nextGameAction(Request request) async {
    var id = request.params['id'];
    String html = await httpClientBridge
        .fetchData('/ajax.club.next.games/-/id/$id/mode/PAGE');
    List<ClubMatchInfoTransfer> clubMatchInfoTransfers =
        await games.parseHTML(html, false);

    ResponseSuccessDto responseSuccessDto =
        ResponseSuccessDto(clubMatchInfoTransfers);

    return Response.ok(jsonEncode(responseSuccessDto));
  }

  Future<Response> prevGameAction(Request request) async {
    var id = request.params['id'];
    String html = await httpClientBridge
        .fetchData('/ajax.club.prev.games/-/id/$id/mode/PAGE');
    List<ClubMatchInfoTransfer> clubMatchInfoTransfers =
        await games.parseHTML(html, true);

    ResponseSuccessDto responseSuccessDto =
        ResponseSuccessDto(clubMatchInfoTransfers);

    return Response.ok(jsonEncode(responseSuccessDto));
  }

  Future<Response> nextTeamAction(Request request) async {
    var id = request.params['id'];
    String html = await httpClientBridge
        .fetchData('/ajax.team.next.games/-/mode/PAGE/team-id/$id');
    List<ClubMatchInfoTransfer> clubMatchInfoTransfers =
        await games.parseHTML(html, false);

    ResponseSuccessDto responseSuccessDto =
        ResponseSuccessDto(clubMatchInfoTransfers);

    return Response.ok(jsonEncode(responseSuccessDto));
  }

  Future<Response> prevTeamAction(Request request) async {
    var id = request.params['id'];
    String html = await httpClientBridge
        .fetchData('/ajax.team.prev.games/-/mode/PAGE/team-id/$id');
    List<ClubMatchInfoTransfer> clubMatchInfoTransfers =
        await games.parseHTML(html, true);

    ResponseSuccessDto responseSuccessDto =
        ResponseSuccessDto(clubMatchInfoTransfers);

    return Response.ok(jsonEncode(responseSuccessDto));
  }
}
