import 'dart:convert';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

class WeatherService {
  final String apiKey = '7b90b0eaa07b65a1ff1138de3bb4aa27';
  Future<Map<String, dynamic>> getWeather({required cityName}) async {
    final response = await http.get(
      Uri.parse(
        'http://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=$apiKey&units=metric',
      ),
    );
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<Map<String, dynamic>> fetchWeather({required cityName}) async {
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    double latitude = position.latitude;
    double longitude = position.longitude;
    final response = await http.get(
      Uri.parse(
        'http://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&appid=$apiKey&units=metric',
      ),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load data');
    }
  }
}
