import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String _baseUrl =
      'https://api.openweathermap.org/data/2.5/forecast';
  static const _apiKey = 'cd676cc3e8e479dbd213b32bf6b1ab9b';

  Future<List<dynamic>?> fetchWeather(String city) async {
    final url = Uri.parse('$_baseUrl?q=$city&appid=$_apiKey&units=metric');

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return data['list'];
      } else {
        print('Failed to load forecast: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error fetching forecast : $e');
      return null;
    }
  }
}
