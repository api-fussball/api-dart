import 'package:api_fussball_dart/dto/response_dto.dart';
import 'package:test/test.dart';

void main() {
  group('Response DTOs', () {
    test('ResponseInfoSuccessDto toJson', () {
      var dto = ResponseInfoSuccessDto(
        ['Club1', 'Club2'],
        ['PrevGame1', 'PrevGame2'],
        ['NextGame1', 'NextGame2'],
      );

      var expectedJson = {
        'success': true,
        'data': {
          'clubs': ['Club1', 'Club2'],
          'prevGames': ['PrevGame1', 'PrevGame2'],
          'nextGames': ['NextGame1', 'NextGame2'],
        },
      };

      expect(dto.toJson(), expectedJson);
    });

    test('ResponseTeamInfoSuccessDto toJson', () {
      var dto = ResponseTeamInfoSuccessDto(
        ['Team1', 'Team2'],
        ['PrevGame1', 'PrevGame2'],
        ['NextGame1', 'NextGame2'],
      );

      var expectedJson = {
        'success': true,
        'data': {
          'table': ['Team1', 'Team2'],
          'prevGames': ['PrevGame1', 'PrevGame2'],
          'nextGames': ['NextGame1', 'NextGame2'],
        },
      };

      expect(dto.toJson(), expectedJson);
    });

    test('ResponseSuccessDto toJson', () {
      var dto = ResponseSuccessDto(['Data1', 'Data2']);

      var expectedJson = {
        'success': true,
        'data': ['Data1', 'Data2'],
      };

      expect(dto.toJson(), expectedJson);
    });
  });
}
