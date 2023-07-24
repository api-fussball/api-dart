import 'package:api_fussball_dart/database.dart';
import 'package:test/test.dart';
import 'package:api_fussball_dart/html/games.dart';

void main() {
  test('Test nächste games', () async {

    final String htmlString = '''
<div id="id-club-matchplan-table" class="fixtures-matches">
    <div class="table-container fixtures-matches-table club-matchplan-table">
        <div class="hint-pre-publish"><span class="inner"><h5>Wichtiger Hinweis zum Spielplan</h5><p>Dieser Spielplan enthält vorläufige Spiele, die noch nicht vom Staffelleiter freigegeben worden sind. Bitte warte für weitere Informationen auf die finale Freigabe.</p></span></div>
        <table class="table table-striped table-full-width">
            <thead>
            <tr class="thead hidden-small">
                <th class="hidden-small">Datum | Zeit</th>
                <th colspan="3">Wettbewerb</th>
                <th colspan="2"><span class="hidden-small">Info</span></th>
            </tr>
            </thead>
            <tbody>
            <tr class="row-headline visible-small">
                <td colspan="6">Sonntag, 08.05.2022 - 10:00 Uhr | D-Junioren | 1.Kreisklasse</td>
            </tr>
            <tr class="odd row-competition hidden-small">
                <td class="column-date"><span class="hidden-small inline">So, 08.05.22 |&nbsp;</span>10:00</td>
                <td colspan="3" class="column-team">
                    <a>D-Junioren | 1.Kreisklasse</a>
                </td>
                <td colspan="2">
                    <a>ME | 230215117</a>
                </td>
            </tr>
            <tr class="odd">
                <td class="hidden-small"></td>
                <td class="column-club">
                    <a href="https://www.fussball.de/mannschaft/sv-fuehlingen-u-12-sv-fuehlingen-chorweiler-e-v-mittelrhein/-/saison/2122/team-id/011MICT0UG000000VTVG0001VTR8C1K7" class="club-wrapper">
                        <div class="club-logo table-image"><span data-alt="Fühlingen U12" data-responsive-image="//www.fussball.de/export.media/-/action/getLogo/format/3/id/00ES8GN91400002IVV0AG08LVUPGND5I"></span></div>
                        <div class="club-name">
                            Fühlingen U12
                        </div>
                    </a>
                </td>
                <td class="column-colon">:</td>
                <td class="column-club no-border">
                    <a href="https://www.fussball.de/mannschaft/adler-dellbrueck-u12-ii-sv-adler-dellbrueck-1922-ev-mittelrhein/-/saison/2122/team-id/023U2JFCUS000000VS548984VSVTAEJ3" class="club-wrapper">
                        <div class="club-logo table-image"><span data-alt="Dellbrück U12 II" data-responsive-image="//www.fussball.de/export.media/-/action/getLogo/format/3/id/00ES8GN91400001GVV0AG08LVUPGND5I"></span></div>
                        <div class="club-name">
                            Dellbrück U12 II
                        </div>
                    </a>
                </td>
                <td class="column-score">
                    <a href="https://www.fussball.de/spiel/sv-fuehlingen-u-12-adler-dellbrueck-u12-ii/-/spiel/02FAE2V39S000000VS5489B3VSQ68S6N"><span data-obfuscation="33dfshl1" class="score-left">&#xE6AA;</span><span class="colon">:</span><span data-obfuscation="33dfshl1" class="score-right">&#xE6AE;</span></a>
                </td>
                <td class="column-detail">
                    <a href="https://www.fussball.de/spiel/sv-fuehlingen-u-12-adler-dellbrueck-u12-ii/-/spiel/02FAE2V39S000000VS5489B3VSQ68S6N"><span class="icon-angle-right hidden-full"></span><span class="visible-full">Zum Spiel<span class="icon-link-arrow"></span></span></a>
                </td>
            </tr>
            <tr class="row-headline visible-small">
                <td colspan="6">Sonntag, 08.05.2022 - 11:00 Uhr | C-Junioren | Kreisleistungsklasse</td>
            </tr>
            <tr class="row-competition hidden-small">
                <td class="column-date">11:00</td>
                <td colspan="3" class="column-team">
                    <a>C-Junioren | Kreisleistungsklasse</a>
                </td>
                <td colspan="2">
                    <a>ME | 230122120</a>
                </td>
            </tr>
            <tr>
                <td class="hidden-small"></td>
                <td class="column-club">
                    <a href="https://www.fussball.de/mannschaft/rath-heumar-u14-rsv-rath-heumar-1920-ev-mittelrhein/-/saison/2122/team-id/02F12DDAB4000000VS5489B2VUBVHUE0" class="club-wrapper">
                        <div class="club-logo table-image"><span data-alt="Rath-Heumar U14" data-responsive-image="//www.fussball.de/export.media/-/action/getLogo/format/3/id/00ES8GN91400004FVV0AG08LVUPGND5I"></span></div>
                        <div class="club-name">
                            Rath-Heumar U14
                        </div>
                    </a>
                </td>
                <td class="column-colon">:</td>
                <td class="column-club no-border">
                    <a href="https://www.fussball.de/mannschaft/sv-fuehlingen-u14-sv-fuehlingen-chorweiler-e-v-mittelrhein/-/saison/2122/team-id/011MIAD9JG000000VTVG0001VTR8C1K7" class="club-wrapper">
                        <div class="club-logo table-image"><span data-alt="Fühlingen U14" data-responsive-image="//www.fussball.de/export.media/-/action/getLogo/format/3/id/00ES8GN91400002IVV0AG08LVUPGND5I"></span></div>
                        <div class="club-name">
                            Fühlingen U14
                        </div>
                    </a>
                </td>
                <td class="column-score">
                    <a href="https://www.fussball.de/spiel/rath-heumar-u14-sv-fuehlingen-u14/-/spiel/02FAD6I3V8000000VS5489B3VSQ68S6N"><span data-obfuscation="33dfshl1" class="score-left">&#xE68D;</span><span class="colon">:</span><span data-obfuscation="33dfshl1" class="score-right">&#xE660;</span></a>
                </td>
                <td class="column-detail">
                    <a href="https://www.fussball.de/spiel/rath-heumar-u14-sv-fuehlingen-u14/-/spiel/02FAD6I3V8000000VS5489B3VSQ68S6N"><span class="icon-angle-right hidden-full"></span><span class="visible-full">Zum Spiel<span class="icon-link-arrow"></span></span></a>
                </td>
            </tr>
        
        
            </tbody>
        </table>
    </div>
</div>
''';
  parseHTML(htmlString);

  });
}
