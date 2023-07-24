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
