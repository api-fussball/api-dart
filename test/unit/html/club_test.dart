import 'package:api_fussball_dart/dto/club_team_info_transfer.dart';
import 'package:api_fussball_dart/html/club.dart';
import 'package:test/test.dart';

void main() {
  test('parse club info', () async {
    final String htmlString = '''
<div data-ng-controller="AjaxController" class="tab-content">
	<div class="filter">
		<form data-ajax-type="html" data-ajax-target="#clubTeams .tab-content" data-ajax-resource="https://www.fussball.de/ajax.club.teams/-/action/search/id/00ES8GN91400002IVV0AG08LVUPGND5I" data-ajax="replace" data-tracking="{'href':'https://www.fussball.de/ajax.club.teams/-/action/search/id/00ES8GN91400002IVV0AG08LVUPGND5I'}">
			<div data-ng-model="filterSeasons" data-ng-init="filterSeasons='23/24'" data-select-box="single" data-select-box-default="0" data-select-title="Saison" class="select-wrapper" data-ajaxmodel="saison">
				<select size="1" name="saison">
					<option value="2324" selected="selected">2023/2024</option>
					<option value="2223">2022/2023</option>
					<option value="2122">2021/2022</option>
					<option value="2021">2020/2021</option>
					<option value="1920">2019/2020</option>
					<option value="1819">2018/2019</option>
					<option value="1718">2017/2018</option>
					<option value="1617">2016/2017</option>
					<option value="1516">2015/2016</option>
					<option value="1415">2014/2015</option>
					<option value="1314">2013/2014</option>
					<option value="1213">2012/2013</option>
					<option value="1112">2011/2012</option>
					<option value="1011">2010/2011</option>
					<option value="0910">2009/2010</option>
					<option value="0809">2008/2009</option>
					<option value="0708">2007/2008</option>
					<option value="0607">2006/2007</option>
					<option value="0506">2005/2006</option>
					<option value="0405">2004/2005</option>
					<option value="0304">2003/2004</option>
					<option value="0203">2002/2003</option>
					<option value="0102">2001/2002</option>
					<option value="0001">2000/2001</option>
				</select>
			</div>
			<div data-ng-model="filterTeamTypes" data-select-box="single" data-select-box-default="0" data-select-title="Mannschaften" class="select-wrapper" data-ajaxmodel="mannschaftsart">
				<select size="1" name="mannschaftsart">
					<option value="-1" selected="selected">Alle</option>
					<option value="95">Herren</option>
					<option value="96">A-Junioren</option>
					<option value="97">B-Junioren</option>
					<option value="98">C-Junioren</option>
					<option value="99">D-Junioren</option>
					<option value="100">E-Junioren</option>
				</select>
			</div>
			<div data-ng-model="filterCompetitions" data-select-box="single" data-select-box-default="0" data-select-title="Wettbewerbe" class="select-wrapper" data-ajaxmodel="wettkampftyp">
				<select size="1" name="wettkampftyp">
					<option value="-1" selected="selected">Alle</option>
					<option value="1">Meisterschaften</option>
					<option value="8">Pokale</option>
					<option value="3">Turniere</option>
					<option value="7">Freundschaftsspiele</option>
				</select>
			</div>
			<button type="submit" class="button-primary button">Los</button>
		</form>
	</div>
	<div class="result">
		<div class="items">
			<div class="item">
				<h4>
					<a href="https://www.fussball.de/mannschaft/sv-fuehlingen-i-sv-fuehlingen-chorweiler-e-v-mittelrhein/-/saison/2324/team-id/011MIC9NDS000000VTVG0001VTR8C1K7">
						Herren - Fühlingen I
						<span class="icon-link-arrow"></span>
						<span class="icon-angle-right"></span>
					</a>
				</h4>
				<p>
					<a href="https://www.fussball.de/spieltagsuebersicht/kreisliga-c-staffel-2-kreis-koeln-kreisliga-c-herren-saison2324-mittelrhein/-/staffel/02M1O9Q6P000000HVS5489B4VUAB0UC4-G">Kreisliga C Staffel 2</a>
					 | 
					<a href="https://www.fussball.de/spieltagsuebersicht/bitburger-kreispokal-2023-2024-kreis-koeln-kreispokal-herren-saison2324-mittelrhein/-/staffel/02M1O3VA8G000000VS5489B4VUAB0UC4-C">Bitburger Kreispokal 2023/2024</a>
					 | 
					Freundschaftsspiele
				</p>
			</div>
			<div class="item">
				<h4>
					<a href="https://www.fussball.de/mannschaft/sv-fuehlingen-ii-sv-fuehlingen-chorweiler-e-v-mittelrhein/-/saison/2324/team-id/01L64SKETK000000VV0AG80NVTB5JGKG">
						Herren - Fühlingen II
						<span class="icon-link-arrow"></span>
						<span class="icon-angle-right"></span>
					</a>
				</h4>
				<p>
					<a href="https://www.fussball.de/spieltagsuebersicht/kreisliga-d-staffel-1-kreis-koeln-kreisliga-d-herren-saison2324-mittelrhein/-/staffel/02M1O9RV7S00000DVS5489B4VUAB0UC4-G">Kreisliga D Staffel 1</a>
					 | 
					Freundschaftsspiele
				</p>
			</div>
			<div class="item">
				<h4>
					<a href="https://www.fussball.de/mannschaft/sv-fuehlingen-l-sv-fuehlingen-chorweiler-e-v-mittelrhein/-/saison/2324/team-id/01HHJCM674000000VV0AG80NVT6JKAPB">
						A-Junioren - Fühlingen
						<span class="icon-link-arrow"></span>
						<span class="icon-angle-right"></span>
					</a>
				</h4>
				<p>
					<a href="https://www.fussball.de/spieltagsuebersicht/a-junioren-leistungsklasse-kreis-koeln-a-junioren-leistungsklasse-a-junioren-saison2324-mittelrhein/-/staffel/02MC11QQBO000000VS5489B4VSKDJ19I-G">A-Junioren Leistungsklasse</a>
					 | 
					<a href="https://www.fussball.de/spieltagsuebersicht/josef-volmar-wanderpokal-kreis-koeln-a-junioren-kreispokal-a-junioren-saison2324-mittelrhein/-/staffel/02MCL814VC000000VS5489B3VS8P6BMU-C">Josef Volmar Wanderpokal</a>
					 | 
					Freundschaftsspiele
				</p>
			</div>
			<div class="item">
				<h4>
					<a href="https://www.fussball.de/mannschaft/sv-fuehlinge-l-sv-fuehlingen-chorweiler-e-v-mittelrhein/-/saison/2324/team-id/01SHOG6L9G000000VS548984VVMI9KVG">
						B-Junioren - Fühlingen
						<span class="icon-link-arrow"></span>
						<span class="icon-angle-right"></span>
					</a>
				</h4>
				<p>
					<a href="https://www.fussball.de/spieltagsuebersicht/b-junioren-kreisklasse-1-kreis-koeln-b-junioren-kreisklasse-b-junioren-saison2324-mittelrhein/-/staffel/02MG9E930K000006VS5489B4VTIF1KGH-G">B-Junioren Kreisklasse 1</a>
					 | 
					<a href="https://www.fussball.de/spieltagsuebersicht/karl-peter-kropmanns-wanderpokal-kreis-koeln-b-junioren-kreispokal-b-junioren-saison2324-mittelrhein/-/staffel/02MCLHLK0O000000VS5489B3VS8P6BMU-C">Karl-Peter Kropmanns Wanderpokal</a>
				</p>
			</div>
			<div class="item">
				<h4>
					<a href="https://www.fussball.de/mannschaft/sv-fuehlingen-u14-sv-fuehlingen-chorweiler-e-v-mittelrhein/-/saison/2324/team-id/011MIAD9JG000000VTVG0001VTR8C1K7">
						C-Junioren - Fühlingen U14
						<span class="icon-link-arrow"></span>
						<span class="icon-angle-right"></span>
					</a>
				</h4>
				<p>
					<a href="https://www.fussball.de/spieltagsuebersicht/u14-junioren-kreisklasse-1-kreis-koeln-c-junioren-kreisklasse-c-junioren-saison2324-mittelrhein/-/staffel/02MG9E1ND8000004VS5489B4VTIF1KGH-G">U14-Junioren Kreisklasse 1</a>
					 | 
					<a href="https://www.fussball.de/spieltagsuebersicht/kurt-isemann-wanderpokal-kreis-koeln-c-junioren-kreispokal-c-junioren-saison2324-mittelrhein/-/staffel/02MCVOCR1S000000VS5489B4VSKDJ19I-C">Kurt Isemann Wanderpokal</a>
					 | 
					Freundschaftsspiele
				</p>
			</div>
			<div class="item">
				<h4>
					<a href="https://www.fussball.de/mannschaft/sv-fuehlingen-u-12-l-sv-fuehlingen-chorweiler-e-v-mittelrhein/-/saison/2324/team-id/011MICT0UG000000VTVG0001VTR8C1K7">
						D-Junioren - Fühlingen U12
						<span class="icon-link-arrow"></span>
						<span class="icon-angle-right"></span>
					</a>
				</h4>
				<p>
					<a href="https://www.fussball.de/spieltagsuebersicht/u12-junioren-kreisklasse-5-kreis-koeln-d-junioren-kreisklasse-d-junioren-saison2324-mittelrhein/-/staffel/02MG9CSLQC000000VS5489B4VTIF1KGH-G">U12-Junioren Kreisklasse 5</a>
					 | 
					<a href="https://www.fussball.de/spieltagsuebersicht/gerhard-wessely-wanderpokal-kreis-koeln-d-junioren-kreispokal-d-junioren-saison2324-mittelrhein/-/staffel/02MCVSGOMK000000VS5489B4VSKDJ19I-C">Gerhard Wessely Wanderpokal</a>
					 | 
					Freundschaftsspiele
				</p>
			</div>
			<div class="item">
				<h4>
					<a href="https://www.fussball.de/mannschaft/sv-fuehlingen-u-12-l-2-sv-fuehlingen-chorweiler-e-v-mittelrhein/-/saison/2324/team-id/02M6HN87EK000000VS5489B1VT732LUQ">
						D-Junioren - Fühlingen U12 II
						<span class="icon-link-arrow"></span>
						<span class="icon-angle-right"></span>
					</a>
				</h4>
				<p>
					<a href="https://www.fussball.de/spieltagsuebersicht/u12-junioren-kreisklasse-6-kreis-koeln-d-junioren-kreisklasse-d-junioren-saison2324-mittelrhein/-/staffel/02MG9CVNJ4000004VS5489B4VTIF1KGH-G">U12-Junioren Kreisklasse 6</a>
					 | 
					Freundschaftsspiele
				</p>
			</div>
			<div class="item">
				<h4>
					<a href="https://www.fussball.de/mannschaft/fuehlingen-u11-l-sv-fuehlingen-chorweiler-e-v-mittelrhein/-/saison/2324/team-id/011MIDAJT8000000VTVG0001VTR8C1K7">
						E-Junioren - Fühlingen U11
						<span class="icon-link-arrow"></span>
						<span class="icon-angle-right"></span>
					</a>
				</h4>
				<p>
					<a href="https://www.fussball.de/spieltagsuebersicht/u11-kreisklasse-7-kreis-koeln-e-junioren-kreisklasse-e-junioren-saison2324-mittelrhein/-/staffel/02MGHRR4HO000005VS5489B4VTIF1KGH-G">U11 Kreisklasse 7</a>
					 | 
					<a href="https://www.fussball.de/spieltagsuebersicht/vingst-cup-2023-kreis-koeln-e-junioren-vereinsturnier-e-junioren-saison2324-mittelrhein/-/staffel/02MDILBMMK000000VS5489B4VSKDJ19I-C">Vingst Cup 2023</a>
					 | 
					Freundschaftsspiele
				</p>
			</div>
		</div>
	</div>
</div>
    ''';

    Club club = Club();
    List<ClubTeamInfoTransfer> ClubTeamInfoTransferList =
        club.parseHTML(htmlString);

    expect(ClubTeamInfoTransferList.length, 8);

    expect(ClubTeamInfoTransferList[0].id, '011MIC9NDS000000VTVG0001VTR8C1K7');
    expect(ClubTeamInfoTransferList[0].name, 'Herren - Fühlingen I');
    expect(ClubTeamInfoTransferList[0].fussballDeUrl,
        '/mannschaft/sv-fuehlingen-i-sv-fuehlingen-chorweiler-e-v-mittelrhein/-/saison/2324/team-id/011MIC9NDS000000VTVG0001VTR8C1K7');

    expect(ClubTeamInfoTransferList[3].name, 'B-Junioren - Fühlingen');

    expect(ClubTeamInfoTransferList[7].id, '011MIDAJT8000000VTVG0001VTR8C1K7');
  });
}
