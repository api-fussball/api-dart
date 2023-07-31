import 'package:api_fussball_dart/dto/club_match_info_transfer.dart';
import 'package:html/parser.dart' show parse;
import 'package:html/dom.dart';

abstract interface class GamesInterface {
  List<ClubMatchInfoTransfer> parseHTML(String html);
}

class Games implements GamesInterface {
  @override
  List<ClubMatchInfoTransfer> parseHTML(String html) {
    List<ClubMatchInfoTransfer> results = [];

    var document = parse(html);
    List<Element> rows = document.querySelectorAll('tr.visible-small');

    for (var row in rows) {
      ClubMatchInfoTransfer clubMatchInfoTransfer = ClubMatchInfoTransfer();
      Element column = row.querySelectorAll('td')[0];

      _addTimeAndCompentionInfo(column.text, clubMatchInfoTransfer);
      results.add(clubMatchInfoTransfer);
    }

    List<Element> rowsScore = document.querySelectorAll('td.column-score');

    for (var rowScore in rowsScore) {
      ClubMatchInfoTransfer clubMatchInfoTransfer =
          results[rowsScore.indexOf(rowScore)];

      var awayTeam =
          rowScore.previousElementSibling?.getElementsByTagName('span')[0];

      if (awayTeam != null) {
        clubMatchInfoTransfer.awayTeam = awayTeam.attributes['data-alt'] ?? '';

        var image = awayTeam.attributes['data-responsive-image'];
        if (image != null) {
          clubMatchInfoTransfer.awayLogo = 'https:$image';
        }
      }

      var homeTeam = rowScore.previousElementSibling?.previousElementSibling
          ?.previousElementSibling
          ?.getElementsByTagName('span')[0];

      if (homeTeam != null) {
        clubMatchInfoTransfer.homeTeam = homeTeam.attributes['data-alt'] ?? '';

        var image = homeTeam.attributes['data-responsive-image'];
        if (image != null) {
          clubMatchInfoTransfer.homeLogo = 'https:$image';
        }
      }
    }

    return results;
  }

  void _addTimeAndCompentionInfo(
      String text, ClubMatchInfoTransfer clubMatchInfoTransfer) {
    String nodeValue = text.trim();

    List<String> dateTimeInfo = nodeValue.split(' - ');
    if (dateTimeInfo.isNotEmpty) {
      clubMatchInfoTransfer.date =
          dateTimeInfo[0].substring(dateTimeInfo[0].indexOf(',') + 2);
      clubMatchInfoTransfer.time = dateTimeInfo[1].split(' Uhr')[0];

      List<String> otherInfo = dateTimeInfo[1].split(' | ');
      if (otherInfo.isNotEmpty) {
        clubMatchInfoTransfer.ageGroup = otherInfo[1].trim();
        clubMatchInfoTransfer.competition = otherInfo[2].trim();
      }
    }
  }
}
