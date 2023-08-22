import 'package:api_fussball_dart/database.dart';
import 'package:test/test.dart';

void main() {
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



}
