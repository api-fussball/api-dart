import 'package:api_fussball_dart/dto/club_match_info_transfer.dart';
import 'package:test/test.dart';
import 'package:api_fussball_dart/html/games.dart';

void main() {
  test('Test nächste games', () async {

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
                    <a href="https://www.fussball.de/spiel/fuehlingen-u9-fortuna-koeln-u9/-/spiel/02HTGKUFIG000000VS5489B3VTO758MR"></a>
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

    List<ClubMatchInfoTransfer> clubMatchInfoTransferList = games.parseHTML(htmlString);

    expect(clubMatchInfoTransferList.length, 10);

    ClubMatchInfoTransfer firstGame = clubMatchInfoTransferList[0];

    expect(firstGame.homeScore, '');
    expect(firstGame.awayScore, '');
    expect(firstGame.homeLogo, 'https://www.fussball.de/export.media/-/action/getLogo/format/3/id/00ES8GN91400002IVV0AG08LVUPGND5I');
    expect(firstGame.awayLogo, 'https://www.fussball.de/export.media/-/action/getLogo/format/3/id/00ES8GN91400001GVV0AG08LVUPGND5I');
    expect(firstGame.competition, '1.Kreisklasse');
    expect(firstGame.ageGroup, 'D-Junioren');
    expect(firstGame.awayTeam, 'Dellbrück U12 II');
    expect(firstGame.homeTeam, 'Fühlingen U12');
    expect(firstGame.date, '08.05.2022');
    expect(firstGame.time, '10:00');

    ClubMatchInfoTransfer fJuniorGame = clubMatchInfoTransferList[6];

    expect(fJuniorGame.homeScore, '');
    expect(fJuniorGame.awayScore, '');
    expect(fJuniorGame.homeLogo, 'https://www.fussball.de/export.media/-/action/getLogo/format/3/id/00ES8GN91400002IVV0AG08LVUPGND5I');
    expect(fJuniorGame.awayLogo, 'https://www.fussball.de/export.media/-/action/getLogo/format/3/id/00ES8GN91400002FVV0AG08LVUPGND5I');
    expect(fJuniorGame.competition, 'Kreisfreundschaftsspiele');
    expect(fJuniorGame.ageGroup, 'F-Junioren');
    expect(fJuniorGame.awayTeam, 'Fortuna Köln U9');
    expect(fJuniorGame.homeTeam, 'Fühlingen U9');
    expect(fJuniorGame.date, '08.05.2022');
    expect(fJuniorGame.time, '16:15');
  });
}
