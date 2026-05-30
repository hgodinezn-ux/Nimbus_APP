import 'dart:convert';
import 'package:http/http.dart' as http;

class ForecastService {
  final String apiKey = 'f399229fb8970ff99d876b4b7ebbb365';

  Future<List<dynamic>> getForecast(String city) async {
    final url =
        'https://api.openweathermap.org/data/2.5/forecast?q=$city&appid=$apiKey&units=metric&lang=es';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      return data['list'];
    } else {
      throw Exception('Error al obtener pronóstico');
    }
  }
}
