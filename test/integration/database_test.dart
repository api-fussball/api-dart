import 'dart:convert';
import 'dart:io';

import 'package:api_fussball_dart/database.dart';
import 'package:api_fussball_dart/entities/rate_limit.dart';
import 'package:api_fussball_dart/entities/user.dart';
import 'package:test/test.dart';

void main() {

  tearDown(() async {
    var file = File('users.json');
    if (await file.exists()) {
       await file.delete();
    }

    await deleteUserByEmail('test1@email.com');
    await deleteUserByEmail('test2@email.com');
    await deleteUserByEmail('exist@user.com');

    await RateLimitManager().clear();
  });


  test('delete all fonts', () async {
    FontManager fontManager = FontManager();
    await fontManager.save('test', {'test': 'test'});
    await fontManager.save('unit', {'unit': 'unit'});

    await fontManager.deleteAll();

    Map<String, String>? fontTest = await fontManager.findByName('test');

    expect(fontTest, null);

    Map<String, String>? fontUnit = await fontManager.findByName('unit');

    expect(fontUnit, null);
  });

  test('saveUsersToJson saves users to JSON file', () async {
    await saveUser('test1@email.com', 'tokenX');
    await saveUser('test1@email.com', 'token1');
    await saveUser('test2@email.com', 'token2');

    await saveUsersToJson();

    var file = File('users.json');
    expect(await file.exists(), isTrue);

    var content = await file.readAsString();
    Map<String, dynamic> jsonContent = jsonDecode(content);

    expect(jsonContent.containsKey('test1@email.com'), isTrue);
    expect(jsonContent.containsKey('test2@email.com'), isTrue);

    expect(jsonContent['test1@email.com'], 'token1');
    expect(jsonContent['test2@email.com'], 'token2');
  });

  test('importUsersFromJson imports users from JSON file to DB', () async {
    await saveUser('test1@email.com', 'token1');
    await saveUser('test2@email.com', 'token2');

    await saveUsersToJson();

    await saveUser('test2@email.com', 'overwrite token');
    await saveUser('exist@user.com', 'new_user');

    List<String> emails = await importUsersFromJson();

    expect(emails, contains('test1@email.com'));
    expect(emails, contains('test2@email.com'));

    User? user = await findUserByToken('token2');
    expect(user!.email, 'test2@email.com');

    user = await findUserByToken('new_user');
    expect(user!.email, 'exist@user.com');
  });

  test('test rate limit', () async {
    RateLimitManager rateLimitManager = RateLimitManager();

    int rateLimitUser99 = await rateLimitManager.get(99);
    int rateLimitUser1 = await rateLimitManager.get(1);

    expect(rateLimitUser99, 0);
    expect(rateLimitUser1, 0);

    await rateLimitManager.add(99);
    await rateLimitManager.add(1);
    await rateLimitManager.add(99);
    await rateLimitManager.add(99);

    rateLimitUser99 = await rateLimitManager.get(99);
    rateLimitUser1 = await rateLimitManager.get(1);

    expect(rateLimitUser99, 3);
    expect(rateLimitUser1, 1);

    await RateLimitManager().clear();

    rateLimitUser99 = await rateLimitManager.get(99);
    rateLimitUser1 = await rateLimitManager.get(1);

    expect(rateLimitUser99, 0);
    expect(rateLimitUser1, 0);
  });

  test('test rate limit with another time', () async {
    DateTime now = DateTime.now();
    String formattedDate = '${now.year}${now.month.toString().padLeft(2, '0')}${now.day.toString().padLeft(2, '0')}${now.hour.toString().padLeft(2, '0')}${now.minute.toString().padLeft(2, '0')}';
    var date = int.parse(formattedDate) - 1;
    final isar = await Database.isarInstance;

    final newRateLimit = RateLimit()
      ..userId = 99
      ..time = date;

    await isar.writeTxn(() async {
      await isar.rateLimits.put(newRateLimit);
    });

    RateLimitManager rateLimitManager = RateLimitManager();
    int rateLimitUser = await rateLimitManager.get(99);

    expect(rateLimitUser, 0);

    await rateLimitManager.add(99);

    rateLimitUser = await rateLimitManager.get(99);

    expect(rateLimitUser, 1);
  });
}
