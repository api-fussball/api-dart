import 'dart:io';

import 'package:api_fussball_dart/entities/user.dart';
import 'package:isar/isar.dart';

class Database {
  static Isar? _isarInstance;

  static Future<Isar> get isarInstance async {
    if (_isarInstance == null) {

      final scriptFile = File.fromUri(Platform.script);

      String name = 'default';
      if (scriptFile.parent.path.contains('dart_test')) {
        name = 'default_test';
      }

      String currentDirectory = Directory.current.path;
      await Isar.initializeIsarCore(download: true);
      _isarInstance = await Isar.open(
        [UserSchema],
        directory: currentDirectory,
        name: name,
      );
    }
    return _isarInstance!;
  }
}

Future<User?> findUserByToken(String token) async {
  final isar = await Database.isarInstance;
  return await isar.users.where().filter().tokenEqualTo(token).findFirst();
}

Future<void> saveUser(String email, String token) async {
  final isar = await Database.isarInstance;
  final newUser = User()..email = email..token = token;

  await isar.writeTxn(() async {
    await isar.users.put(newUser); // insert & update
  });
}


