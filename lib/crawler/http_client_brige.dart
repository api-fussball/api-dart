import 'package:http/http.dart' as http;


abstract interface class HttpClientBrigeInterface {
  Future<String> fetchData(String url);
}

class HttpClientBrige implements HttpClientBrigeInterface {
  @override
  Future<String> fetchData(String url) async {
    var response = await http.get(Uri.parse('https://fussball.de${url}'));

    if (response.statusCode == 200) {
      return response.body;
    }

    throw Exception('Error on URL: ${response.statusCode}');
  }
}
