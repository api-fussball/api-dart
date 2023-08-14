import 'package:html/parser.dart' as htmlParser;
import 'package:html/dom.dart' as dom;

class TableResult {
  List<TeamTableTransfer> parseHTML(String html) {
    final dom.Document document = htmlParser.parse(html);

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
      tableTeamInfo.games = int.parse(trInfoList[3].text);
      tableTeamInfo.won = int.parse(trInfoList[4].text);
      tableTeamInfo.draw = int.parse(trInfoList[5].text);
      tableTeamInfo.lost = int.parse(trInfoList[6].text);
      tableTeamInfo.goal = trInfoList[7].text;
      tableTeamInfo.goalDifference = int.parse(trInfoList[8].text);
      tableTeamInfo.points = int.parse(trInfoList[9].text);

      tableTeamInfoList.add(tableTeamInfo);
    }

    return tableTeamInfoList;
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
  int games = 0;
  int won = 0;
  int draw = 0;
  int lost = 0;
  String goal = '';
  int goalDifference = 0;
  int points = 0;
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
