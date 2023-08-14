class ResponseErrorDto {
  final bool success = false;
  final String message;

  ResponseErrorDto(this.message);

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'data': [],
      'message': message,
    };
  }
}

class ResponseInfoSuccessDto {
  bool success = true;
  final List<dynamic> clubs;
  final List<dynamic> prevGames;
  final List<dynamic> nextGames;

  ResponseInfoSuccessDto(this.clubs, this.prevGames, this.nextGames);

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'data': {
        'clubs': clubs,
        'prevGames': prevGames,
        'nextGames': nextGames,
      },
    };
  }
}


class ResponseTeamInfoSuccessDto {
  bool success = true;
  final List<dynamic> table;
  final List<dynamic> prevGames;
  final List<dynamic> nextGames;

  ResponseTeamInfoSuccessDto(this.table, this.prevGames, this.nextGames);

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'data': {
        'table': table,
        'prevGames': prevGames,
        'nextGames': nextGames,
      },
    };
  }
}

class ResponseSuccessDto {
  bool success = true;
  final List<dynamic> data;

  ResponseSuccessDto(this.data);

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'data': data,
    };
  }
}
