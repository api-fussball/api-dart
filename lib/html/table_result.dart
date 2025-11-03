import 'package:html/parser.dart' as html_parser;
import 'package:html/dom.dart' as dom;

class TableResult {
  List<TeamTableTransfer> parseHTML(String html) {
    final dom.Document document = html_parser.parse(html);

    final List<dom.Element> tableInfos = document.querySelectorAll('tr');
    final List<TeamTableTransfer> tableTeamInfoList = [];

    for (final childNode in tableInfos) {
      if (childNode.classes.contains('thead')) {
        continue;
      }

      final tableTeamInfo = TeamTableTransfer();

      _addRelegationAndPromotionInfo(childNode, tableTeamInfo);

      final List<dom.Element> trInfoList = childNode.querySelectorAll('td');

      var place = trInfoList[1].text.trim().replaceAll('.', '');
      tableTeamInfo.place = int.parse(place);
      final dom.Element clubColumn = trInfoList[2];

      tableTeamInfo.team = clubColumn.text.trim();
      tableTeamInfo.img =
          'https:${clubColumn.querySelector('img')!.attributes['src']!}';
      tableTeamInfo.games = _parseGermanDouble(trInfoList[3].text);
      tableTeamInfo.won = _parseGermanDouble(trInfoList[4].text);
      tableTeamInfo.draw = _parseGermanDouble(trInfoList[5].text);
      tableTeamInfo.lost = _parseGermanDouble(trInfoList[6].text);
      tableTeamInfo.goal = trInfoList[7].text;
      tableTeamInfo.goalDifference = _parseGermanDouble(trInfoList[8].text);
      tableTeamInfo.points = _parseGermanDouble(trInfoList[9].text);

      tableTeamInfoList.add(tableTeamInfo);
    }

    return tableTeamInfoList;
  }

  /// Parses a German-formatted number string to a double.
  /// Handles both comma (German) and dot (English) decimal separators.
  /// Examples: "2,60" -> 2.6, "10" -> 10.0, "-2,60" -> -2.6
  double _parseGermanDouble(String value) {
    final normalized = value.trim().replaceAll(',', '.');
    return double.parse(normalized);
  }

  void _addRelegationAndPromotionInfo(
      dom.Element childNode, TeamTableTransfer tableTeamInfo) {
    final className = childNode.attributes['class'] ?? '';

    if (className.contains('relegation')) {
      tableTeamInfo.isRelegation = true;
    }

    if (className.contains('promotion')) {
      tableTeamInfo.isPromotion = true;
    }
  }
}

class TeamTableTransfer {
  int place = 0;
  String team = '';
  String img = '';
  double games = 0;
  double won = 0;
  double draw = 0;
  double lost = 0;
  String goal = '';
  double goalDifference = 0;
  double points = 0;
  bool isRelegation = false;
  bool isPromotion = false;

  Map<String, dynamic> toJson() {
    return {
      'place': place,
      'team': team,
      'img': img,
      'games': games,
      'won': won,
      'draw': draw,
      'lost': lost,
      'goal': goal,
      'goalDifference': goalDifference,
      'points': points,
      'isRelegation': isRelegation,
      'isPromotion': isPromotion
    };
  }
}
