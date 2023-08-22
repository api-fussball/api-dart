import 'dart:convert';
import 'dart:io';

import 'package:api_fussball_dart/database.dart';
import 'package:http/http.dart';
import 'package:test/test.dart';

void main() {
  final port = '8888';
  final host = 'http://0.0.0.0:$port';
  late Process p;

  setUp(() async {
    p = await Process.start(
      'dart',
      ['run', 'bin/server.dart'],
      environment: {'PORT': port},
    );

    await saveUser('test@unit.com', 'unit_test_token');

    await p.stdout.first;
  });

  tearDown(() async {
    p.kill();
  });

  int getScore(List<dynamic> data) {
    int score = 0;

    for (var info in data) {
      score += int.tryParse(info['homeScore'] ?? '') ?? 0;
      score += int.tryParse(info['awayScore'] ?? '') ?? 0;
    }

    return score;
  }

  void checkTeam(List<dynamic> data, String expectedTeam) {
    List<String> teams = [];

    for (var info in data) {
      teams.add(info['homeTeam']);
      teams.add(info['awayTeam']);
    }

    Set<String> uniqueTeams = Set.from(teams);
    bool findExpectedTeam = false;
    for (var team in uniqueTeams) {
      if (team.contains(expectedTeam)) {
        findExpectedTeam = true;
        break;
      }
    }
    expect(findExpectedTeam, true, reason: '$expectedTeam is not in teams array');
  }

  void checkTime(List<dynamic> data) {
    for (var info in data) {
      expect(info.containsKey('time'), true);
      String time = info['time'];

      expect(time.length, 5);

      List<String> timeInfo = time.split(':');
      expect(timeInfo.length, 2);

      int hour = int.tryParse(timeInfo[0]) ?? -1;
      int minute = int.tryParse(timeInfo[1]) ?? -1;

      expect(hour != -1, isTrue);
      expect(minute != -1, isTrue);

      // Additional check for the time range (0 <= hour <= 23, 0 <= minute <= 59)
      expect(hour >= 0 && hour <= 23, true);
      expect(minute >= 0 && minute <= 59, true);
    }
  }


  test('error: call url without x-auth-header', () async {
    final response = await get(Uri.parse('$host/api/club/next_games/id'));
    expect(response.statusCode, 403);

    Map<String, dynamic> jsonObject = json.decode(response.body);

    expect(jsonObject, isNotNull);
    expect(jsonObject['success'], isFalse);
    expect(jsonObject['data'], isList);
    expect(jsonObject['data'], isEmpty);
    expect(jsonObject['message'], equals('Token in header: "x-auth-token" not found'));
  });

  test('error: call url with wrong x-auth-header', () async {
    final headers = {'x-auth-token': 'wrong_token'};
    final response = await get(Uri.parse('$host/api/club/next_games/id'), headers: headers);
    expect(response.statusCode, 403);

    Map<String, dynamic> jsonObject = json.decode(response.body);

    expect(jsonObject, isNotNull);
    expect(jsonObject['success'], isFalse);
    expect(jsonObject['data'], isList);
    expect(jsonObject['data'], isEmpty);
    expect(jsonObject['message'], equals('Token wrong_token not found'));
  });
  //
  test('error: call url with wrong id', () async {

    final headers = {'x-auth-token': 'unit_test_token'};
    final response = await get(Uri.parse('$host/api/club/next_games/id'), headers: headers);
    expect(response.statusCode, 400, reason: 'Error Body: ${response.body}');

    Map<String, dynamic> jsonObject = json.decode(response.body);

    expect(jsonObject, isNotNull);
    expect(jsonObject['success'], isFalse);
    expect(jsonObject['data'], isList);
    expect(jsonObject['data'], isEmpty);
    expect(jsonObject['message'], equals('Exception: Error on URL: https://www.fussball.de/ajax.club.next.games/-/id/id/mode/PAGE'));
  });

  test('success: api next game', () async {

    final headers = {'x-auth-token': 'unit_test_token'};
    final response = await get(Uri.parse('$host/api/club/next_games/00ES8GN91400002IVV0AG08LVUPGND5I'), headers: headers);
    expect(response.statusCode, 200, reason: 'Error Body: ${response.body}');


    String decodedJson = utf8.decode(response.body.codeUnits);

    Map<String, dynamic> jsonObject = json.decode(decodedJson);

    expect(jsonObject, isNotNull);
    expect(jsonObject['success'], isTrue);
    expect(jsonObject['data'], isList);
    expect(jsonObject['data'], isNotEmpty);

    checkTime(jsonObject['data']);
    checkTeam(jsonObject['data'], 'Fühlingen I');

    int score = getScore(jsonObject['data']);
    expect(score, 0);

  });

  test('success: api prev game with score', () async {

    final headers = {'x-auth-token': 'unit_test_token'};
    final response = await get(Uri.parse('$host/api/club/prev_games/00ES8GN91400002IVV0AG08LVUPGND5I'), headers: headers);
    expect(response.statusCode, 200, reason: 'Error Body: ${response.body}');


    String decodedJson = utf8.decode(response.body.codeUnits);

    Map<String, dynamic> jsonObject = json.decode(decodedJson);

    expect(jsonObject, isNotNull);
    expect(jsonObject['success'], isTrue);
    expect(jsonObject['data'], isList);
    expect(jsonObject['data'], isNotEmpty);

    checkTime(jsonObject['data']);
    checkTeam(jsonObject['data'], 'Fühlingen I');

    int score = getScore(jsonObject['data']);
    expect(score, greaterThan(0));
  });


  test('success: api prev club match with score', () async {

    final headers = {'x-auth-token': 'unit_test_token'};
    final response = await get(Uri.parse('$host/api/team/prev_games/011MIC9NDS000000VTVG0001VTR8C1K7'), headers: headers);
    expect(response.statusCode, 200, reason: 'Error Body: ${response.body}');


    String decodedJson = utf8.decode(response.body.codeUnits);

    Map<String, dynamic> jsonObject = json.decode(decodedJson);

    expect(jsonObject, isNotNull);
    expect(jsonObject['success'], isTrue);
    expect(jsonObject['data'], isList);
    expect(jsonObject['data'], isNotEmpty);

    checkTime(jsonObject['data']);
    checkTeam(jsonObject['data'], 'Fühlingen I');

    int score = getScore(jsonObject['data']);
    expect(score, greaterThan(0));
  });

  test('404', () async {
    final response = await get(Uri.parse('$host/api/not_found'));

    expect(response.statusCode, 404);

    Map<String, dynamic> jsonObject = json.decode(response.body);

    expect(jsonObject, isNotNull);
    expect(jsonObject['success'], isFalse);
    expect(jsonObject['data'], isList);
    expect(jsonObject['data'], isEmpty);
    expect(jsonObject['message'], equals('Route not found'));
  });
}
