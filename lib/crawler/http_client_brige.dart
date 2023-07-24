import 'package:http/http.dart' as http;


abstract interface class HttpClientBrigeInterface {
  Future<String> fetchData(String url);
}

class HttpClientBrige implements HttpClientBrigeInterface {
  @override
  Future<String> fetchData(String url) async {
    var response = await http.get(Uri.parse('https://fussball.de${url}'));

    if (response.body != '') {
      return response.body;
    }

    throw Exception('Error on URL: https://fussball.de${url}');
  }
}
