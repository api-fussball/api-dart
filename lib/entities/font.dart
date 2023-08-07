import 'package:isar/isar.dart';

part 'font.g.dart';

@collection
class Font {
  Id id = Isar.autoIncrement;

  String? name;

  String? info;
}
