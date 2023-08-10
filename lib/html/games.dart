import 'package:api_fussball_dart/dto/club_match_info_transfer.dart';
import 'package:api_fussball_dart/html/font.dart';
import 'package:html/parser.dart' show parse;
import 'package:html/dom.dart';

abstract interface class GamesInterface {
  Future<List<ClubMatchInfoTransfer>> parseHTML(String html, bool isScore);
}

class Games implements GamesInterface {
  ScoreFont scoreFont = ScoreFont();

  @override
  Future<List<ClubMatchInfoTransfer>> parseHTML(
      String html, bool isScore) async {
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
      if (isScore) {
        clubMatchInfoTransfer.homeScore =
            await _getHomeScore(rowScore, clubMatchInfoTransfer);
        clubMatchInfoTransfer.awayScore =
            await _getAwayScore(rowScore, clubMatchInfoTransfer);
      }

      _addStatus(rowScore, clubMatchInfoTransfer);
    }

    if (isScore) {
      clearScoreFontRuntimeCache(document);
    }

    return results;
  }

  void clearScoreFontRuntimeCache(Document document) {
    var elements = document.querySelectorAll('[data-obfuscation]');

    Set<String> uniqueValues = {};
    for (Element element in elements) {
      uniqueValues.add(element.attributes['data-obfuscation']!);
    }

    for (String value in uniqueValues) {
      scoreFont.fontCache.remove(value);
    }
  }

  void _addStatus(
      Element rowScore, ClubMatchInfoTransfer clubMatchInfoTransfer) {
    var spans = rowScore.getElementsByTagName('span');
    for (var span in spans) {
      if (span.attributes['class'] == 'info-text') {
        clubMatchInfoTransfer.status = span.text;
      }
    }
  }

  Future<String> _getHomeScore(
      Element rowScore, ClubMatchInfoTransfer clubMatchInfoTransfer) async {
    var spans = rowScore.getElementsByTagName('span');
    for (var span in spans) {
      String? dataObfuscation = span.attributes['data-obfuscation'];
      if (span.className == 'score-left') {
        return await scoreFont.getScore(dataObfuscation!, span.innerHtml);
      }
    }
    return '';
  }

  Future<String> _getAwayScore(
      Element rowScore, ClubMatchInfoTransfer clubMatchInfoTransfer) async {
    var spans = rowScore.getElementsByTagName('span');
    for (var span in spans) {
      String? dataObfuscation = span.attributes['data-obfuscation'];
      if (span.className == 'score-right') {
        return await scoreFont.getScore(dataObfuscation!, span.innerHtml);
      }
    }
    return '';
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
      clubMatchInfoTransfer.date = dateTimeInfo[0].substring(dateTimeInfo[0].indexOf(',') + 2);
      clubMatchInfoTransfer.time = dateTimeInfo[1].split(' Uhr')[0];

      List<String> otherInfo = dateTimeInfo[1].split(' | ');

      if (otherInfo.isNotEmpty) {
        if (otherInfo.length == 3) {
          clubMatchInfoTransfer.ageGroup = otherInfo[1].trim();
          clubMatchInfoTransfer.competition = otherInfo[2].trim();
        }

        if (otherInfo.length == 2) {
          clubMatchInfoTransfer.competition = otherInfo[1].trim();
        }
      }
    }
  }
}
