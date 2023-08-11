
class ClubTeamInfoTransfer {

  String fussballDeUrl = '';
  String id = '';
  String name = '';

  Map<String, dynamic> toJson() {
    return {
      'fussballDeUrl': fussballDeUrl,
      'id': id,
      'name': name
    };
  }
}

