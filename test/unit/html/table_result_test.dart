import 'package:api_fussball_dart/html/table_result.dart';
import 'package:test/test.dart';

void main() {
  test('table result', () async {
    final String htmlString = '''
<!--https://www.fussball.de/ajax.team.table/-/team-id/011MIAD9JG000000VTVG0001VTR8C1K7-->
<div id="team-fixture-league-tables" class="table-container fixtures-league-table">
    <table class="table table-striped table-full-width">
        <thead>
        <tr class="thead">
            <th colspan="2"><span class="visible-small">Pl.</span><span class="hidden-small">Platz</span></th>
            <th class="column-large">Mannschaft</th>
            <th><span class="visible-small">Sp.</span><span class="hidden-small">Spiele</span></th>
            <th class="hidden-small">G</th>
            <th class="hidden-small">U</th>
            <th class="hidden-small">V</th>
            <th><span class="visible-small">Torv.</span><span class="hidden-small">Torverhältnis</span></th>
            <th class="hidden-small">Tordifferenz</th>
            <th><span class="visible-small">Pkt.</span><span class="hidden-small">Punkte</span></th>
        </tr>
        </thead>
        <tbody>
        <tr class="row-promotion">
            <td class="column-icon"><span class="icon-arrow-right"></span></td>
            <td class="column-rank">
                1.
            </td>
            <td class="column-club">
                <a href="https://www.fussball.de/mannschaft/tfg-koeln-nippes-78-u14-tfg-koeln-nippes-1878-mittelrhein/-/saison/2122/team-id/027KNMTODS000000VS5489B1VUA37ON8" class="club-wrapper">
                    <div class="club-logo table-image">
                        <img src="//www.fussball.de/export.media/-/action/getLogo/format/3/id/00ES8GN91400003TVV0AG08LVUPGND5I/verband/0123456789ABCDEF0123456700004120" alt="Nippes 78 U14">
                    </div>
                    <div class="club-name">
                        Nippes 78 U14
                    </div>
                </a>
            </td>
            <td>18</td>
            <td class="hidden-small">14</td>
            <td class="hidden-small">2</td>
            <td class="hidden-small">2</td>
            <td class="no-wrap">93 : 18</td>
            <td class="hidden-small">75</td>
            <td class="column-points">44</td>
        </tr>
        <tr class="odd">
            <td class="column-icon"><span class="icon-arrow-right"></span></td>
            <td class="column-rank">
                2.
            </td>
            <td class="column-club">
                <a href="https://www.fussball.de/mannschaft/sc-blau-weiss-koeln-u14-i-sc-blau-weiss-06-koeln-ev-mittelrhein/-/saison/2122/team-id/020AIMN4RK000000VS548984VV30KF68" class="club-wrapper">
                    <div class="club-logo table-image">
                        <img src="//www.fussball.de/export.media/-/action/getLogo/format/3/id/00ES8GN91400001PVV0AG08LVUPGND5I/verband/0123456789ABCDEF0123456700004120" alt="Blau-Weiß U14">
                    </div>
                    <div class="club-name">
                        Blau-Weiß U14
                    </div>
                </a>
            </td>
            <td>19</td>
            <td class="hidden-small">14</td>
            <td class="hidden-small">1</td>
            <td class="hidden-small">4</td>
            <td class="no-wrap">108 : 36</td>
            <td class="hidden-small">72</td>
            <td class="column-points">43</td>
        </tr>
        <tr>
            <td class="column-icon"><span class="icon-arrow-right"></span></td>
            <td class="column-rank">
                3.
            </td>
            <td class="column-club">
                <a href="https://www.fussball.de/mannschaft/sc-rondorf-u14-sc-rondorf-1912-ev-mittelrhein/-/saison/2122/team-id/02EJL1TL10000000VS5489B2VS183IS6" class="club-wrapper">
                    <div class="club-logo table-image">
                        <img src="//www.fussball.de/export.media/-/action/getLogo/format/3/id/00ES8GN91400004NVV0AG08LVUPGND5I/verband/0123456789ABCDEF0123456700004120" alt="Rondorf U14">
                    </div>
                    <div class="club-name">
                        Rondorf U14
                    </div>
                </a>
            </td>
            <td>18</td>
            <td class="hidden-small">14</td>
            <td class="hidden-small">0</td>
            <td class="hidden-small">4</td>
            <td class="no-wrap">78 : 37</td>
            <td class="hidden-small">41</td>
            <td class="column-points">42</td>
        </tr>
        <tr class="odd">
            <td class="column-icon"><span class="icon-arrow-up-right"></span></td>
            <td class="column-rank">
                4.
            </td>
            <td class="column-club">
                <a href="https://www.fussball.de/mannschaft/u14-2-des-sc-west-koeln-sc-west-koeln-1900-11-ev-mittelrhein/-/saison/2122/team-id/02EPOJUCJC000000VS5489B1VT0RKM5V" class="club-wrapper">
                    <div class="club-logo table-image">
                        <img src="//www.fussball.de/export.media/-/action/getLogo/format/3/id/00ES8GN914000053VV0AG08LVUPGND5I/verband/0123456789ABCDEF0123456700004120" alt="West Köln U14 II">
                    </div>
                    <div class="club-name">
                        West Köln U14 II
                    </div>
                </a>
            </td>
            <td>18</td>
            <td class="hidden-small">11</td>
            <td class="hidden-small">3</td>
            <td class="hidden-small">4</td>
            <td class="no-wrap">54 : 28</td>
            <td class="hidden-small">26</td>
            <td class="column-points">36</td>
        </tr>
        <tr>
            <td class="column-icon"><span class="icon-arrow-down-right"></span></td>
            <td class="column-rank">
                5.
            </td>
            <td class="column-club">
                <a href="https://www.fussball.de/mannschaft/eintracht-koeln-u14-fc-eintracht-koeln-51-05-ev-mittelrhein/-/saison/2122/team-id/02F0QD1484000000VS5489B2VUBVHUE0" class="club-wrapper">
                    <div class="club-logo table-image">
                        <img src="//www.fussball.de/export.media/-/action/getLogo/format/3/id/00ES8GN914000029VV0AG08LVUPGND5I/verband/0123456789ABCDEF0123456700004120" alt="Eintracht Köln U14">
                    </div>
                    <div class="club-name">
                        Eintracht Köln U14
                    </div>
                </a>
            </td>
            <td>18</td>
            <td class="hidden-small">11</td>
            <td class="hidden-small">1</td>
            <td class="hidden-small">6</td>
            <td class="no-wrap">85 : 52</td>
            <td class="hidden-small">33</td>
            <td class="column-points">34</td>
        </tr>
        <tr class="odd">
            <td class="column-icon"><span class="icon-arrow-right"></span></td>
            <td class="column-rank">
                6.
            </td>
            <td class="column-club">
                <a href="https://www.fussball.de/mannschaft/esv-olympia-koeln-u14-esv-olympia-koeln-ev-mittelrhein/-/saison/2122/team-id/01SKA5CLP4000000VS548984VT4EU5FS" class="club-wrapper">
                    <div class="club-logo table-image">
                        <img src="//www.fussball.de/export.media/-/action/getLogo/format/3/id/00ES8GN914000041VV0AG08LVUPGND5I/verband/0123456789ABCDEF0123456700004120" alt="Olympia U14">
                    </div>
                    <div class="club-name">
                        Olympia U14
                    </div>
                </a>
            </td>
            <td>18</td>
            <td class="hidden-small">9</td>
            <td class="hidden-small">1</td>
            <td class="hidden-small">8</td>
            <td class="no-wrap">56 : 34</td>
            <td class="hidden-small">22</td>
            <td class="column-points">28</td>
        </tr>
        <tr>
            <td class="column-icon"><span class="icon-arrow-right"></span></td>
            <td class="column-rank">
                7.
            </td>
            <td class="column-club">
                <a href="https://www.fussball.de/mannschaft/sv-deutz-05-u14-iii-sportvereinigung-deutz-05-ev-mittelrhein/-/saison/2122/team-id/02B8LU69KO000000VS5489B2VSCHU9TQ" class="club-wrapper">
                    <div class="club-logo table-image">
                        <img src="//www.fussball.de/export.media/-/action/getLogo/format/3/id/00ES8GN914000021VV0AG08LVUPGND5I/verband/0123456789ABCDEF0123456700004120" alt="Deutz 05 U14 III">
                    </div>
                    <div class="club-name">
                        Deutz 05 U14 III
                    </div>
                </a>
            </td>
            <td>18</td>
            <td class="hidden-small">9</td>
            <td class="hidden-small">1</td>
            <td class="hidden-small">8</td>
            <td class="no-wrap">57 : 53</td>
            <td class="hidden-small">4</td>
            <td class="column-points">28</td>
        </tr>
        <tr class="odd">
            <td class="column-icon"><span class="icon-arrow-up-right"></span></td>
            <td class="column-rank">
                8.
            </td>
            <td class="column-club">
                <a href="https://www.fussball.de/mannschaft/rath-heumar-u14-rsv-rath-heumar-1920-ev-mittelrhein/-/saison/2122/team-id/02F12DDAB4000000VS5489B2VUBVHUE0" class="club-wrapper">
                    <div class="club-logo table-image">
                        <img src="//www.fussball.de/export.media/-/action/getLogo/format/3/id/00ES8GN91400004FVV0AG08LVUPGND5I/verband/0123456789ABCDEF0123456700004120" alt="Rath-Heumar U14">
                    </div>
                    <div class="club-name">
                        Rath-Heumar U14
                    </div>
                </a>
            </td>
            <td>19</td>
            <td class="hidden-small">4</td>
            <td class="hidden-small">1</td>
            <td class="hidden-small">14</td>
            <td class="no-wrap">35 : 86</td>
            <td class="hidden-small">-51</td>
            <td class="column-points">13</td>
        </tr>
        <tr class="row-relegation">
            <td class="column-icon"><span class="icon-arrow-down-right"></span></td>
            <td class="column-rank">
                9.
            </td>
            <td class="column-club">
                <a href="https://www.fussball.de/mannschaft/spvg-arminia-09-u14-spvg-arminia-09-koeln-ev-mittelrhein/-/saison/2122/team-id/02EUHDDHB8000000VS5489B1VT0RKM5V" class="club-wrapper">
                    <div class="club-logo table-image">
                        <img src="//www.fussball.de/export.media/-/action/getLogo/format/3/id/00ES8GN91400001MVV0AG08LVUPGND5I/verband/0123456789ABCDEF0123456700004120" alt="Arminia 09 U14">
                    </div>
                    <div class="club-name">
                        Arminia 09 U14
                    </div>
                </a>
            </td>
            <td>18</td>
            <td class="hidden-small">4</td>
            <td class="hidden-small">0</td>
            <td class="hidden-small">14</td>
            <td class="no-wrap">41 : 95</td>
            <td class="hidden-small">-54</td>
            <td class="column-points">12</td>
        </tr>
        <tr class="row-relegation odd">
            <td class="column-icon"><span class="icon-arrow-right"></span></td>
            <td class="column-rank">
                10.
            </td>
            <td class="column-club">
                <a href="https://www.fussball.de/mannschaft/roland-west-u14-djk-roland-koeln-west-ev-mittelrhein/-/saison/2122/team-id/011MIEE79C000000VTVG0001VTR8C1K7" class="club-wrapper">
                    <div class="club-logo table-image">
                        <img src="//www.fussball.de/export.media/-/action/getLogo/format/3/id/00ES8GN91400004MVV0AG08LVUPGND5I/verband/0123456789ABCDEF0123456700004120" alt="Roland West U14">
                    </div>
                    <div class="club-name">
                        Roland West U14
                    </div>
                </a>
            </td>
            <td>18</td>
            <td class="hidden-small">2</td>
            <td class="hidden-small">3</td>
            <td class="hidden-small">13</td>
            <td class="no-wrap">35 : 102</td>
            <td class="hidden-small">-67</td>
            <td class="column-points">9</td>
        </tr>
        <tr class="row-relegation own">
            <td class="column-icon"><span class="icon-arrow-right"></span></td>
            <td class="column-rank">
                11.
            </td>
            <td class="column-club">
                <a href="https://www.fussball.de/mannschaft/sv-fuehlingen-u14-sv-fuehlingen-chorweiler-e-v-mittelrhein/-/saison/2122/team-id/011MIAD9JG000000VTVG0001VTR8C1K7" class="club-wrapper">
                    <div class="club-logo table-image">
                        <img src="//www.fussball.de/export.media/-/action/getLogo/format/3/id/00ES8GN91400002IVV0AG08LVUPGND5I/verband/0123456789ABCDEF0123456700004120" alt="Fühlingen U14">
                    </div>
                    <div class="club-name">
                        Fühlingen U14
                    </div>
                </a>
            </td>
            <td>18</td>
            <td class="hidden-small">1</td>
            <td class="hidden-small">1</td>
            <td class="hidden-small">16</td>
            <td class="no-wrap">12 : 113</td>
            <td class="hidden-small">-101</td>
            <td class="column-points">4</td>
        </tr>
        </tbody>
    </table>
    <div data-toggle=".legend > span, .note > span" class="table-meta">
        <ul class="functions">
            <li class="legend"><span data-toggle-content=".table-legend">Legende<span class="icon-angle-down"></span></span></li>
            <li class="print">
                <a href="https://www.fussball.de/mannschaft.spieltag.druck/-/max/999/mode/PRINT/staffel/02ES6I5NO8000007VS5489B3VUK1A2F6-G/team-id/011MIAD9JG000000VTVG0001VTR8C1K7" target="_blank">Drucken<span class="icon-link-arrow"></span></a>
            </li>
        </ul>
        <div class="table-legend">
            <h3>Bereich "Kürzel bei der Mannschaft"</h3>
            <div class="row">
                <div class="wrapper">
                    <div class="column">
                        <div class="item"><span>oW</span></div>
                        <div class="description">Diese Mannschaft spielt in dieser Staffel nicht mehr mit, die Ergebnisse werden aber eingerechnet</div>
                    </div>
                    <div class="column">
                        <div class="item"><span>zg.</span></div>
                        <div class="description">Diese Mannschaft wurde zurückgezogen, die Ergebnisse werden aber eingerechnet</div>
                    </div>
                    <div class="column">
                        <div class="item"><span>SW</span></div>
                        <div class="description">Für diese Mannschaft ist eine separate Sonderwertung eingerechnet</div>
                    </div>
                </div>
            </div>
            <h3>Bereich Trend</h3>
            <div class="row">
                <div class="wrapper">
                    <div class="column">
                        <div class="item"><span class="icon-arrow-up-right"></span></div>
                        <div class="description">Tabellenplatz hat sich im Vergleich zum vorherigen Spieltag verbessert</div>
                    </div>
                    <div class="column">
                        <div class="item"><span class="icon-arrow-right"></span></div>
                        <div class="description">Tabellenplatz bleibt im Vergleich zum vorherigen Spieltag unverändert</div>
                    </div>
                    <div class="column">
                        <div class="item"><span class="icon-arrow-down-right"></span></div>
                        <div class="description">Tabellenplatz hat sich im Vergleich zum vorherigen Spieltag verschlechtert</div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
''';

    TableResult tableResult = TableResult();

    List<TeamTableTransfer> table = tableResult.parseHTML(htmlString);

    TeamTableTransfer team = table[0];
    expect(team.team, equals('Nippes 78 U14'));
    expect(team.img, equals('https://www.fussball.de/export.media/-/action/getLogo/format/3/id/00ES8GN91400003TVV0AG08LVUPGND5I/verband/0123456789ABCDEF0123456700004120'));
    expect(team.place, equals(1));
    expect(team.games, equals(18));
    expect(team.won, equals(14));
    expect(team.draw, equals(2));
    expect(team.lost, equals(2));
    expect(team.goal, equals('93 : 18'));
    expect(team.goalDifference, equals(75));
    expect(team.points, equals(44));
    expect(team.isPromotion, isTrue);
    expect(team.isRelegation, isFalse);

    team = table[7];
    expect(team.team, equals('Rath-Heumar U14'));
    expect(team.img, equals('https://www.fussball.de/export.media/-/action/getLogo/format/3/id/00ES8GN91400004FVV0AG08LVUPGND5I/verband/0123456789ABCDEF0123456700004120'));
    expect(team.place, equals(8));
    expect(team.games, equals(19));
    expect(team.won, equals(4));
    expect(team.draw, equals(1));
    expect(team.lost, equals(14));
    expect(team.goal, equals('35 : 86'));
    expect(team.goalDifference, equals(-51));
    expect(team.points, equals(13));
    expect(team.isPromotion, isFalse);
    expect(team.isRelegation, isFalse);

    team = table[10];
    expect(team.team, equals('Fühlingen U14'));
    expect(team.img, equals('https://www.fussball.de/export.media/-/action/getLogo/format/3/id/00ES8GN91400002IVV0AG08LVUPGND5I/verband/0123456789ABCDEF0123456700004120'));
    expect(team.place, equals(11));
    expect(team.games, equals(18));
    expect(team.won, equals(1));
    expect(team.draw, equals(1));
    expect(team.lost, equals(16));
    expect(team.goal, equals('12 : 113'));
    expect(team.goalDifference, equals(-101));
    expect(team.points, equals(4));
    expect(team.isPromotion, isFalse);
    expect(team.isRelegation, isTrue);
  });

  group('TeamTableTransfer', () {
      test('toJson', () {
          var teamTableTransfer = TeamTableTransfer()
              ..place = 1
              ..team = 'TeamName'
              ..img = 'imageURL'
              ..games = 10
              ..won = 5
              ..draw = 3
              ..lost = 2
              ..goal = '15:10'
              ..goalDifference = 5
              ..points = 18
              ..isRelegation = false
              ..isPromotion = true;

          var expectedJson = {
              'place': 1,
              'team': 'TeamName',
              'img': 'imageURL',
              'games': 10,
              'won': 5,
              'draw': 3,
              'lost': 2,
              'goal': '15:10',
              'goalDifference': 5,
              'points': 18,
              'isRelegation': false,
              'isPromotion': true,
          };

          expect(teamTableTransfer.toJson(), expectedJson);
      });
  });
}
