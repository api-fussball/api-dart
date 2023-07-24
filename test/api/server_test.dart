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

    saveUser('test@unit.com', 'unit_test_token');
    // Wait for server to start and print to stdout.
    await p.stdout.first;
  });

  tearDown(() async {
    p.kill();
  });

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
    expect(response.statusCode, 400);

    Map<String, dynamic> jsonObject = json.decode(response.body);

    expect(jsonObject, isNotNull);
    expect(jsonObject['success'], isFalse);
    expect(jsonObject['data'], isList);
    expect(jsonObject['data'], isEmpty);
    expect(jsonObject['message'], equals('Exception: Error on URL: https://fussball.de/ajax.club.next.games/-/id/id/mode/PAGE'));
  });
  //
  // test('Echo', () async {
  //   final response = await get(Uri.parse('$host/echo/hello'));
  //   expect(response.statusCode, 200);
  //   expect(response.body, 'hello\n');
  // });
  //
  // test('404', () async {
  //   final response = await get(Uri.parse('$host/foobar'));
  //   expect(response.statusCode, 404);
  // });
}
