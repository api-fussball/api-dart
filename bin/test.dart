import 'dart:io';

import 'package:api_fussball_dart/controller/games.dart';
import 'package:api_fussball_dart/crawler/http_client_brige.dart';
import 'package:api_fussball_dart/entities/user.dart';
import 'package:isar/isar.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart';
import 'package:shelf_router/shelf_router.dart';


void test() async {
  final dir = Directory.current.path;
  final isar = await Isar.open(
    [UserSchema],
    directory: dir,
  );

  final newUser = User()..email = 'wesolyy@gmail.com'..token = 'cbee0ce91b845016869199616a47352f1635d973b06267d932ef20b8888e146f';

  await isar.writeTxn(() async {
    await isar.users.put(newUser); // insert & update
  });
  var token = 'cbee0ce91b845016869199616a47352f1635d973b06267d932ef20b8888e146f';
  final user = await isar.users.where().filter().tokenEqualTo(token).findFirst();

  if (user != null) {
    print('User found: ${user.email}');
  } else {
    print('No user found with token: $token');
  }

  // if(existingUser != null) {
  //
  //     await isar.writeTxn(() async {
  //       await isar.users.delete(existingUser.id); // delete
  //     });
  //
  //
  // }

}


void main(List<String> args) async {
  test();

}
