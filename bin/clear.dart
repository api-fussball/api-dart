import 'package:api_fussball_dart/database.dart';

void main() async {
  FontManager fontManager = FontManager();
  var deleteIds = await fontManager.deleteAll();
  print(deleteIds);
}
