import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiClient {
  final String baseUrl;
  final String apiKey;

  ApiClient({
    required this.baseUrl,
    required this.apiKey,
  });

  Future<Map<String, dynamic>> fetchInstrumentData(
      String symbol, String apiFunction) async {
    final url = Uri.parse(
        '$baseUrl?function=$apiFunction&symbol=$symbol&apikey=$apiKey');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
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
