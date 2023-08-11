import 'package:api_fussball_dart/dto/club_team_info_transfer.dart';
import 'package:html/parser.dart' show parse;
import 'package:html/dom.dart';

class Club {
  List<ClubTeamInfoTransfer> parseHTML(String html) {
    List<ClubTeamInfoTransfer> results = [];

    var document = parse(html);
    List<Element> rows = document.querySelectorAll('div.item');

    for (var row in rows) {
      Element? teamHtmlInfo = row.querySelector('h4 a');

      if(teamHtmlInfo == null || teamHtmlInfo.attributes['href'] == null) {
        continue;
      }

      String? url = teamHtmlInfo.attributes['href'];

      if (url == null) {
        continue;
      }

      ClubTeamInfoTransfer clubInfoTransfer = ClubTeamInfoTransfer();
      clubInfoTransfer.fussballDeUrl = url.replaceFirst('https://www.fussball.de', '');
      clubInfoTransfer.name = teamHtmlInfo.text.trim();

      List<String> explodeUrl = url.split('/');
      clubInfoTransfer.id = explodeUrl.last;

      results.add(clubInfoTransfer);
    }

    return results;
  }
}
