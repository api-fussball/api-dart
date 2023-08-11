
class ClubTeamInfoTransfer {

  String fussballDeUrl = '';
  String id = '';
  String name = '';

  Map<String, dynamic> toJson() {
    return {
      'fussballDeUrl': fussballDeUrl,
      'id': id,
      'name': name,
      'url': {
        'nextGames': '/api/team/next_games/$id',
        'prevGames': '/api/team/prev_games/$id',
        'table': '/api/team/table/$id',
        'allInfo': '/api/team/$id'
      }
    };
  }
}

