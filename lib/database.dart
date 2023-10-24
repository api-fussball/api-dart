import 'dart:convert';
import 'dart:io';

import 'package:api_fussball_dart/entities/font.dart';
import 'package:api_fussball_dart/entities/rate_limit.dart';
import 'package:api_fussball_dart/entities/user.dart';
import 'package:isar/isar.dart';

class Database {
  static Isar? _isarInstance;

  static Future<Isar> get isarInstance async {
    if (_isarInstance == null) {
      String currentDirectory = Directory.current.path;
      await Isar.initializeIsarCore(download: true);
      _isarInstance =
          await Isar.open([UserSchema, FontSchema, RateLimitSchema], directory: currentDirectory);
    }
    return _isarInstance!;
  }
}

class FontManager {
  Future<Map<String, String>?> findByName(String name) async {
    final isar = await Database.isarInstance;
    Font? font = await isar.fonts.where().filter().nameEqualTo(name).findFirst();

    if (font == null) {
      return null;
    }

    return Map<String, String>.from(json.decode(font.info!));
  }

  Future<void> save(String name, Map<String, String> info) async {
    final isar = await Database.isarInstance;
    final newFont = Font()
      ..name = name
      ..info = json.encode(info);

    await isar.writeTxn(() async {
      await isar.fonts.put(newFont);
    });
  }

  Future<List<int>> deleteAll() async {
    final isar = await Database.isarInstance;

    final allFonts = await isar.fonts.where().findAll();
    var ids = allFonts.map((e) => e.id).toList();


    await isar.writeTxn(() async {
      await isar.fonts.clear();
    });


    return ids;
  }
}


class RateLimitManager {
  Future<int> get(int userId) async {
    final isar = await Database.isarInstance;

    return await isar.rateLimits.where().filter().userIdEqualTo(userId).timeEqualTo(_getDate()).count();
  }

  Future<void> add(int userId) async {
    final isar = await Database.isarInstance;

    final newRateLimit = RateLimit()
      ..userId = userId
      ..time = _getDate();

    await isar.writeTxn(() async {
      await isar.rateLimits.put(newRateLimit);
    });
  }

  Future<void> clear() async {
    final isar = await Database.isarInstance;

    await isar.writeTxn(() async {
      await isar.rateLimits.clear();
    });
  }

  int _getDate() {
    DateTime now = DateTime.now();
    String formattedDate = '${now.year}${now.month.toString().padLeft(2, '0')}${now.day.toString().padLeft(2, '0')}${now.hour.toString().padLeft(2, '0')}${now.minute.toString().padLeft(2, '0')}';
    return int.parse(formattedDate);
  }
}

Future<List<User?>> findAllUser() async {
  final isar = await Database.isarInstance;
  return await isar.users.where().findAll();
}

Future<User?> findUserByToken(String token) async {
  final isar = await Database.isarInstance;
  return await isar.users.where().filter().tokenEqualTo(token).findFirst();
}

Future<void> saveUser(String email, String token) async {
  final isar = await Database.isarInstance;
  var userDb = isar.users;

  await isar.writeTxn(() async {
    await userDb.where().filter().emailEqualTo(email).deleteAll();
  });

  final newUser = User()
    ..email = email
    ..token = token;

  await isar.writeTxn(() async {
    await userDb.put(newUser);
  });
}

Future<void> deleteUserByEmail(String email) async {
  final isar = await Database.isarInstance;
  await isar.writeTxn(() async {
    await isar.users.where().filter().emailEqualTo(email).deleteAll();
  });
}

Future<void> saveUsersToJson() async {
  var users = await findAllUser();
  Map<String, String> userMap = {};

  for (var user in users) {
    userMap[user!.email ?? 'defaultEmail'] = user.token ?? 'defaultToken';
  }

  String jsonStr = jsonEncode(userMap);
  await File('users.json').writeAsString(jsonStr);
}


Future<List<String>> importUsersFromJson() async {
  final file = File('users.json');
  if (!await file.exists()) {
    throw Exception('File users.json does not exist');
  }

  final content = await file.readAsString();
  final Map<String, dynamic> usersMap = jsonDecode(content);

  List<String> importedEmails = [];

  for (var email in usersMap.keys) {
    await saveUser(email, usersMap[email]);
    importedEmails.add(email);
  }

  return importedEmails;
}

