import 'package:http/http.dart' as http;


abstract interface class HttpClientBridgeInterface {
  Future<String> fetchData(String url);
}

class HttpClientBridge implements HttpClientBridgeInterface {
  @override
  Future<String> fetchData(String url) async {
    var response = await http.get(Uri.parse('https://fussball.de$url'));

    if (response.body != '') {
      return response.body;
    }

    throw Exception('Error on URL: https://fussball.de$url');
  }
}
