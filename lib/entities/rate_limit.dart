import 'package:isar/isar.dart';

part 'rate_limit.g.dart';

@collection
class RateLimit {
  Id id = Isar.autoIncrement;

  int? userId;

  int? time;
}
