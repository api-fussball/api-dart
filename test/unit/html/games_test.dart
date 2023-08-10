import 'package:api_fussball_dart/dto/club_match_info_transfer.dart';
import 'package:api_fussball_dart/html/font.dart';
import 'package:test/test.dart';
import 'package:api_fussball_dart/html/games.dart';

class MockExceptionFont implements FontInterface {
  @override
  Future<Map<String, String>> decodeFont(String fontName) async {
    throw Exception('Not Exist');
  }
}

void main() {
  test('next club match', () async {
    final String htmlString = '''
    <!--https://www.fussball.de/ajax.club.next.games/-/id/00ES8GN91400002IVV0AG08LVUPGND5I/mode/PAGE -->

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
            <tr class="row-headline visible-small">
                <td colspan="6">Sonntag, 08.05.2022 - 11:30 Uhr | C-Junioren | 1.Kreisklasse</td>
            </tr>
            <tr class="odd row-competition hidden-small">
                <td class="column-date">11:30</td>
                <td colspan="3" class="column-team">
                    <a>C-Junioren | 1.Kreisklasse</a>
                </td>
                <td colspan="2">
                    <a>ME | 230156120</a>
                </td>
            </tr>
            <tr class="odd">
                <td class="hidden-small"></td>
                <td class="column-club">
                    <a href="https://www.fussball.de/mannschaft/1-jfs-koeln-u15-ii-1-jugend-fussball-schule-koeln-mittelrhein/-/saison/2122/team-id/011MIA1P88000000VTVG0001VTR8C1K7" class="club-wrapper">
                        <div class="club-logo table-image"><span data-alt="1. JFS Köln II" data-responsive-image="//www.fussball.de/export.media/-/action/getLogo/format/3/id/00ES8GN91400003QVV0AG08LVUPGND5I"></span></div>
                        <div class="club-name">
                            1. JFS Köln II
                        </div>
                    </a>
                </td>
                <td class="column-colon">:</td>
                <td class="column-club no-border">
                    <a href="https://www.fussball.de/mannschaft/sv-fuehlingen-sv-fuehlingen-chorweiler-e-v-mittelrhein/-/saison/2122/team-id/02ER9BDO34000000VS5489B2VVP292BR" class="club-wrapper">
                        <div class="club-logo table-image"><span data-alt="Fühlingen" data-responsive-image="//www.fussball.de/export.media/-/action/getLogo/format/3/id/00ES8GN91400002IVV0AG08LVUPGND5I"></span></div>
                        <div class="club-name">
                            Fühlingen
                        </div>
                    </a>
                </td>
                <td class="column-score">
                    <a href="https://www.fussball.de/spiel/1-jfs-koeln-u15-ii-sv-fuehlingen/-/spiel/02FACTUNJO000000VS5489B4VS777J8H"><span data-obfuscation="33dfshl1" class="score-left">&#xE667;</span><span class="colon">:</span><span data-obfuscation="33dfshl1" class="score-right">&#xE6B7;</span></a>
                </td>
                <td class="column-detail">
                    <a href="https://www.fussball.de/spiel/1-jfs-koeln-u15-ii-sv-fuehlingen/-/spiel/02FACTUNJO000000VS5489B4VS777J8H"><span class="icon-angle-right hidden-full"></span><span class="visible-full">Zum Spiel<span class="icon-link-arrow"></span></span></a>
                </td>
            </tr>
            <tr class="row-headline visible-small">
                <td colspan="6">Sonntag, 08.05.2022 - 13:00 Uhr | Herren | Kreisliga D</td>
            </tr>
            <tr class="row-competition hidden-small">
                <td class="column-date">13:00</td>
                <td colspan="3" class="column-team">
                    <a>Herren | Kreisliga D</a>
                </td>
                <td colspan="2">
                    <a>ME | 230556204</a>
                </td>
            </tr>
            <tr>
                <td class="hidden-small"></td>
                <td class="column-club">
                    <a href="https://www.fussball.de/mannschaft/sv-fuehlingen-ii-sv-fuehlingen-chorweiler-e-v-mittelrhein/-/saison/2122/team-id/01L64SKETK000000VV0AG80NVTB5JGKG" class="club-wrapper">
                        <div class="club-logo table-image"><span data-alt="Fühlingen II" data-responsive-image="//www.fussball.de/export.media/-/action/getLogo/format/3/id/00ES8GN91400002IVV0AG08LVUPGND5I"></span></div>
                        <div class="club-name">
                            Fühlingen II
                        </div>
                    </a>
                </td>
                <td class="column-colon">:</td>
                <td class="column-club no-border">
                    <a href="https://www.fussball.de/mannschaft/fsv-koeln-99-3-1-fsv-koeln-99-mittelrhein/-/saison/2122/team-id/01HJCT3V0S000000VV0AG80NVT6JKAPB" class="club-wrapper">
                        <div class="club-logo table-image"><span data-alt="FSV Köln III" data-responsive-image="//www.fussball.de/export.media/-/action/getLogo/format/3/id/01HHM9GIN0000000VV0AG80NVS2IB2LC"></span></div>
                        <div class="club-name">
                            FSV Köln III
                        </div>
                    </a>
                </td>
                <td class="column-score">
                    <a href="https://www.fussball.de/spiel/sv-fuehlingen-ii-fsv-koeln-99-3/-/spiel/02F4JJEBFS000000VS5489B4VVD6BKS7"><span data-obfuscation="33dfshl1" class="score-left">&#xE6B7;</span><span class="colon">:</span><span data-obfuscation="33dfshl1" class="score-right">&#xE68D;</span></a>
                </td>
                <td class="column-detail">
                    <a href="https://www.fussball.de/spiel/sv-fuehlingen-ii-fsv-koeln-99-3/-/spiel/02F4JJEBFS000000VS5489B4VVD6BKS7"><span class="icon-angle-right hidden-full"></span><span class="visible-full">Zum Spiel<span class="icon-link-arrow"></span></span></a>
                </td>
            </tr>
            <tr class="row-headline visible-small">
                <td colspan="6">Sonntag, 08.05.2022 - 15:00 Uhr | Herren | Kreisliga C</td>
            </tr>
            <tr class="odd row-competition hidden-small">
                <td class="column-date">15:00</td>
                <td colspan="3" class="column-team">
                    <a>Herren | Kreisliga C</a>
                </td>
                <td colspan="2">
                    <a>ME | 230548205</a>
                </td>
            </tr>
            <tr class="odd">
                <td class="hidden-small"></td>
                <td class="column-club">
                    <a href="https://www.fussball.de/mannschaft/galatasaray-koeln-galatasaray-koeln-mittelrhein/-/saison/2122/team-id/01SFHR5CB8000000VS548984VVB63HJG" class="club-wrapper">
                        <div class="club-logo table-image"><span data-alt="Galatasaray I" data-responsive-image="//www.fussball.de/export.media/-/action/getLogo/format/3/id/01SE6BI47C000000VS548985VV2TPI9R"></span></div>
                        <div class="club-name">
                            Galatasaray I
                        </div>
                    </a>
                </td>
                <td class="column-colon">:</td>
                <td class="column-club no-border">
                    <a href="https://www.fussball.de/mannschaft/sv-fuehlingen-sv-fuehlingen-chorweiler-e-v-mittelrhein/-/saison/2122/team-id/011MIC9NDS000000VTVG0001VTR8C1K7" class="club-wrapper">
                        <div class="club-logo table-image"><span data-alt="Fühlingen I" data-responsive-image="//www.fussball.de/export.media/-/action/getLogo/format/3/id/00ES8GN91400002IVV0AG08LVUPGND5I"></span></div>
                        <div class="club-name">
                            Fühlingen I
                        </div>
                    </a>
                </td>
                <td class="column-score">
                    <a href="https://www.fussball.de/spiel/galatasaray-koeln-sv-fuehlingen/-/spiel/02F47LGT40000000VS5489B4VVD6BKS7"><span data-obfuscation="33dfshl1" class="score-left">&#xE67D;</span><span class="colon">:</span><span data-obfuscation="33dfshl1" class="score-right">&#xE6B7;</span></a>
                </td>
                <td class="column-detail">
                    <a href="https://www.fussball.de/spiel/galatasaray-koeln-sv-fuehlingen/-/spiel/02F47LGT40000000VS5489B4VVD6BKS7"><span class="icon-angle-right hidden-full"></span><span class="visible-full">Zum Spiel<span class="icon-link-arrow"></span></span></a>
                </td>
            </tr>
            <tr class="row-headline visible-small">
                <td colspan="6">Sonntag, 08.05.2022 - 15:15 Uhr | F-Junioren | Kreisfreundschaftsspiele</td>
            </tr>
            <tr class="row-competition hidden-small">
                <td class="column-date">15:15</td>
                <td colspan="3" class="column-team">
                    <a>F-Junioren | Kreisfreundschaftsspiele</a>
                </td>
                <td colspan="2">
                    <a>FS | 260028721</a>
                </td>
            </tr>
            <tr>
                <td class="hidden-small"></td>
                <td class="column-club">
                    <a href="https://www.fussball.de/mannschaft/fuehlingen-u9-sv-fuehlingen-chorweiler-e-v-mittelrhein/-/saison/2122/team-id/011MIB1HRC000000VTVG0001VTR8C1K7" class="club-wrapper">
                        <div class="club-logo table-image"><span data-alt="Fühlingen U9" data-responsive-image="//www.fussball.de/export.media/-/action/getLogo/format/3/id/00ES8GN91400002IVV0AG08LVUPGND5I"></span></div>
                        <div class="club-name">
                            Fühlingen U9
                        </div>
                    </a>
                </td>
                <td class="column-colon">:</td>
                <td class="column-club no-border">
                    <a href="https://www.fussball.de/mannschaft/1-jfc-alsdorf-jfc-alsdorf-mittelrhein/-/saison/2122/team-id/027M2OCQFC000000VS5489B2VSOPA3SJ" class="club-wrapper">
                        <div class="club-logo table-image"><span data-alt="1. JFC Alsdorf" data-responsive-image="//www.fussball.de/export.media/-/action/getLogo/format/3/id/017JL3RVNC000000VV0AG80NVVK58V8S"></span></div>
                        <div class="club-name">
                            1. JFC Alsdorf
                        </div>
                    </a>
                </td>
                <td class="column-score">
                    <a href="https://www.fussball.de/spiel/fuehlingen-u9-1-jfc-alsdorf/-/spiel/02HTGKEA7G000000VS5489B3VTO758MR"></a>
                </td>
                <td class="column-detail">
                    <a href="https://www.fussball.de/spiel/fuehlingen-u9-1-jfc-alsdorf/-/spiel/02HTGKEA7G000000VS5489B3VTO758MR"><span class="icon-angle-right hidden-full"></span><span class="visible-full">Zum Spiel<span class="icon-link-arrow"></span></span></a>
                </td>
            </tr>
            <tr class="row-headline visible-small">
                <td colspan="6">Sonntag, 08.05.2022 - 16:15 Uhr | F-Junioren | Kreisfreundschaftsspiele</td>
            </tr>
            <tr class="odd row-competition hidden-small">
                <td class="column-date">16:15</td>
                <td colspan="3" class="column-team">
                    <a>F-Junioren | Kreisfreundschaftsspiele</a>
                </td>
                <td colspan="2">
                    <a>FS | 260028722</a>
                </td>
            </tr>
            <tr class="odd">
                <td class="hidden-small"></td>
                <td class="column-club">
                    <a href="https://www.fussball.de/mannschaft/fuehlingen-u9-sv-fuehlingen-chorweiler-e-v-mittelrhein/-/saison/2122/team-id/011MIB1HRC000000VTVG0001VTR8C1K7" class="club-wrapper">
                        <div class="club-logo table-image"><span data-alt="Fühlingen U9" data-responsive-image="//www.fussball.de/export.media/-/action/getLogo/format/3/id/00ES8GN91400002IVV0AG08LVUPGND5I"></span></div>
                        <div class="club-name">
                            Fühlingen U9
                        </div>
                    </a>
                </td>
                <td class="column-colon">:</td>
                <td class="column-club no-border">
                    <a href="https://www.fussball.de/mannschaft/fortuna-koeln-u9-sc-fortuna-koeln-ev-mittelrhein/-/saison/2122/team-id/011MIEUUVS000000VTVG0001VTR8C1K7" class="club-wrapper">
                        <div class="club-logo table-image"><span data-alt="Fortuna Köln U9" data-responsive-image="//www.fussball.de/export.media/-/action/getLogo/format/3/id/00ES8GN91400002FVV0AG08LVUPGND5I"></span></div>
                        <div class="club-name">
                            Fortuna Köln U9
                        </div>
                    </a>
                </td>
                <td class="column-score">
                    <a href="https://www.fussball.de/spiel/fuehlingen-u9-fortuna-koeln-u9/-/spiel/02HTGKUFIG000000VS5489B3VTO758MR">
                        <span class="info-text">Absetzung</span>
                    </a>
                </td>
                <td class="column-detail">
                    <a href="https://www.fussball.de/spiel/fuehlingen-u9-fortuna-koeln-u9/-/spiel/02HTGKUFIG000000VS5489B3VTO758MR"><span class="icon-angle-right hidden-full"></span><span class="visible-full">Zum Spiel<span class="icon-link-arrow"></span></span></a>
                </td>
            </tr>
            <tr class="row-headline visible-small">
                <td colspan="6">Samstag, 14.05.2022 - 10:45 Uhr | F-Junioren | 1.Kreisklasse</td>
            </tr>
            <tr class="row-competition hidden-small">
                <td class="column-date"><span class="hidden-small inline">Sa, 14.05.22 |&nbsp;</span>10:45</td>
                <td colspan="3" class="column-team">
                    <a>F-Junioren | 1.Kreisklasse</a>
                </td>
                <td colspan="2">
                    <a>ME | 230764026</a>
                </td>
            </tr>
            <tr>
                <td class="hidden-small"></td>
                <td class="column-club">
                    <a href="https://www.fussball.de/mannschaft/sv-deutz-05-u9-ii-sportvereinigung-deutz-05-ev-mittelrhein/-/saison/2122/team-id/01DRVTSDPC000000VV0AG811VTPFGC7P" class="club-wrapper">
                        <div class="club-logo table-image"><span data-alt="Deutz 05 U9 II" data-responsive-image="//www.fussball.de/export.media/-/action/getLogo/format/3/id/00ES8GN914000021VV0AG08LVUPGND5I"></span></div>
                        <div class="club-name">
                            Deutz 05 U9 II
                        </div>
                    </a>
                </td>
                <td class="column-colon">:</td>
                <td class="column-club no-border">
                    <a href="https://www.fussball.de/mannschaft/fuehlingen-u9-ii-sv-fuehlingen-chorweiler-e-v-mittelrhein/-/saison/2122/team-id/02G5GN1MU8000000VS5489B1VUIB87VA" class="club-wrapper">
                        <div class="club-logo table-image"><span data-alt="Fühlingen U9 II" data-responsive-image="//www.fussball.de/export.media/-/action/getLogo/format/3/id/00ES8GN91400002IVV0AG08LVUPGND5I"></span></div>
                        <div class="club-name">
                            Fühlingen U9 II
                        </div>
                    </a>
                </td>
                <td class="column-score">
                    <a href="https://www.fussball.de/spiel/sv-deutz-05-u9-ii-fuehlingen-u9-ii/-/spiel/02H4B1O1M0000000VS5489B4VUE8K8R1"></a>
                </td>
                <td class="column-detail">
                    <a href="https://www.fussball.de/spiel/sv-deutz-05-u9-ii-fuehlingen-u9-ii/-/spiel/02H4B1O1M0000000VS5489B4VUE8K8R1"><span class="icon-angle-right hidden-full"></span><span class="visible-full">Zum Spiel<span class="icon-link-arrow"></span></span></a>
                </td>
            </tr>
            <tr class="row-headline visible-small">
                <td colspan="6">Samstag, 14.05.2022 - 12:45 Uhr | F-Junioren | 1.Kreisklasse</td>
            </tr>
            <tr class="odd row-competition hidden-small">
                <td class="column-date">12:45</td>
                <td colspan="3" class="column-team">
                    <a>F-Junioren | 1.Kreisklasse</a>
                </td>
                <td colspan="2">
                    <a>ME | 230711122</a>
                </td>
            </tr>
            <tr class="odd">
                <td class="hidden-small"></td>
                <td class="column-club">
                    <a href="https://www.fussball.de/mannschaft/fuehlingen-u9-sv-fuehlingen-chorweiler-e-v-mittelrhein/-/saison/2122/team-id/011MIB1HRC000000VTVG0001VTR8C1K7" class="club-wrapper">
                        <div class="club-logo table-image"><span data-alt="Fühlingen U9" data-responsive-image="//www.fussball.de/export.media/-/action/getLogo/format/3/id/00ES8GN91400002IVV0AG08LVUPGND5I"></span></div>
                        <div class="club-name">
                            Fühlingen U9
                        </div>
                    </a>
                </td>
                <td class="column-colon">:</td>
                <td class="column-club no-border">
                    <a href="https://www.fussball.de/mannschaft/bergfried-leverkusen-u9-ii-sv-bergfried-leverkusen-mittelrhein/-/saison/2122/team-id/011MI98C50000000VTVG0001VTR8C1K7" class="club-wrapper">
                        <div class="club-logo table-image"><span data-alt="Leverkusen Bergfried U9 II" data-responsive-image="//www.fussball.de/export.media/-/action/getLogo/format/3/id/00ES8GN914000036VV0AG08LVUPGND5I"></span></div>
                        <div class="club-name">
                            Leverkusen Bergfried U9 II
                        </div>
                    </a>
                </td>
                <td class="column-score">
                    <a href="https://www.fussball.de/spiel/fuehlingen-u9-bergfried-leverkusen-u9-ii/-/spiel/02FAMMKGV4000000VS5489B3VV76U8DT"></a>
                </td>
                <td class="column-detail">
                    <a href="https://www.fussball.de/spiel/fuehlingen-u9-bergfried-leverkusen-u9-ii/-/spiel/02FAMMKGV4000000VS5489B3VV76U8DT"><span class="icon-angle-right hidden-full"></span><span class="visible-full">Zum Spiel<span class="icon-link-arrow"></span></span></a>
                </td>
            </tr>
            <tr class="row-headline visible-small">
                <td colspan="6">Samstag, 14.05.2022 - 13:30 Uhr | D-Junioren | 1.Kreisklasse</td>
            </tr>
            <tr class="row-competition hidden-small">
                <td class="column-date">13:30</td>
                <td colspan="3" class="column-team">
                    <a>D-Junioren | 1.Kreisklasse</a>
                </td>
                <td colspan="2">
                    <a>ME | 230215126</a>
                </td>
            </tr>
            <tr>
                <td class="hidden-small"></td>
                <td class="column-club">
                    <a href="https://www.fussball.de/mannschaft/fc-pesch-u12-ii-fc-pesch-1956-ev-mittelrhein/-/saison/2122/team-id/020AJNU2E8000000VS548985VSL7HPD7" class="club-wrapper">
                        <div class="club-logo table-image"><span data-alt="Pesch U12 II" data-responsive-image="//www.fussball.de/export.media/-/action/getLogo/format/3/id/00ES8GN914000047VV0AG08LVUPGND5I"></span></div>
                        <div class="club-name">
                            Pesch U12 II
                        </div>
                    </a>
                </td>
                <td class="column-colon">:</td>
                <td class="column-club no-border">
                    <a href="https://www.fussball.de/mannschaft/sv-fuehlingen-u-12-sv-fuehlingen-chorweiler-e-v-mittelrhein/-/saison/2122/team-id/011MICT0UG000000VTVG0001VTR8C1K7" class="club-wrapper">
                        <div class="club-logo table-image"><span data-alt="Fühlingen U12" data-responsive-image="//www.fussball.de/export.media/-/action/getLogo/format/3/id/00ES8GN91400002IVV0AG08LVUPGND5I"></span></div>
                        <div class="club-name">
                            Fühlingen U12
                        </div>
                    </a>
                </td>
                <td class="column-score">
                    <a href="https://www.fussball.de/spiel/fc-pesch-u12-ii-sv-fuehlingen-u-12/-/spiel/02FAE2V33K000000VS5489B3VSQ68S6N"><span data-obfuscation="33dfshl1" class="score-left">&#xE670;</span><span class="colon">:</span><span data-obfuscation="33dfshl1" class="score-right">&#xE6B7;</span></a>
                </td>
                <td class="column-detail">
                    <a href="https://www.fussball.de/spiel/fc-pesch-u12-ii-sv-fuehlingen-u-12/-/spiel/02FAE2V33K000000VS5489B3VSQ68S6N"><span class="icon-angle-right hidden-full"></span><span class="visible-full">Zum Spiel<span class="icon-link-arrow"></span></span></a>
                </td>
            </tr>
            </tbody>
        </table>
        <div data-toggle=".legend > span, .note > span" class="table-meta">
            <ul class="functions">
                <li class="legend"><span data-toggle-content=".table-legend">Legende<span class="icon-angle-down"></span></span></li>
            </ul>
            <div class="table-legend">
                <h3>Kürzel bei einem Spiel</h3>
                <div class="row">
                    <div class="wrapper">
                        <div class="column">
                            <div class="item"><span>u</span></div>
                            <div class="description">(U) Sportgerichtsurteil (bestätigt)</div>
                        </div>
                        <div class="column">
                            <div class="item"><span>Annuliert</span></div>
                            <div class="description">Annullierung</div>
                        </div>
                        <div class="column">
                            <div class="item"><span>v</span></div>
                            <div class="description">(V) Verwaltungsentscheid (bestätigt)</div>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="wrapper">
                        <div class="column">
                            <div class="item"><span>Absetzung</span></div>
                            <div class="description">Spielabsetzung</div>
                        </div>
                        <div class="column">
                            <div class="item"><span>w</span></div>
                            <div class="description">(W) Wertung Spielinstanz (bestätigt)</div>
                        </div>
                        <div class="column">
                            <div class="item"><span>Ausfall</span></div>
                            <div class="description">Spielausfall</div>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="wrapper">
                        <div class="column">
                            <div class="item"><span>t</span></div>
                            <div class="description">(T) Testspiel (bestätigt)</div>
                        </div>
                        <div class="column">
                            <div class="item"><span>Abbruch</span></div>
                            <div class="description">Spielabbruch</div>
                        </div>
                        <div class="column">
                            <div class="item"><span>zg.</span></div>
                            <div class="description">Diese Mannschaft wurde zurückgezogen, die Ergebnisse werden aber eingerechnet.</div>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="wrapper">
                        <div class="column">
                            <div class="item"><span>Nichtantritt BEIDE</span></div>
                            <div class="description">nicht angetretene Mannschaften</div>
                        </div>
                        <div class="column">
                            <div class="item"><span>Nichtantritt HEIM</span></div>
                            <div class="description">nicht angetreten HEIM-Mannschaft</div>
                        </div>
                        <div class="column">
                            <div class="item"><span>Nichtantritt GAST</span></div>
                            <div class="description">nicht angetreten GAST-Mannschaft</div>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="wrapper">
                        <div class="column">
                            <div class="item"><span>nV</span></div>
                            <div class="description">nach Verlängerung</div>
                        </div>
                        <div class="column">
                            <div class="item"><span>nE</span></div>
                            <div class="description">nach Elfmeterschießen</div>
                        </div>
                    </div>
                </div>
                <h3>Sonstiges</h3>
                <div class="row">
                    <div class="wrapper">
                        <div class="column">
                            <div class="item"><span>**</span></div>
                            <div class="description">Die Anstoßzeit steht noch nicht fest oder ist nicht bekannt.</div>
                        </div>
                        <div class="column">
                            <div class="item"><span>o.E.</span></div>
                            <div class="description">Keine Ergebnisanzeige, da die Staffel nicht im Leistungsbetrieb spielt.</div>
                        </div>
                        <div class="column">
                            <div class="item"><span>oW</span></div>
                            <div class="description">Mannschaften mit diesem Kennzeichen spielen außer Konkurrenz.</div>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="wrapper">
                        <div class="column">
                            <div class="item"><span class="icon-verified"></span></div>
                            <div class="description">Ergebnis bestätigt</div>
                        </div>
                        <div class="column">
                            <div class="item"><span>Live</span></div>
                            <div class="description">Liveticker</div>
                        </div>
                        <div class="column">
                            <div class="item"><span>SPIELFREI</span></div>
                            <div class="description">An diesem Datum hat die Mannschaft spielfrei.</div>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="wrapper">
                        <div class="column">
                            <div class="item"><span class="icon-article"></span></div>
                            <div class="description">Spielbericht vorhanden</div>
                        </div>
                        <div class="column">
                            <div class="item"><span class="icon-foto"></span></div>
                            <div class="description">Foto oder Video vorhanden</div>
                        </div>
                        <div class="column">
                            <div class="item"><span class="icon-video"></span></div>
                            <div class="description">Livestream oder Highlights vorhanden</div>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="wrapper">
                        <div class="column">
                            <div class="item"><span class="icon-pre-publish"></span></div>
                            <div class="description">vorläufiges Spiel</div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
''';
    Games games = Games();

    games.scoreFont.font = MockExceptionFont();

    List<ClubMatchInfoTransfer> clubMatchInfoTransferList =
        await games.parseHTML(htmlString, false);

    expect(clubMatchInfoTransferList.length, 10);

    ClubMatchInfoTransfer firstGame = clubMatchInfoTransferList[0];

    expect(firstGame.homeScore, '');
    expect(firstGame.awayScore, '');
    expect(firstGame.homeLogo,
        'https://www.fussball.de/export.media/-/action/getLogo/format/3/id/00ES8GN91400002IVV0AG08LVUPGND5I');
    expect(firstGame.awayLogo,
        'https://www.fussball.de/export.media/-/action/getLogo/format/3/id/00ES8GN91400001GVV0AG08LVUPGND5I');
    expect(firstGame.competition, '1.Kreisklasse');
    expect(firstGame.ageGroup, 'D-Junioren');
    expect(firstGame.awayTeam, 'Dellbrück U12 II');
    expect(firstGame.homeTeam, 'Fühlingen U12');
    expect(firstGame.date, '08.05.2022');
    expect(firstGame.time, '10:00');

    ClubMatchInfoTransfer fJuniorGame = clubMatchInfoTransferList[6];

    expect(fJuniorGame.homeScore, '');
    expect(fJuniorGame.awayScore, '');
    expect(fJuniorGame.homeLogo,
        'https://www.fussball.de/export.media/-/action/getLogo/format/3/id/00ES8GN91400002IVV0AG08LVUPGND5I');
    expect(fJuniorGame.awayLogo,
        'https://www.fussball.de/export.media/-/action/getLogo/format/3/id/00ES8GN91400002FVV0AG08LVUPGND5I');
    expect(fJuniorGame.competition, 'Kreisfreundschaftsspiele');
    expect(fJuniorGame.ageGroup, 'F-Junioren');
    expect(fJuniorGame.awayTeam, 'Fortuna Köln U9');
    expect(fJuniorGame.homeTeam, 'Fühlingen U9');
    expect(fJuniorGame.date, '08.05.2022');
    expect(fJuniorGame.time, '16:15');
  });

  test('parse prev club match', () async {
    final String htmlString = '''
  <!--https://www.fussball.de/ajax.club.prev.games/-/id/00ES8GN91400002IVV0AG08LVUPGND5I/mode/PAGE-->

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
					<td colspan="6">Samstag, 05.08.2023 - 16:10 Uhr | F-Junioren | Kreisfreundschaftsspiele</td>
				</tr>
				<tr class="odd row-competition hidden-small">
					<td class="column-date"><span class="hidden-small inline">Sa, 05.08.23 |&nbsp;</span>16:10</td>
					<td colspan="3" class="column-team">
						<a>F-Junioren | Kreisfreundschaftsspiele</a>
					</td>
					<td colspan="2">
						<a>FS | 260038029</a>
					</td>
				</tr>
				<tr class="odd">
					<td class="hidden-small"></td>
					<td class="column-club">
						<a href="https://www.fussball.de/mannschaft/1-fc-koeln-u8-1-fc-koeln-mittelrhein/-/saison/2324/team-id/01ONF7HBIG000000VV0AG811VT2H9206" class="club-wrapper">
							<div class="club-logo table-image"><span data-alt="1. FC Köln U8" data-responsive-image="//www.fussball.de/export.media/-/action/getLogo/format/3/id/00ES8GN91400002BVV0AG08LVUPGND5I"></span></div>
							<div class="club-name">
								1. FC Köln U8
							</div>
						</a>
					</td>
					<td class="column-colon">:</td>
					<td class="column-club no-border">
						<a href="https://www.fussball.de/mannschaft/west-u9-sc-west-koeln-1900-11-ev-mittelrhein/-/saison/2324/team-id/011MIAO2CG000000VTVG0001VTR8C1K7" class="club-wrapper">
							<div class="club-logo table-image"><span data-alt="West U9" data-responsive-image="//www.fussball.de/export.media/-/action/getLogo/format/3/id/00ES8GN914000053VV0AG08LVUPGND5I"></span></div>
							<div class="club-name">
								West U9
							</div>
						</a>
					</td>
					<td class="column-score">
						<a href="https://www.fussball.de/spiel/1-fc-koeln-u8-west-u9/-/spiel/02MKAOCTJG000000VS5489B3VU34CSAV"><span class="info-text">o.E.</span></a>
					</td>
					<td class="column-detail">
						<a href="https://www.fussball.de/spiel/1-fc-koeln-u8-west-u9/-/spiel/02MKAOCTJG000000VS5489B3VU34CSAV"><span class="icon-angle-right hidden-full"></span><span class="visible-full">Zum Spiel<span class="icon-link-arrow"></span></span></a>
					</td>
				</tr>
				<tr class="row-headline visible-small">
					<td colspan="6">Sonntag, 06.08.2023 - 09:30 Uhr | D-Junioren | Kreisfreundschaftsspiele</td>
				</tr>
				<tr class="row-competition hidden-small">
					<td class="column-date"><span class="hidden-small inline">So, 06.08.23 |&nbsp;</span>09:30</td>
					<td colspan="3" class="column-team">
						<a>D-Junioren | Kreisfreundschaftsspiele</a>
					</td>
					<td colspan="2">
						<a>FS | 260022035</a>
					</td>
				</tr>
				<tr>
					<td class="hidden-small"></td>
					<td class="column-club">
						<a href="https://www.fussball.de/mannschaft/sc-west-koeln-u12-sc-west-koeln-1900-11-ev-mittelrhein/-/saison/2324/team-id/011MIF5IN8000000VTVG0001VTR8C1K7" class="club-wrapper">
							<div class="club-logo table-image"><span data-alt="SC West Köln U12" data-responsive-image="//www.fussball.de/export.media/-/action/getLogo/format/3/id/00ES8GN914000053VV0AG08LVUPGND5I"></span></div>
							<div class="club-name">
								SC West Köln U12
							</div>
						</a>
					</td>
					<td class="column-colon">:</td>
					<td class="column-club no-border">
						<a href="https://www.fussball.de/mannschaft/sv-bergisch-gladbach-u12-sv-bergisch-gladbach-mittelrhein/-/saison/2324/team-id/011MI9NCL4000000VTVG0001VTR8C1K7" class="club-wrapper">
							<div class="club-logo table-image"><span data-alt="SV Bergisch Gladbach U12" data-responsive-image="//www.fussball.de/export.media/-/action/getLogo/format/3/id/00ES8GN92C00002EVV0AG08LVUPGND5I"></span></div>
							<div class="club-name">
								SV Bergisch Gladbach U12
							</div>
						</a>
					</td>
					<td class="column-score">
						<a href="https://www.fussball.de/spiel/sc-west-koeln-u12-sv-bergisch-gladbach-u12/-/spiel/02MBK7IPCC000000VS5489B3VS8P6BMU"><span data-obfuscation="hiigv3hr" class="score-left">&#xE681;</span><span class="colon">:</span><span data-obfuscation="hiigv3hr" class="score-right">&#xE6A0;<span class="icon-verified"></span></span></a>
					</td>
					<td class="column-detail">
						<a href="https://www.fussball.de/spiel/sc-west-koeln-u12-sv-bergisch-gladbach-u12/-/spiel/02MBK7IPCC000000VS5489B3VS8P6BMU"><span class="icon-angle-right hidden-full"></span><span class="visible-full">Zum Spiel<span class="icon-link-arrow"></span></span></a>
					</td>
				</tr>
				<tr class="row-headline visible-small">
					<td colspan="6">Sonntag, 06.08.2023 - 11:00 Uhr | D-Junioren | Kreisfreundschaftsspiele</td>
				</tr>
				<tr class="odd row-competition hidden-small">
					<td class="column-date">11:00</td>
					<td colspan="3" class="column-team">
						<a>D-Junioren | Kreisfreundschaftsspiele</a>
					</td>
					<td colspan="2">
						<a>FS | 260047010</a>
					</td>
				</tr>
				<tr class="odd">
					<td class="hidden-small"></td>
					<td class="column-club">
						<a href="https://www.fussball.de/mannschaft/sv-loevenich-widdersdorf-d4-sv-loevenich-widdersdorf-mittelrhein/-/saison/2324/team-id/01SJ5HKQV4000000VS548985VV6960M6" class="club-wrapper">
							<div class="club-logo table-image"><span data-alt="SV Lövenich/Widdersdorf D4" data-responsive-image="//www.fussball.de/export.media/-/action/getLogo/format/3/id/00ES8GN92C00009GVV0AG08LVUPGND5I"></span></div>
							<div class="club-name">
								SV Lövenich/&#8203;Widdersdorf D4
							</div>
						</a>
					</td>
					<td class="column-colon">:</td>
					<td class="column-club no-border">
						<a href="https://www.fussball.de/mannschaft/sc-west-koeln-u12-ii-sc-west-koeln-1900-11-ev-mittelrhein/-/saison/2324/team-id/01L2456SF4000000VV0AG811VV4PB99G" class="club-wrapper">
							<div class="club-logo table-image"><span data-alt="SC West Köln U12-II" data-responsive-image="//www.fussball.de/export.media/-/action/getLogo/format/3/id/00ES8GN914000053VV0AG08LVUPGND5I"></span></div>
							<div class="club-name">
								SC West Köln U12-II
							</div>
						</a>
					</td>
					<td class="column-score">
						<a href="https://www.fussball.de/spiel/sv-loevenich-widdersdorf-d4-sc-west-koeln-u12-ii/-/spiel/02MAD0OK3C000000VS5489B4VSAUO6GA"><span data-obfuscation="hiigv3hr" class="score-left">&#xE6A5;</span><span class="colon">:</span><span data-obfuscation="hiigv3hr" class="score-right">&#xE6A7;<span class="icon-verified"></span></span></a>
					</td>
					<td class="column-detail">
						<a href="https://www.fussball.de/spiel/sv-loevenich-widdersdorf-d4-sc-west-koeln-u12-ii/-/spiel/02MAD0OK3C000000VS5489B4VSAUO6GA"><span class="icon-angle-right hidden-full"></span><span class="visible-full">Zum Spiel<span class="icon-link-arrow"></span></span></a>
					</td>
				</tr>
				<tr class="row-headline visible-small">
					<td colspan="6">Sonntag, 06.08.2023 - 11:00 Uhr | C-Junioren | Kreisfreundschaftsspiele</td>
				</tr>
				<tr class="row-competition hidden-small">
					<td class="column-date">11:00</td>
					<td colspan="3" class="column-team">
						<a>C-Junioren | Kreisfreundschaftsspiele</a>
					</td>
					<td colspan="2">
						<a>FS | 260032021</a>
					</td>
				</tr>
				<tr>
					<td class="hidden-small"></td>
					<td class="column-club">
						<a href="https://www.fussball.de/mannschaft/u14-sc-west-koeln-sc-west-koeln-1900-11-ev-mittelrhein/-/saison/2324/team-id/011MIBAHC8000000VTVG0001VTR8C1K7" class="club-wrapper">
							<div class="club-logo table-image"><span data-alt="U14 SC West Köln" data-responsive-image="//www.fussball.de/export.media/-/action/getLogo/format/3/id/00ES8GN914000053VV0AG08LVUPGND5I"></span></div>
							<div class="club-name">
								U14 SC West Köln
							</div>
						</a>
					</td>
					<td class="column-colon">:</td>
					<td class="column-club no-border">
						<a href="https://www.fussball.de/mannschaft/fc-viktoria-koeln-u14-fc-viktoria-koeln-mittelrhein/-/saison/2324/team-id/0180KFEV8S000000VV0AG80NVSKU6FO7" class="club-wrapper">
							<div class="club-logo table-image"><span data-alt="FC Viktoria Köln U14" data-responsive-image="//www.fussball.de/export.media/-/action/getLogo/format/3/id/0176O1EUMK000000VV0AG80NVU9EQM09"></span></div>
							<div class="club-name">
								FC Viktoria Köln U14
							</div>
						</a>
					</td>
					<td class="column-score">
						<a href="https://www.fussball.de/spiel/u14-sc-west-koeln-fc-viktoria-koeln-u14/-/spiel/02MBETB3H8000000VS5489B4VSAUO6GA"><span data-obfuscation="hiigv3hr" class="score-left">&#xE66D;</span><span class="colon">:</span><span data-obfuscation="hiigv3hr" class="score-right">&#xE692;<span class="icon-verified"></span></span></a>
					</td>
					<td class="column-detail">
						<a href="https://www.fussball.de/spiel/u14-sc-west-koeln-fc-viktoria-koeln-u14/-/spiel/02MBETB3H8000000VS5489B4VSAUO6GA"><span class="icon-angle-right hidden-full"></span><span class="visible-full">Zum Spiel<span class="icon-link-arrow"></span></span></a>
					</td>
				</tr>
				<tr class="row-headline visible-small">
					<td colspan="6">Sonntag, 06.08.2023 - 11:00 Uhr | B-Junioren | Kreisfreundschaftsspiele</td>
				</tr>
				<tr class="odd row-competition hidden-small">
					<td class="column-date">11:00</td>
					<td colspan="3" class="column-team">
						<a>B-Junioren | Kreisfreundschaftsspiele</a>
					</td>
					<td colspan="2">
						<a>FS | 250104032</a>
					</td>
				</tr>
				<tr class="odd">
					<td class="hidden-small"></td>
					<td class="column-club">
						<a href="https://www.fussball.de/mannschaft/sc-germania-reusrath-sc-germania-reusrath-niederrhein/-/saison/2324/team-id/011MICLMJS000000VTVG0001VTR8C1K7" class="club-wrapper">
							<div class="club-logo table-image"><span data-alt="SC Germania Reusrath" data-responsive-image="//www.fussball.de/export.media/-/action/getLogo/format/3/id/00ES8GN8TC00009RVV0AG08LVUPGND5I"></span></div>
							<div class="club-name">
								SC Germania Reusrath
							</div>
						</a>
					</td>
					<td class="column-colon">:</td>
					<td class="column-club no-border">
						<a href="https://www.fussball.de/mannschaft/sc-west-koeln-iii-sc-west-koeln-1900-11-ev-mittelrhein/-/saison/2324/team-id/02MA0HCBT4000000VS5489B1VV4JLPLE" class="club-wrapper">
							<div class="club-logo table-image"><span data-alt="SC West Köln III" data-responsive-image="//www.fussball.de/export.media/-/action/getLogo/format/3/id/00ES8GN914000053VV0AG08LVUPGND5I"></span></div>
							<div class="club-name">
								SC West Köln III
							</div>
						</a>
					</td>
					<td class="column-score">
						<a href="https://www.fussball.de/spiel/sc-germania-reusrath-sc-west-koeln-iii/-/spiel/02MCUEK7J8000000VS5489B4VSKDJ19I"><span data-obfuscation="hiigv3hr" class="score-left">&#xE678;&#xE684;</span><span class="colon">:</span><span data-obfuscation="hiigv3hr" class="score-right">&#xE6AB;<span class="icon-verified"></span></span></a>
					</td>
					<td class="column-detail">
						<a href="https://www.fussball.de/spiel/sc-germania-reusrath-sc-west-koeln-iii/-/spiel/02MCUEK7J8000000VS5489B4VSKDJ19I"><span class="icon-angle-right hidden-full"></span><span class="visible-full">Zum Spiel<span class="icon-link-arrow"></span></span></a>
					</td>
				</tr>
				<tr class="row-headline visible-small">
					<td colspan="6">Sonntag, 06.08.2023 - 12:45 Uhr | Herren | Kreisfreundschaftsspiele</td>
				</tr>
				<tr class="row-competition hidden-small">
					<td class="column-date">12:45</td>
					<td colspan="3" class="column-team">
						<a>Herren | Kreisfreundschaftsspiele</a>
					</td>
					<td colspan="2">
						<a>FS | 260001140</a>
					</td>
				</tr>
				<tr>
					<td class="hidden-small"></td>
					<td class="column-club">
						<a href="https://www.fussball.de/mannschaft/roland-west-ii-djk-roland-koeln-west-ev-mittelrhein/-/saison/2324/team-id/011MIAPMGO000000VTVG0001VTR8C1K7" class="club-wrapper">
							<div class="club-logo table-image"><span data-alt="Roland West II" data-responsive-image="//www.fussball.de/export.media/-/action/getLogo/format/3/id/00ES8GN91400004MVV0AG08LVUPGND5I"></span></div>
							<div class="club-name">
								Roland West II
							</div>
						</a>
					</td>
					<td class="column-colon">:</td>
					<td class="column-club no-border">
						<a href="https://www.fussball.de/mannschaft/sc-west-ii-sc-west-koeln-1900-11-ev-mittelrhein/-/saison/2324/team-id/011MIC2RLO000000VTVG0001VTR8C1K7" class="club-wrapper">
							<div class="club-logo table-image"><span data-alt="SC West II" data-responsive-image="//www.fussball.de/export.media/-/action/getLogo/format/3/id/00ES8GN914000053VV0AG08LVUPGND5I"></span></div>
							<div class="club-name">
								SC West II
							</div>
						</a>
					</td>
					<td class="column-score">
						<a href="https://www.fussball.de/spiel/roland-west-ii-sc-west-ii/-/spiel/02M92QQVNG000000VS5489B3VVRQ15EP"><span data-obfuscation="hiigv3hr" class="score-left">&#xE68C;</span><span class="colon">:</span><span data-obfuscation="hiigv3hr" class="score-right">&#xE6A3;<span class="icon-verified"></span></span></a>
					</td>
					<td class="column-detail">
						<a href="https://www.fussball.de/spiel/roland-west-ii-sc-west-ii/-/spiel/02M92QQVNG000000VS5489B3VVRQ15EP"><span class="icon-angle-right hidden-full"></span><span class="visible-full">Zum Spiel<span class="icon-link-arrow"></span></span></a>
					</td>
				</tr>
				<tr class="row-headline visible-small">
					<td colspan="6">Sonntag, 06.08.2023 - 14:00 Uhr | B-Junioren | Kreisfreundschaftsspiele</td>
				</tr>
				<tr class="odd row-competition hidden-small">
					<td class="column-date">14:00</td>
					<td colspan="3" class="column-team">
						<a>B-Junioren | Kreisfreundschaftsspiele</a>
					</td>
					<td colspan="2">
						<a>FS | 260023045</a>
					</td>
				</tr>
				<tr class="odd">
					<td class="hidden-small"></td>
					<td class="column-club">
						<a href="https://www.fussball.de/mannschaft/sc-west-koeln-sc-west-koeln-1900-11-ev-mittelrhein/-/saison/2324/team-id/011MI9IEGO000000VTVG0001VTR8C1K7" class="club-wrapper">
							<div class="club-logo table-image"><span data-alt="SC West Köln" data-responsive-image="//www.fussball.de/export.media/-/action/getLogo/format/3/id/00ES8GN914000053VV0AG08LVUPGND5I"></span></div>
							<div class="club-name">
								SC West Köln
							</div>
						</a>
					</td>
					<td class="column-colon">:</td>
					<td class="column-club no-border">
						<a href="https://www.fussball.de/mannschaft/spvgg-egc-wirges-spvgg-glas-chemie-wirges-rheinland/-/saison/2324/team-id/011MIE1GF4000000VTVG0001VTR8C1K7" class="club-wrapper">
							<div class="club-logo table-image"><span data-alt="Spvgg. EGC Wirges" data-responsive-image="//www.fussball.de/export.media/-/action/getLogo/format/3/id/00ES8GNB780000AOVV0AG08LVUPGND5I"></span></div>
							<div class="club-name">
								Spvgg. EGC Wirges
							</div>
						</a>
					</td>
					<td class="column-score">
						<a href="https://www.fussball.de/spiel/sc-west-koeln-spvgg-egc-wirges/-/spiel/02MFIR80K0000000VS5489B4VTIF1KGH"><span data-obfuscation="hiigv3hr" class="score-left">&#xE656;</span><span class="colon">:</span><span data-obfuscation="hiigv3hr" class="score-right">&#xE689;<span class="icon-verified"></span></span></a>
					</td>
					<td class="column-detail">
						<a href="https://www.fussball.de/spiel/sc-west-koeln-spvgg-egc-wirges/-/spiel/02MFIR80K0000000VS5489B4VTIF1KGH"><span class="icon-angle-right hidden-full"></span><span class="visible-full">Zum Spiel<span class="icon-link-arrow"></span></span></a>
					</td>
				</tr>
				<tr class="row-headline visible-small">
					<td colspan="6">Sonntag, 06.08.2023 - 14:00 Uhr | B-Junioren | Kreisfreundschaftsspiele</td>
				</tr>
				<tr class="row-competition hidden-small">
					<td class="column-date">14:00</td>
					<td colspan="3" class="column-team">
						<a>B-Junioren | Kreisfreundschaftsspiele</a>
					</td>
					<td colspan="2">
						<a>FS | 260023046</a>
					</td>
				</tr>
				<tr>
					<td class="hidden-small"></td>
					<td class="column-club">
						<a href="https://www.fussball.de/mannschaft/sc-west-koeln-sc-west-koeln-1900-11-ev-mittelrhein/-/saison/2324/team-id/011MI9IEGO000000VTVG0001VTR8C1K7" class="club-wrapper">
							<div class="club-logo table-image"><span data-alt="SC West Köln" data-responsive-image="//www.fussball.de/export.media/-/action/getLogo/format/3/id/00ES8GN914000053VV0AG08LVUPGND5I"></span></div>
							<div class="club-name">
								SC West Köln
							</div>
						</a>
					</td>
					<td class="column-colon">:</td>
					<td class="column-club no-border">
						<a href="https://www.fussball.de/mannschaft/spvgg-egc-wirges-spvgg-glas-chemie-wirges-rheinland/-/saison/2324/team-id/011MIE1GF4000000VTVG0001VTR8C1K7" class="club-wrapper">
							<div class="club-logo table-image"><span data-alt="Spvgg. EGC Wirges" data-responsive-image="//www.fussball.de/export.media/-/action/getLogo/format/3/id/00ES8GNB780000AOVV0AG08LVUPGND5I"></span></div>
							<div class="club-name">
								Spvgg. EGC Wirges
							</div>
						</a>
					</td>
					<td class="column-score">
						<a href="https://www.fussball.de/spiel/sc-west-koeln-spvgg-egc-wirges/-/spiel/02MFIA901S000000VS5489B4VTIF1KGH"><span class="info-text">Absetzung</span></a>
					</td>
					<td class="column-detail">
						<a href="https://www.fussball.de/spiel/sc-west-koeln-spvgg-egc-wirges/-/spiel/02MFIA901S000000VS5489B4VTIF1KGH"><span class="icon-angle-right hidden-full"></span><span class="visible-full">Zum Spiel<span class="icon-link-arrow"></span></span></a>
					</td>
				</tr>
				<tr class="row-headline visible-small">
					<td colspan="6">Sonntag, 06.08.2023 - 15:00 Uhr | C-Junioren | Landesfreundschaftsspiele</td>
				</tr>
				<tr class="odd row-competition hidden-small">
					<td class="column-date">15:00</td>
					<td colspan="3" class="column-team">
						<a>C-Junioren | Landesfreundschaftsspiele</a>
					</td>
					<td colspan="2">
						<a>FS | 250005030</a>
					</td>
				</tr>
				<tr class="odd">
					<td class="hidden-small"></td>
					<td class="column-club">
						<a href="https://www.fussball.de/mannschaft/hsv-langenfeld-hsv-langenfeld-1959-niederrhein/-/saison/2324/team-id/011MIASBGC000000VTVG0001VTR8C1K7" class="club-wrapper">
							<div class="club-logo table-image"><span data-alt="HSV Langenfeld" data-responsive-image="//www.fussball.de/export.media/-/action/getLogo/format/3/id/00ES8GN8TC00009VVV0AG08LVUPGND5I"></span></div>
							<div class="club-name">
								HSV Langenfeld
							</div>
						</a>
					</td>
					<td class="column-colon">:</td>
					<td class="column-club no-border">
						<a href="https://www.fussball.de/mannschaft/sc-west-koeln-u15-sc-west-koeln-1900-11-ev-mittelrhein/-/saison/2324/team-id/011MICJPMO000000VTVG0001VTR8C1K7" class="club-wrapper">
							<div class="club-logo table-image"><span data-alt="SC West Köln U15" data-responsive-image="//www.fussball.de/export.media/-/action/getLogo/format/3/id/00ES8GN914000053VV0AG08LVUPGND5I"></span></div>
							<div class="club-name">
								SC West Köln U15
							</div>
						</a>
					</td>
					<td class="column-score">
						<a href="https://www.fussball.de/spiel/hsv-langenfeld-sc-west-koeln-u15/-/spiel/02MA0O6H3C000000VS5489B3VVRQ15EP"><span data-obfuscation="hiigv3hr" class="score-left">&#xE695;</span><span class="colon">:</span><span data-obfuscation="hiigv3hr" class="score-right">&#xE6B6;<span class="icon-verified"></span></span></a>
					</td>
					<td class="column-detail">
						<a href="https://www.fussball.de/spiel/hsv-langenfeld-sc-west-koeln-u15/-/spiel/02MA0O6H3C000000VS5489B3VVRQ15EP"><span class="icon-angle-right hidden-full"></span><span class="visible-full">Zum Spiel<span class="icon-link-arrow"></span></span></a>
					</td>
				</tr>
				<tr class="row-headline visible-small">
					<td colspan="6">Dienstag, 08.08.2023 - 18:30 Uhr | B-Junioren | Kreisfreundschaftsspiele</td>
				</tr>
				<tr class="row-competition hidden-small">
					<td class="column-date"><span class="hidden-small inline">Di, 08.08.23 |&nbsp;</span>18:30</td>
					<td colspan="3" class="column-team">
						<a>B-Junioren | Kreisfreundschaftsspiele</a>
					</td>
					<td colspan="2">
						<a>FS | 260023044</a>
					</td>
				</tr>
				<tr>
					<td class="hidden-small"></td>
					<td class="column-club">
						<a href="https://www.fussball.de/mannschaft/tpsk-1925-ev-u17-tpsk-1925-ev-mittelrhein/-/saison/2324/team-id/011MIAD9QC000000VTVG0001VTR8C1K7" class="club-wrapper">
							<div class="club-logo table-image"><span data-alt="TPSK 1925 e.V. U17" data-responsive-image="//www.fussball.de/export.media/-/action/getLogo/format/3/id/00ES8GN914000051VV0AG08LVUPGND5I"></span></div>
							<div class="club-name">
								TPSK 1925 e.V. U17
							</div>
						</a>
					</td>
					<td class="column-colon">:</td>
					<td class="column-club no-border">
						<a href="https://www.fussball.de/mannschaft/sc-west-koeln-iii-sc-west-koeln-1900-11-ev-mittelrhein/-/saison/2324/team-id/02MA0HCBT4000000VS5489B1VV4JLPLE" class="club-wrapper">
							<div class="club-logo table-image"><span data-alt="SC West Köln III" data-responsive-image="//www.fussball.de/export.media/-/action/getLogo/format/3/id/00ES8GN914000053VV0AG08LVUPGND5I"></span></div>
							<div class="club-name">
								SC West Köln III
							</div>
						</a>
					</td>
					<td class="column-score">
						<a href="https://www.fussball.de/spiel/tpsk-1925-ev-u17-sc-west-koeln-iii/-/spiel/02MEVJ0SG8000000VS5489B3VUHHBIEF"><span data-obfuscation="hiigv3hr" class="score-left">&#xE6A0;&#xE68B;</span><span class="colon">:</span><span data-obfuscation="hiigv3hr" class="score-right">&#xE672;<span class="icon-verified"></span></span></a>
					</td>
					<td class="column-detail">
						<a href="https://www.fussball.de/spiel/tpsk-1925-ev-u17-sc-west-koeln-iii/-/spiel/02MEVJ0SG8000000VS5489B3VUHHBIEF"><span class="icon-angle-right hidden-full"></span><span class="visible-full">Zum Spiel<span class="icon-link-arrow"></span></span></a>
					</td>
				</tr>
			</tbody>
		</table>
		<div data-toggle=".legend > span, .note > span" class="table-meta">
			<ul class="functions">
				<li class="legend"><span data-toggle-content=".table-legend">Legende<span class="icon-angle-down"></span></span></li>
			</ul>
			<div class="table-legend">
				<h3>Kürzel bei einem Spiel</h3>
				<div class="row">
					<div class="wrapper">
						<div class="column">
							<div class="item"><span>u</span></div>
							<div class="description">(U) Sportgerichtsurteil (bestätigt)</div>
						</div>
						<div class="column">
							<div class="item"><span>Annuliert</span></div>
							<div class="description">Annullierung</div>
						</div>
						<div class="column">
							<div class="item"><span>v</span></div>
							<div class="description">(V) Verwaltungsentscheid (bestätigt)</div>
						</div>
					</div>
				</div>
				<div class="row">
					<div class="wrapper">
						<div class="column">
							<div class="item"><span>Absetzung</span></div>
							<div class="description">Spielabsetzung</div>
						</div>
						<div class="column">
							<div class="item"><span>w</span></div>
							<div class="description">(W) Wertung Spielinstanz (bestätigt)</div>
						</div>
						<div class="column">
							<div class="item"><span>Ausfall</span></div>
							<div class="description">Spielausfall</div>
						</div>
					</div>
				</div>
				<div class="row">
					<div class="wrapper">
						<div class="column">
							<div class="item"><span>t</span></div>
							<div class="description">(T) Testspiel (bestätigt)</div>
						</div>
						<div class="column">
							<div class="item"><span>Abbruch</span></div>
							<div class="description">Spielabbruch</div>
						</div>
						<div class="column">
							<div class="item"><span>zg.</span></div>
							<div class="description">Diese Mannschaft wurde zurückgezogen, die Ergebnisse werden aber eingerechnet.</div>
						</div>
					</div>
				</div>
				<div class="row">
					<div class="wrapper">
						<div class="column">
							<div class="item"><span>Nichtantritt BEIDE</span></div>
							<div class="description">nicht angetretene Mannschaften</div>
						</div>
						<div class="column">
							<div class="item"><span>Nichtantritt HEIM</span></div>
							<div class="description">nicht angetreten HEIM-Mannschaft</div>
						</div>
						<div class="column">
							<div class="item"><span>Nichtantritt GAST</span></div>
							<div class="description">nicht angetreten GAST-Mannschaft</div>
						</div>
					</div>
				</div>
				<div class="row">
					<div class="wrapper">
						<div class="column">
							<div class="item"><span>nV</span></div>
							<div class="description">nach Verlängerung</div>
						</div>
						<div class="column">
							<div class="item"><span>nE</span></div>
							<div class="description">nach Elfmeterschießen</div>
						</div>
					</div>
				</div>
				<h3>Sonstiges</h3>
				<div class="row">
					<div class="wrapper">
						<div class="column">
							<div class="item"><span>**</span></div>
							<div class="description">Die Anstoßzeit steht noch nicht fest oder ist nicht bekannt.</div>
						</div>
						<div class="column">
							<div class="item"><span>o.E.</span></div>
							<div class="description">Keine Ergebnisanzeige, da die Staffel nicht im Leistungsbetrieb spielt.</div>
						</div>
						<div class="column">
							<div class="item"><span>oW</span></div>
							<div class="description">Mannschaften mit diesem Kennzeichen spielen außer Konkurrenz.</div>
						</div>
					</div>
				</div>
				<div class="row">
					<div class="wrapper">
						<div class="column">
							<div class="item"><span class="icon-verified"></span></div>
							<div class="description">Ergebnis bestätigt</div>
						</div>
						<div class="column">
							<div class="item"><span>Live</span></div>
							<div class="description">Liveticker</div>
						</div>
						<div class="column">
							<div class="item"><span>SPIELFREI</span></div>
							<div class="description">An diesem Datum hat die Mannschaft spielfrei.</div>
						</div>
					</div>
				</div>
				<div class="row">
					<div class="wrapper">
						<div class="column">
							<div class="item"><span class="icon-article"></span></div>
							<div class="description">Spielbericht vorhanden</div>
						</div>
						<div class="column">
							<div class="item"><span class="icon-foto"></span></div>
							<div class="description">Foto oder Video vorhanden</div>
						</div>
						<div class="column">
							<div class="item"><span class="icon-video"></span></div>
							<div class="description">Livestream oder Highlights vorhanden</div>
						</div>
					</div>
				</div>
				<div class="row">
					<div class="wrapper">
						<div class="column">
							<div class="item"><span class="icon-pre-publish"></span></div>
							<div class="description">vorläufiges Spiel</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
  ''';

    Games games = Games();

    ScoreFont scoreFont = ScoreFont();
    scoreFont.fontCache['hiigv3hr'] = {
      "xe650":"9", "xe651":"8", "xe652":"4", "xe653":"2", "xe654":"7", "xe655":"9", "xe656":"3", "xe657":"-", "xe658":"-", "xe659":"3", "xe65a":"9", "xe65b":"6", "xe65c":"2", "xe65d":"9", "xe65e":"8", "xe65f":"5", "xe660":"7", "xe661":"6", "xe662":"6", "xe663":"4", "xe664":"5", "xe665":"1", "xe666":"5", "xe667":"6", "xe668":"7", "xe669":"0", "xe66a":"-", "xe66b":"4", "xe66c":"7", "xe66d":"3", "xe66e":"9", "xe66f":"5", "xe670":"-", "xe671":"9", "xe672":"1", "xe673":"0", "xe674":"8", "xe675":"0", "xe676":"5", "xe677":"2", "xe678":"1", "xe679":"-", "xe67a":"8", "xe67b":"7", "xe67c":"8", "xe67d":"6", "xe67e":"7", "xe67f":"9", "xe680":"2", "xe681":"1", "xe682":"0", "xe683":"3", "xe684":"1", "xe685":"8", "xe686":"3", "xe687":"9", "xe688":"9", "xe689":"2", "xe68a":"2", "xe68b":"1", "xe68c":"3", "xe68d":"0", "xe68e":"-", "xe68f":"6", "xe690":"9", "xe691":"1", "xe692":"3", "xe693":"5", "xe694":"3", "xe695":"1", "xe696":"8", "xe697":"8", "xe698":"5", "xe699":"-", "xe69a":"6", "xe69b":"4", "xe69c":"2", "xe69d":"3", "xe69e":"-", "xe69f":"0", "xe6a0":"1", "xe6a1":"6", "xe6a2":"4", "xe6a3":"7", "xe6a4":"5", "xe6a5":"0", "xe6a6":"8", "xe6a7":"0", "xe6a8":"4", "xe6a9":"4", "xe6aa":"2", "xe6ab":"1", "xe6ac":"-", "xe6ad":"3", "xe6ae":"7", "xe6af":"4", "xe6b0":"2", "xe6b1":"-", "xe6b2":"4", "xe6b3":"6", "xe6b4":"5", "xe6b5":"7", "xe6b6":"2", "xe6b7":"7", "xe6b8":"0", "xe6b9":"4", "xe6ba":"8", "xe6bb":"6", "xe6bc":"5", "xe6bd":"0"};
    scoreFont.font = MockExceptionFont();

    games.scoreFont = scoreFont;

    List<ClubMatchInfoTransfer> clubMatchInfoTransferList =
        await games.parseHTML(htmlString, true);

    expect(clubMatchInfoTransferList.length, 10);

    ClubMatchInfoTransfer firstGame = clubMatchInfoTransferList[0];


    expect(firstGame.homeScore, '');
    expect(firstGame.awayScore, '');
    expect(firstGame.homeLogo,
        'https://www.fussball.de/export.media/-/action/getLogo/format/3/id/00ES8GN91400002BVV0AG08LVUPGND5I');
    expect(firstGame.awayLogo,
        'https://www.fussball.de/export.media/-/action/getLogo/format/3/id/00ES8GN914000053VV0AG08LVUPGND5I');
    expect(firstGame.competition, 'Kreisfreundschaftsspiele');
    expect(firstGame.ageGroup, 'F-Junioren');
    expect(firstGame.awayTeam, 'West U9');
    expect(firstGame.homeTeam, '1. FC Köln U8');
    expect(firstGame.date, '05.08.2023');
    expect(firstGame.time, '16:10');
    expect(firstGame.status, 'o.E.');

    ClubMatchInfoTransfer seniorGame = clubMatchInfoTransferList[4];
    expect(seniorGame.homeScore, '11');
    expect(seniorGame.awayScore, '1');
    expect(seniorGame.competition, 'Kreisfreundschaftsspiele');
    expect(seniorGame.ageGroup, 'B-Junioren');
    expect(seniorGame.awayTeam, 'SC West Köln III');
    expect(seniorGame.homeTeam, 'SC Germania Reusrath');
    expect(seniorGame.date, '06.08.2023');
    expect(seniorGame.time, '11:00');

    ClubMatchInfoTransfer unclearScoreGame = clubMatchInfoTransferList[9];
    expect(unclearScoreGame.homeScore, '11');
    expect(unclearScoreGame.awayScore, '1');
  });

  test('parse prev team match', () async {
    final String htmlString = '''
<div id="id-team-matchplan-table" class="table-container fixtures-matches-table club-matchplan-table">
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
				<td colspan="6">Mittwoch, 09.08.2023 - 20:00 Uhr | Kreisfreundschaftsspiele</td>
			</tr>
			<tr class="odd row-competition hidden-small">
				<td class="column-date"><span class="hidden-small inline">Mi, 09.08.23 |&nbsp;</span>20:00</td>
				<td colspan="3" class="column-team">
					<a>Kreisfreundschaftsspiele</a>
				</td>
				<td colspan="2">
					<a>FS | 260001036</a>
				</td>
			</tr>
			<tr class="odd">
				<td class="hidden-small"></td>
				<td class="column-club">
					<a href="https://www.fussball.de/mannschaft/sv-fuehlingen-ii-sv-fuehlingen-chorweiler-e-v-mittelrhein/-/saison/2324/team-id/01L64SKETK000000VV0AG80NVTB5JGKG" class="club-wrapper">
						<div class="club-logo table-image"><span data-alt="SV Fühlingen II" data-responsive-image="//www.fussball.de/export.media/-/action/getLogo/format/3/id/00ES8GN91400002IVV0AG08LVUPGND5I"></span></div>
						<div class="club-name">
							SV Fühlingen II
						</div>
					</a>
				</td>
				<td class="column-colon">:</td>
				<td class="column-club no-border">
					<a href="https://www.fussball.de/mannschaft/fc-chorweiler-fc-chorweiler-mittelrhein/-/saison/2324/team-id/02LUQE5340000000VS5489B1VVVHS1D7" class="club-wrapper">
						<div class="club-logo table-image"><span data-alt="FC Chorweiler" data-responsive-image="//www.fussball.de/export.media/-/action/getLogo/format/3/id/02LIGFFEN4000000VS5489B5VTLT177U"></span></div>
						<div class="club-name">
							FC Chorweiler
						</div>
					</a>
				</td>
				<td class="column-score">
					<a href="https://www.fussball.de/spiel/sv-fuehlingen-ii-fc-chorweiler/-/spiel/02M6JRL1SS000000VS5489B4VSAUO6GA"><span class="info-text">Absetzung</span></a>
				</td>
				<td class="column-detail">
					<a href="https://www.fussball.de/spiel/sv-fuehlingen-ii-fc-chorweiler/-/spiel/02M6JRL1SS000000VS5489B4VSAUO6GA"><span class="icon-angle-right hidden-full"></span><span class="visible-full">Zum Spiel<span class="icon-link-arrow"></span></span></a>
				</td>
			</tr>
			<tr class="row-headline visible-small">
				<td colspan="6">Sonntag, 06.08.2023 - 13:00 Uhr | Kreisfreundschaftsspiele</td>
			</tr>
			<tr class="row-competition hidden-small">
				<td class="column-date"><span class="hidden-small inline">So, 06.08.23 |&nbsp;</span>13:00</td>
				<td colspan="3" class="column-team">
					<a>Kreisfreundschaftsspiele</a>
				</td>
				<td colspan="2">
					<a>FS | 260001067</a>
				</td>
			</tr>
			<tr>
				<td class="hidden-small"></td>
				<td class="column-club">
					<a href="https://www.fussball.de/mannschaft/sv-fuehlingen-ii-sv-fuehlingen-chorweiler-e-v-mittelrhein/-/saison/2324/team-id/01L64SKETK000000VV0AG80NVTB5JGKG" class="club-wrapper">
						<div class="club-logo table-image"><span data-alt="SV Fühlingen II" data-responsive-image="//www.fussball.de/export.media/-/action/getLogo/format/3/id/00ES8GN91400002IVV0AG08LVUPGND5I"></span></div>
						<div class="club-name">
							SV Fühlingen II
						</div>
					</a>
				</td>
				<td class="column-colon">:</td>
				<td class="column-club no-border">
					<a href="https://www.fussball.de/mannschaft/jsv-koeln-96-iii-jsv-koeln-96-genclerbirligi-mittelrhein/-/saison/2324/team-id/027LDNLPLS000000VS5489B1VTUKARPV" class="club-wrapper">
						<div class="club-logo table-image"><span data-alt="JSV Köln 96 III" data-responsive-image="//www.fussball.de/export.media/-/action/getLogo/format/3/id/00ES8GN91400002CVV0AG08LVUPGND5I"></span></div>
						<div class="club-name">
							JSV Köln 96 III
						</div>
					</a>
				</td>
				<td class="column-score">
					<a href="https://www.fussball.de/spiel/sv-fuehlingen-ii-jsv-koeln-96-iii/-/spiel/02M79QM6T4000000VS5489B3VVRQ15EP"><span data-obfuscation="xlbfavwi" class="score-left">&#xE6B6;</span><span class="colon">:</span><span data-obfuscation="xlbfavwi" class="score-right">&#xE690;<span class="icon-verified"></span></span></a>
				</td>
				<td class="column-detail">
					<a href="https://www.fussball.de/spiel/sv-fuehlingen-ii-jsv-koeln-96-iii/-/spiel/02M79QM6T4000000VS5489B3VVRQ15EP"><span class="icon-angle-right hidden-full"></span><span class="visible-full">Zum Spiel<span class="icon-link-arrow"></span></span></a>
				</td>
			</tr>
			<tr class="row-headline visible-small">
				<td colspan="6">Mittwoch, 02.08.2023 - 20:00 Uhr | Kreisfreundschaftsspiele</td>
			</tr>
			<tr class="odd row-competition hidden-small">
				<td class="column-date"><span class="hidden-small inline">Mi, 02.08.23 |&nbsp;</span>20:00</td>
				<td colspan="3" class="column-team">
					<a>Kreisfreundschaftsspiele</a>
				</td>
				<td colspan="2">
					<a>FS | 260001090</a>
				</td>
			</tr>
			<tr class="odd">
				<td class="hidden-small"></td>
				<td class="column-club">
					<a href="https://www.fussball.de/mannschaft/sv-fuehlingen-ii-sv-fuehlingen-chorweiler-e-v-mittelrhein/-/saison/2324/team-id/01L64SKETK000000VV0AG80NVTB5JGKG" class="club-wrapper">
						<div class="club-logo table-image"><span data-alt="SV Fühlingen II" data-responsive-image="//www.fussball.de/export.media/-/action/getLogo/format/3/id/00ES8GN91400002IVV0AG08LVUPGND5I"></span></div>
						<div class="club-name">
							SV Fühlingen II
						</div>
					</a>
				</td>
				<td class="column-colon">:</td>
				<td class="column-club no-border">
					<a href="https://www.fussball.de/mannschaft/sv-auweiler-esch-59-ev-sv-auweiler-esch-59-ev-mittelrhein/-/saison/2324/team-id/011MIAE8QO000000VTVG0001VTR8C1K7" class="club-wrapper">
						<div class="club-logo table-image"><span data-alt="SV Auweiler-Esch 59 e.V." data-responsive-image="//www.fussball.de/export.media/-/action/getLogo/format/3/id/00ES8GN91400001NVV0AG08LVUPGND5I"></span></div>
						<div class="club-name">
							SV Auweiler-Esch 59 e.V.
						</div>
					</a>
				</td>
				<td class="column-score">
					<a href="https://www.fussball.de/spiel/sv-fuehlingen-ii-sv-auweiler-esch-59-ev/-/spiel/02M7PQ8KIS000000VS5489B3VVRQ15EP"><span class="info-text">Absetzung</span></a>
				</td>
				<td class="column-detail">
					<a href="https://www.fussball.de/spiel/sv-fuehlingen-ii-sv-auweiler-esch-59-ev/-/spiel/02M7PQ8KIS000000VS5489B3VVRQ15EP"><span class="icon-angle-right hidden-full"></span><span class="visible-full">Zum Spiel<span class="icon-link-arrow"></span></span></a>
				</td>
			</tr>
			<tr class="row-headline visible-small">
				<td colspan="6">Mittwoch, 02.08.2023 - 20:00 Uhr | Kreisfreundschaftsspiele</td>
			</tr>
			<tr class="row-competition hidden-small">
				<td class="column-date">20:00</td>
				<td colspan="3" class="column-team">
					<a>Kreisfreundschaftsspiele</a>
				</td>
				<td colspan="2">
					<a>FS | 260001334</a>
				</td>
			</tr>
			<tr>
				<td class="hidden-small"></td>
				<td class="column-club">
					<a href="https://www.fussball.de/mannschaft/sv-fuehlingen-ii-sv-fuehlingen-chorweiler-e-v-mittelrhein/-/saison/2324/team-id/01L64SKETK000000VV0AG80NVTB5JGKG" class="club-wrapper">
						<div class="club-logo table-image"><span data-alt="SV Fühlingen II" data-responsive-image="//www.fussball.de/export.media/-/action/getLogo/format/3/id/00ES8GN91400002IVV0AG08LVUPGND5I"></span></div>
						<div class="club-name">
							SV Fühlingen II
						</div>
					</a>
				</td>
				<td class="column-colon">:</td>
				<td class="column-club no-border">
					<a href="https://www.fussball.de/mannschaft/germania-ossendorf-ii-sc-germania-ossendorf-1894-ev-mittelrhein/-/saison/2324/team-id/01P5I6AIAO000000VV0AG80NVTAI8KUU" class="club-wrapper">
						<div class="club-logo table-image"><span data-alt="Germania Ossendorf II" data-responsive-image="//www.fussball.de/export.media/-/action/getLogo/format/3/id/00ES8GN914000045VV0AG08LVUPGND5I"></span></div>
						<div class="club-name">
							Germania Ossendorf II
						</div>
					</a>
				</td>
				<td class="column-score">
					<a href="https://www.fussball.de/spiel/sv-fuehlingen-ii-germania-ossendorf-ii/-/spiel/02MDVAG3IG000000VS5489B3VS8P6BMU"><span data-obfuscation="xlbfavwi" class="score-left">&#xE6AA;</span><span class="colon">:</span><span data-obfuscation="xlbfavwi" class="score-right">&#xE69F;<span class="icon-verified"></span></span></a>
				</td>
				<td class="column-detail">
					<a href="https://www.fussball.de/spiel/sv-fuehlingen-ii-germania-ossendorf-ii/-/spiel/02MDVAG3IG000000VS5489B3VS8P6BMU"><span class="icon-angle-right hidden-full"></span><span class="visible-full">Zum Spiel<span class="icon-link-arrow"></span></span></a>
				</td>
			</tr>
			<tr class="row-headline visible-small">
				<td colspan="6">Sonntag, 30.07.2023 - 13:00 Uhr | Kreisfreundschaftsspiele</td>
			</tr>
			<tr class="odd row-competition hidden-small">
				<td class="column-date"><span class="hidden-small inline">So, 30.07.23 |&nbsp;</span>13:00</td>
				<td colspan="3" class="column-team">
					<a>Kreisfreundschaftsspiele</a>
				</td>
				<td colspan="2">
					<a>FS | 260001103</a>
				</td>
			</tr>
			<tr class="odd">
				<td class="hidden-small"></td>
				<td class="column-club">
					<a href="https://www.fussball.de/mannschaft/sv-fuehlingen-ii-sv-fuehlingen-chorweiler-e-v-mittelrhein/-/saison/2324/team-id/01L64SKETK000000VV0AG80NVTB5JGKG" class="club-wrapper">
						<div class="club-logo table-image"><span data-alt="SV Fühlingen II" data-responsive-image="//www.fussball.de/export.media/-/action/getLogo/format/3/id/00ES8GN91400002IVV0AG08LVUPGND5I"></span></div>
						<div class="club-name">
							SV Fühlingen II
						</div>
					</a>
				</td>
				<td class="column-colon">:</td>
				<td class="column-club no-border">
					<a href="https://www.fussball.de/mannschaft/fc-bosna-i-bosna-koeln-mittelrhein/-/saison/2324/team-id/012UDJH38S000000VV0AG80NVTJGN4F5" class="club-wrapper">
						<div class="club-logo table-image"><span data-alt="FC Bosna I" data-responsive-image="//www.fussball.de/export.media/-/action/getLogo/format/3/id/012S33IQ7G000000VV0AG80NVVH516BU"></span></div>
						<div class="club-name">
							FC Bosna I
						</div>
					</a>
				</td>
				<td class="column-score">
					<a href="https://www.fussball.de/spiel/sv-fuehlingen-ii-fc-bosna-i/-/spiel/02M83JKHV0000000VS5489B3VVRQ15EP"><span data-obfuscation="xlbfavwi" class="score-left">&#xE661;</span><span class="colon">:</span><span data-obfuscation="xlbfavwi" class="score-right">&#xE690;<span class="icon-verified"></span></span></a>
				</td>
				<td class="column-detail">
					<a href="https://www.fussball.de/spiel/sv-fuehlingen-ii-fc-bosna-i/-/spiel/02M83JKHV0000000VS5489B3VVRQ15EP"><span class="icon-angle-right hidden-full"></span><span class="visible-full">Zum Spiel<span class="icon-link-arrow"></span></span></a>
				</td>
			</tr>
			<tr class="row-headline visible-small">
				<td colspan="6">Sonntag, 23.07.2023 - 13:00 Uhr | Kreisfreundschaftsspiele</td>
			</tr>
			<tr class="row-competition hidden-small">
				<td class="column-date"><span class="hidden-small inline">So, 23.07.23 |&nbsp;</span>13:00</td>
				<td colspan="3" class="column-team">
					<a>Kreisfreundschaftsspiele</a>
				</td>
				<td colspan="2">
					<a>FS | 260001349</a>
				</td>
			</tr>
			<tr>
				<td class="hidden-small"></td>
				<td class="column-club">
					<a href="https://www.fussball.de/mannschaft/spiel-und-sport-1912-nippes-2-spiel-und-sport-1912-nippes-mittelrhein/-/saison/2324/team-id/01SIH3AD4C000000VS548985VV6960M6" class="club-wrapper">
						<div class="club-logo table-image"><span data-alt="Spiel und Sport 1912 Nippes 2" data-responsive-image="//www.fussball.de/export.media/-/action/getLogo/format/3/id/00ES8GN91400003SVV0AG08LVUPGND5I"></span></div>
						<div class="club-name">
							Spiel und Sport 1912 Nippes 2
						</div>
					</a>
				</td>
				<td class="column-colon">:</td>
				<td class="column-club no-border">
					<a href="https://www.fussball.de/mannschaft/sv-fuehlingen-ii-sv-fuehlingen-chorweiler-e-v-mittelrhein/-/saison/2324/team-id/01L64SKETK000000VV0AG80NVTB5JGKG" class="club-wrapper">
						<div class="club-logo table-image"><span data-alt="SV Fühlingen II" data-responsive-image="//www.fussball.de/export.media/-/action/getLogo/format/3/id/00ES8GN91400002IVV0AG08LVUPGND5I"></span></div>
						<div class="club-name">
							SV Fühlingen II
						</div>
					</a>
				</td>
				<td class="column-score">
					<a href="https://www.fussball.de/spiel/spiel-und-sport-1912-nippes-2-sv-fuehlingen-ii/-/spiel/02MEJJ74NO000000VS5489B3VUHHBIEF"><span data-obfuscation="xlbfavwi" class="score-left">&#xE692;</span><span class="colon">:</span><span data-obfuscation="xlbfavwi" class="score-right">&#xE67B;<span class="icon-verified"></span></span></a>
				</td>
				<td class="column-detail">
					<a href="https://www.fussball.de/spiel/spiel-und-sport-1912-nippes-2-sv-fuehlingen-ii/-/spiel/02MEJJ74NO000000VS5489B3VUHHBIEF"><span class="icon-angle-right hidden-full"></span><span class="visible-full">Zum Spiel<span class="icon-link-arrow"></span></span></a>
				</td>
			</tr>
			<tr class="row-headline visible-small">
				<td colspan="6">Sonntag, 11.06.2023 - 13:00 Uhr | Kreisliga D</td>
			</tr>
			<tr class="odd row-competition hidden-small">
				<td class="column-date"><span class="hidden-small inline">So, 11.06.23 |&nbsp;</span>13:00</td>
				<td colspan="3" class="column-team">
					<a>Kreisliga D</a>
				</td>
				<td colspan="2">
					<a>ME | 230556237</a>
				</td>
			</tr>
			<tr class="odd">
				<td class="hidden-small"></td>
				<td class="column-club">
					<a href="https://www.fussball.de/mannschaft/ksv-heimersdorf-ii-ksv-59-65-ev-heimersdorf-mittelrhein/-/saison/2223/team-id/02ILA6DIRO000000VS5489B2VVQ9C6A6" class="club-wrapper">
						<div class="club-logo table-image"><span data-alt="Heimersdorf II" data-responsive-image="//www.fussball.de/export.media/-/action/getLogo/format/3/id/00ES8GN91400002NVV0AG08LVUPGND5I"></span></div>
						<div class="club-name">
							Heimersdorf II
						</div>
					</a>
				</td>
				<td class="column-colon">:</td>
				<td class="column-club no-border">
					<a href="https://www.fussball.de/mannschaft/sv-fuehlingen-ii-sv-fuehlingen-chorweiler-e-v-mittelrhein/-/saison/2223/team-id/01L64SKETK000000VV0AG80NVTB5JGKG" class="club-wrapper">
						<div class="club-logo table-image"><span data-alt="Fühlingen II" data-responsive-image="//www.fussball.de/export.media/-/action/getLogo/format/3/id/00ES8GN91400002IVV0AG08LVUPGND5I"></span></div>
						<div class="club-name">
							Fühlingen II
						</div>
					</a>
				</td>
				<td class="column-score">
					<a href="https://www.fussball.de/spiel/ksv-heimersdorf-ii-sv-fuehlingen-ii/-/spiel/02IPRFAEGK000000VS5489B3VUDHAAN1"><span data-obfuscation="xlbfavwi" class="score-left">&#xE677;</span><span class="colon">:</span><span data-obfuscation="xlbfavwi" class="score-right">&#xE677;<span class="icon-verified"></span></span></a>
				</td>
				<td class="column-detail">
					<a href="https://www.fussball.de/spiel/ksv-heimersdorf-ii-sv-fuehlingen-ii/-/spiel/02IPRFAEGK000000VS5489B3VUDHAAN1"><span class="icon-angle-right hidden-full"></span><span class="visible-full">Zum Spiel<span class="icon-link-arrow"></span></span></a>
				</td>
			</tr>
			<tr class="row-headline visible-small">
				<td colspan="6">Sonntag, 04.06.2023 - 13:00 Uhr | Kreisfreundschaftsspiele</td>
			</tr>
			<tr class="row-competition hidden-small">
				<td class="column-date"><span class="hidden-small inline">So, 04.06.23 |&nbsp;</span>13:00</td>
				<td colspan="3" class="column-team">
					<a>Kreisfreundschaftsspiele</a>
				</td>
				<td colspan="2">
					<a>FS | 260010471</a>
				</td>
			</tr>
			<tr>
				<td class="hidden-small"></td>
				<td class="column-club">
					<a href="https://www.fussball.de/mannschaft/sc-weiler-volkhoven-ii-sc-koeln-weiler-volkhoven-1948-mittelrhein/-/saison/2223/team-id/011MI9IHB4000000VTVG0001VTR8C1K7" class="club-wrapper">
						<div class="club-logo table-image"><span data-alt="SC Weiler-Volkhoven II" data-responsive-image="//www.fussball.de/export.media/-/action/getLogo/format/3/id/00ES8GN91400005JVV0AG08LVUPGND5I"></span></div>
						<div class="club-name">
							SC Weiler-Volkhoven II
						</div>
					</a>
				</td>
				<td class="column-colon">:</td>
				<td class="column-club no-border">
					<a href="https://www.fussball.de/mannschaft/sv-fuehlingen-ii-sv-fuehlingen-chorweiler-e-v-mittelrhein/-/saison/2223/team-id/01L64SKETK000000VV0AG80NVTB5JGKG" class="club-wrapper">
						<div class="club-logo table-image"><span data-alt="SV Fühlingen II" data-responsive-image="//www.fussball.de/export.media/-/action/getLogo/format/3/id/00ES8GN91400002IVV0AG08LVUPGND5I"></span></div>
						<div class="club-name">
							SV Fühlingen II
						</div>
					</a>
				</td>
				<td class="column-score">
					<a href="https://www.fussball.de/spiel/sc-weiler-volkhoven-ii-sv-fuehlingen-ii/-/spiel/02LUPNEM2K000000VS5489B3VTVUJRS3"><span data-obfuscation="xlbfavwi" class="score-left">&#xE6A9;</span><span class="colon">:</span><span data-obfuscation="xlbfavwi" class="score-right">&#xE683;<span class="icon-verified"></span></span></a>
				</td>
				<td class="column-detail">
					<a href="https://www.fussball.de/spiel/sc-weiler-volkhoven-ii-sv-fuehlingen-ii/-/spiel/02LUPNEM2K000000VS5489B3VTVUJRS3"><span class="icon-angle-right hidden-full"></span><span class="visible-full">Zum Spiel<span class="icon-link-arrow"></span></span></a>
				</td>
			</tr>
			<tr class="row-headline visible-small">
				<td colspan="6">Montag, 29.05.2023 - 13:00 Uhr | Kreisliga D</td>
			</tr>
			<tr class="odd row-competition hidden-small">
				<td class="column-date"><span class="hidden-small inline">Mo, 29.05.23 |&nbsp;</span>13:00</td>
				<td colspan="3" class="column-team">
					<a>Kreisliga D</a>
				</td>
				<td colspan="2">
					<a>ME | 230556221</a>
				</td>
			</tr>
			<tr class="odd">
				<td class="hidden-small"></td>
				<td class="column-club">
					<a href="https://www.fussball.de/mannschaft/raderthal-ii-raderthal-kickers-koeln-1991-mittelrhein/-/saison/2223/team-id/011MIBH8R8000000VTVG0001VTR8C1K7" class="club-wrapper">
						<div class="club-logo table-image"><span data-alt="Raderthal II" data-responsive-image="//www.fussball.de/export.media/-/action/getLogo/format/3/id/00ES8GN91400004EVV0AG08LVUPGND5I"></span></div>
						<div class="club-name">
							Raderthal II
						</div>
					</a>
				</td>
				<td class="column-colon">:</td>
				<td class="column-club no-border">
					<a href="https://www.fussball.de/mannschaft/sv-fuehlingen-ii-sv-fuehlingen-chorweiler-e-v-mittelrhein/-/saison/2223/team-id/01L64SKETK000000VV0AG80NVTB5JGKG" class="club-wrapper">
						<div class="club-logo table-image"><span data-alt="Fühlingen II" data-responsive-image="//www.fussball.de/export.media/-/action/getLogo/format/3/id/00ES8GN91400002IVV0AG08LVUPGND5I"></span></div>
						<div class="club-name">
							Fühlingen II
						</div>
					</a>
				</td>
				<td class="column-score">
					<a href="https://www.fussball.de/spiel/raderthal-ii-sv-fuehlingen-ii/-/spiel/02IPRFAFBK000000VS5489B3VUDHAAN1"><span data-obfuscation="xlbfavwi" class="score-left">&#xE651;</span><span class="colon">:</span><span data-obfuscation="xlbfavwi" class="score-right">&#xE675;<span class="icon-verified"></span></span></a>
				</td>
				<td class="column-detail">
					<a href="https://www.fussball.de/spiel/raderthal-ii-sv-fuehlingen-ii/-/spiel/02IPRFAFBK000000VS5489B3VUDHAAN1"><span class="icon-angle-right hidden-full"></span><span class="visible-full">Zum Spiel<span class="icon-link-arrow"></span></span></a>
				</td>
			</tr>
			<tr class="row-headline visible-small">
				<td colspan="6">Sonntag, 21.05.2023 - 13:00 Uhr | Kreisliga D</td>
			</tr>
			<tr class="row-competition hidden-small">
				<td class="column-date"><span class="hidden-small inline">So, 21.05.23 |&nbsp;</span>13:00</td>
				<td colspan="3" class="column-team">
					<a>Kreisliga D</a>
				</td>
				<td colspan="2">
					<a>ME | 230556210</a>
				</td>
			</tr>
			<tr>
				<td class="hidden-small"></td>
				<td class="column-club">
					<a href="https://www.fussball.de/mannschaft/sv-fuehlingen-ii-sv-fuehlingen-chorweiler-e-v-mittelrhein/-/saison/2223/team-id/01L64SKETK000000VV0AG80NVTB5JGKG" class="club-wrapper">
						<div class="club-logo table-image"><span data-alt="Fühlingen II" data-responsive-image="//www.fussball.de/export.media/-/action/getLogo/format/3/id/00ES8GN91400002IVV0AG08LVUPGND5I"></span></div>
						<div class="club-name">
							Fühlingen II
						</div>
					</a>
				</td>
				<td class="column-colon">:</td>
				<td class="column-club no-border">
					<a href="https://www.fussball.de/mannschaft/roland-west-iii-djk-roland-koeln-west-ev-mittelrhein/-/saison/2223/team-id/02EVMIPGF4000000VS5489B1VT1H0S9M" class="club-wrapper">
						<div class="club-logo table-image"><span data-alt="Roland West III" data-responsive-image="//www.fussball.de/export.media/-/action/getLogo/format/3/id/00ES8GN91400004MVV0AG08LVUPGND5I"></span></div>
						<div class="club-name">
							Roland West III
						</div>
					</a>
				</td>
				<td class="column-score">
					<a href="https://www.fussball.de/spiel/sv-fuehlingen-ii-roland-west-iii/-/spiel/02IPRFAFTG000000VS5489B3VUDHAAN1"><span data-obfuscation="xlbfavwi" class="score-left">&#xE685;</span><span class="colon">:</span><span data-obfuscation="xlbfavwi" class="score-right">&#xE69A;<span class="icon-verified"></span></span></a>
				</td>
				<td class="column-detail">
					<a href="https://www.fussball.de/spiel/sv-fuehlingen-ii-roland-west-iii/-/spiel/02IPRFAFTG000000VS5489B3VUDHAAN1"><span class="icon-angle-right hidden-full"></span><span class="visible-full">Zum Spiel<span class="icon-link-arrow"></span></span></a>
				</td>
			</tr>
		</tbody>
	</table>
	<div data-toggle=".legend > span, .note > span" class="table-meta">
		<ul class="functions">
			<li class="legend"><span data-toggle-content=".table-legend">Legende<span class="icon-angle-down"></span></span></li>
		</ul>
		<div class="table-legend">
			<h3>Kürzel bei einem Spiel</h3>
			<div class="row">
				<div class="wrapper">
					<div class="column">
						<div class="item"><span>u</span></div>
						<div class="description">(U) Sportgerichtsurteil (bestätigt)</div>
					</div>
					<div class="column">
						<div class="item"><span>Annuliert</span></div>
						<div class="description">Annullierung</div>
					</div>
					<div class="column">
						<div class="item"><span>v</span></div>
						<div class="description">(V) Verwaltungsentscheid (bestätigt)</div>
					</div>
				</div>
			</div>
			<div class="row">
				<div class="wrapper">
					<div class="column">
						<div class="item"><span>Absetzung</span></div>
						<div class="description">Spielabsetzung</div>
					</div>
					<div class="column">
						<div class="item"><span>w</span></div>
						<div class="description">(W) Wertung Spielinstanz (bestätigt)</div>
					</div>
					<div class="column">
						<div class="item"><span>Ausfall</span></div>
						<div class="description">Spielausfall</div>
					</div>
				</div>
			</div>
			<div class="row">
				<div class="wrapper">
					<div class="column">
						<div class="item"><span>t</span></div>
						<div class="description">(T) Testspiel (bestätigt)</div>
					</div>
					<div class="column">
						<div class="item"><span>Abbruch</span></div>
						<div class="description">Spielabbruch</div>
					</div>
					<div class="column">
						<div class="item"><span>zg.</span></div>
						<div class="description">Diese Mannschaft wurde zurückgezogen, die Ergebnisse werden aber eingerechnet.</div>
					</div>
				</div>
			</div>
			<div class="row">
				<div class="wrapper">
					<div class="column">
						<div class="item"><span>Nichtantritt BEIDE</span></div>
						<div class="description">nicht angetretene Mannschaften</div>
					</div>
					<div class="column">
						<div class="item"><span>Nichtantritt HEIM</span></div>
						<div class="description">nicht angetreten HEIM-Mannschaft</div>
					</div>
					<div class="column">
						<div class="item"><span>Nichtantritt GAST</span></div>
						<div class="description">nicht angetreten GAST-Mannschaft</div>
					</div>
				</div>
			</div>
			<div class="row">
				<div class="wrapper">
					<div class="column">
						<div class="item"><span>nV</span></div>
						<div class="description">nach Verlängerung</div>
					</div>
					<div class="column">
						<div class="item"><span>nE</span></div>
						<div class="description">nach Elfmeterschießen</div>
					</div>
				</div>
			</div>
			<h3>Sonstiges</h3>
			<div class="row">
				<div class="wrapper">
					<div class="column">
						<div class="item"><span>**</span></div>
						<div class="description">Die Anstoßzeit steht noch nicht fest oder ist nicht bekannt.</div>
					</div>
					<div class="column">
						<div class="item"><span>o.E.</span></div>
						<div class="description">Keine Ergebnisanzeige, da die Staffel nicht im Leistungsbetrieb spielt.</div>
					</div>
					<div class="column">
						<div class="item"><span>oW</span></div>
						<div class="description">Mannschaften mit diesem Kennzeichen spielen außer Konkurrenz.</div>
					</div>
				</div>
			</div>
			<div class="row">
				<div class="wrapper">
					<div class="column">
						<div class="item"><span class="icon-verified"></span></div>
						<div class="description">Ergebnis bestätigt</div>
					</div>
					<div class="column">
						<div class="item"><span>Live</span></div>
						<div class="description">Liveticker</div>
					</div>
					<div class="column">
						<div class="item"><span>SPIELFREI</span></div>
						<div class="description">An diesem Datum hat die Mannschaft spielfrei.</div>
					</div>
				</div>
			</div>
			<div class="row">
				<div class="wrapper">
					<div class="column">
						<div class="item"><span class="icon-article"></span></div>
						<div class="description">Spielbericht vorhanden</div>
					</div>
					<div class="column">
						<div class="item"><span class="icon-foto"></span></div>
						<div class="description">Foto oder Video vorhanden</div>
					</div>
					<div class="column">
						<div class="item"><span class="icon-video"></span></div>
						<div class="description">Livestream oder Highlights vorhanden</div>
					</div>
				</div>
			</div>
			<div class="row">
				<div class="wrapper">
					<div class="column">
						<div class="item"><span class="icon-pre-publish"></span></div>
						<div class="description">vorläufiges Spiel</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div> 
''';

    Games games = Games();

    ScoreFont scoreFont = ScoreFont();
    scoreFont.fontCache['xlbfavwi'] = {"xe650":"4","xe651":"0","xe652":"7","xe653":"5","xe654":"7","xe655":"6","xe656":"5","xe657":"1","xe658":"0","xe659":"9","xe65a":"-","xe65b":"1","xe65c":"4","xe65d":"4","xe65e":"3","xe65f":"5","xe660":"8","xe661":"0","xe662":"5","xe663":"9","xe664":"1","xe665":"0","xe666":"2","xe667":"4","xe668":"8","xe669":"9","xe66a":"9","xe66b":"1","xe66c":"0","xe66d":"-","xe66e":"9","xe66f":"1","xe670":"6","xe671":"2","xe672":"0","xe673":"-","xe674":"1","xe675":"4","xe676":"4","xe677":"1","xe678":"8","xe679":"2","xe67a":"5","xe67b":"2","xe67c":"7","xe67d":"7","xe67e":"5","xe67f":"-","xe680":"3","xe681":"3","xe682":"8","xe683":"7","xe684":"7","xe685":"0","xe686":"6","xe687":"8","xe688":"7","xe689":"8","xe68a":"9","xe68b":"0","xe68c":"7","xe68d":"2","xe68e":"6","xe68f":"4","xe690":"3","xe691":"3","xe692":"5","xe693":"8","xe694":"5","xe695":"8","xe696":"4","xe697":"3","xe698":"5","xe699":"-","xe69a":"2","xe69b":"8","xe69c":"1","xe69d":"0","xe69e":"-","xe69f":"2","xe6a0":"3","xe6a1":"3","xe6a2":"-","xe6a3":"8","xe6a4":"6","xe6a5":"-","xe6a6":"5","xe6a7":"6","xe6a8":"6","xe6a9":"4","xe6aa":"9","xe6ab":"6","xe6ac":"7","xe6ad":"4","xe6ae":"2","xe6af":"-","xe6b0":"3","xe6b1":"2","xe6b2":"9","xe6b3":"6","xe6b4":"1","xe6b5":"-","xe6b6":"0","xe6b7":"2","xe6b8":"7","xe6b9":"3","xe6ba":"6","xe6bb":"1","xe6bc":"9","xe6bd":"9"};
    scoreFont.font = MockExceptionFont();

    games.scoreFont = scoreFont;

    List<ClubMatchInfoTransfer> clubMatchInfoTransferList =
    await games.parseHTML(htmlString, true);

    expect(clubMatchInfoTransferList.length, 10);

    ClubMatchInfoTransfer firstGame = clubMatchInfoTransferList[0];

    expect(firstGame.homeTeam, "SV Fühlingen II");
    expect(firstGame.awayTeam, "FC Chorweiler");
    expect(firstGame.status, "Absetzung");
    expect(firstGame.homeScore, "");
    expect(firstGame.awayScore, "");
    expect(firstGame.time, "20:00");
    expect(firstGame.date, "09.08.2023");
    expect(firstGame.ageGroup, "");
    expect(firstGame.competition, "Kreisfreundschaftsspiele");

    ClubMatchInfoTransfer lastGame = clubMatchInfoTransferList[9];

    expect(lastGame.homeTeam, "Fühlingen II");
    expect(lastGame.awayTeam, "Roland West III");
    expect(lastGame.competition, "Kreisliga D");
    expect(lastGame.time, "13:00");
    expect(lastGame.date, "21.05.2023");
    expect(lastGame.homeScore, "0");
    expect(lastGame.awayScore, "2");
    expect(lastGame.ageGroup, "");
    expect(lastGame.status, "");
  });
}
