class ClubMatchInfoTransfer {
  String homeScore = '';
  String homeLogo = '';
  String awayScore = '';
  String awayLogo = '';
  String time = '';
  String date = '';
  String homeTeam = '';
  String awayTeam = '';
  String ageGroup = '';
  String competition = '';
  String status = '';
  String address = '';

  Map<String, dynamic> toJson() {
    return {
      'homeScore': homeScore,
      'homeLogo': homeLogo,
      'awayScore': awayScore,
      'awayLogo': awayLogo,
      'time': time,
      'date': date,
      'homeTeam': homeTeam,
      'awayTeam': awayTeam,
      'ageGroup': ageGroup,
      'competition': competition,
      'status': status,
      'address': address,
    };
  }
}

