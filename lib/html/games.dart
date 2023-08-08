import 'package:api_fussball_dart/dto/club_match_info_transfer.dart';
import 'package:api_fussball_dart/html/font.dart';
import 'package:html/parser.dart' show parse;
import 'package:html/dom.dart';

abstract interface class GamesInterface {
  List<ClubMatchInfoTransfer> parseHTML(String html, bool isScore);
}

class Games implements GamesInterface {

  ScoreFont scoreFont = ScoreFont();

  @override
  List<ClubMatchInfoTransfer> parseHTML(String html, bool isScore) {
    List<ClubMatchInfoTransfer> results = [];

    var document = parse(html.replaceAll('&#', ''));
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

      _addMainInfo(rowScore, clubMatchInfoTransfer);
      if(isScore) {
        _addScoreInfo(rowScore, clubMatchInfoTransfer);
      }
    }

    return results;
  }

  void _addScoreInfo(Element rowScore, ClubMatchInfoTransfer clubMatchInfoTransfer) async {
    print(rowScore);
    var spans = rowScore.getElementsByTagName('span');
    for (var span in spans) {
      if (span.attributes['class'] == 'info-text') {
        clubMatchInfoTransfer.status = span.text;
      }
    }

    for (var span in spans) {

      String? dataObfuscation = span.attributes['data-obfuscation'];
      if (span.className == 'score-left') {

        clubMatchInfoTransfer.homeScore = await scoreFont.getScore(dataObfuscation!, span.innerHtml);
      }

      if (span.className == 'score-right') {
        clubMatchInfoTransfer.awayScore = await scoreFont.getScore(dataObfuscation!, span.innerHtml);
      }
    }
  }

  void _addMainInfo(
      Element rowScore, ClubMatchInfoTransfer clubMatchInfoTransfer) {
    var awayTeam =
        rowScore.previousElementSibling?.getElementsByTagName('span')[0];

    if (awayTeam != null) {
      clubMatchInfoTransfer.awayTeam = awayTeam.attributes['data-alt'] ?? '';

      var image = awayTeam.attributes['data-responsive-image'];
      if (image != null) {
        clubMatchInfoTransfer.awayLogo = 'https:$image';
      }
    }

    var homeTeam = rowScore
        .previousElementSibling?.previousElementSibling?.previousElementSibling
        ?.getElementsByTagName('span')[0];

    if (homeTeam != null) {
      clubMatchInfoTransfer.homeTeam = homeTeam.attributes['data-alt'] ?? '';

      var image = homeTeam.attributes['data-responsive-image'];
      if (image != null) {
        clubMatchInfoTransfer.homeLogo = 'https:$image';
      }
    }
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
