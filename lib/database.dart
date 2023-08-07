import 'dart:convert';
import 'dart:io';

import 'package:api_fussball_dart/entities/font.dart';
import 'package:api_fussball_dart/entities/user.dart';
import 'package:isar/isar.dart';

class Database {
  static Isar? _isarInstance;

  static Future<Isar> get isarInstance async {
    if (_isarInstance == null) {
      String currentDirectory = Directory.current.path;
      await Isar.initializeIsarCore(download: true);
      _isarInstance =
          await Isar.open([UserSchema, FontSchema], directory: currentDirectory);
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

  deleteByName(String name) async {
    final isar = await Database.isarInstance;
    await isar.writeTxn(() async {
      await isar.fonts.where().filter().nameEqualTo(name).deleteAll();
    });
  }
}


Future<User?> findUserByToken(String token) async {
  final isar = await Database.isarInstance;
  return await isar.users.where().filter().tokenEqualTo(token).findFirst();
}

Future<void> saveUser(String email, String token) async {
  final isar = await Database.isarInstance;
  final newUser = User()
    ..email = email
    ..token = token;

  await isar.writeTxn(() async {
    await isar.users.put(newUser);
  });
}
