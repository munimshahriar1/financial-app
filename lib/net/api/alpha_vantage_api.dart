import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiClient {
  final String baseUrl;
  final String apiKey;

  ApiClient({
    this.baseUrl = "https://www.alphavantage.co/query",
    required this.apiKey,
  });

  Future<Map<String, dynamic>> fetchInstrumentData(
      String symbol, String apiFunction) async {
    final url = Uri.parse(
        '$baseUrl?function=$apiFunction&symbol=$symbol&apikey=$apiKey');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      // If API limit crossed print it out
      if (data.containsKey('Note') &&
          data['Note'] ==
              "Thank you for using Alpha Vantage! Our standard API call frequency is 5 calls per minute and 500 calls per day. Please visit https://www.alphavantage.co/premium/ if you would like to target a higher API call frequency.") {
        print("API limit crossed");

        // Handle API limit crossed case
      }
      return data;
    } else {
      throw Exception(
          'API call failed with status code: ${response.statusCode}');
    }
  }

  Future<Map<String, dynamic>> fetchNewsData(
      String symbol) async {
    final url = Uri.parse(
        '$baseUrl?function=NEWS_SENTIMENT&tickers=$symbol&apikey=$apiKey');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data;
    } else {
      throw Exception(
          'API call failed with status code: ${response.statusCode}');
    }
  }
}
