import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:weather_app/model/weather.dart';

class WeatherService {
  final String _apiKey =
      'e0afe3884f4946cdb76143037252805'; // replace with your WeatherAPI.com key

  Future<Weather> fetchWeather(String cityName) async {
    final url = Uri.parse(
      'https://api.weatherapi.com/v1/current.json?key=$_apiKey&q=$cityName',
    );

    final response = await http.get(url);
    print('STATUS: ${response.statusCode}');
    print('RESPONSE: ${response.body}');

    try {
      final data = json.decode(response.body);

      return Weather(
        temp: (data['current']['temp_c'] as num).toDouble(),
        city: data['location']['name'],
        humidity: (data['current']['humidity'] as num).toDouble(),
        windSpeed: (data['current']['wind_kph'] as num).toDouble(),
        sky: _mapSky(
          data['current']['condition']['text'],
          data['current']['is_day'],
        ),
      );
    } catch (e, stack) {
      print('❌ ERROR while parsing weather: $e\n$stack');
      rethrow;
    }
  }

  Future<Weather> fetchWeatherByLocation(double lat, double lon) async {
    final url = Uri.parse(
      'https://api.weatherapi.com/v1/current.json?key=$_apiKey&q=$lat,$lon',
    );

    final response = await http.get(url);
    print('STATUS: ${response.statusCode}');
    print('RESPONSE: ${response.body}');

    try {
      final data = json.decode(response.body);
      return Weather(
        temp: (data['current']['temp_c'] as num).toDouble(),
        city: data['location']['name'],
        humidity: (data['current']['humidity'] as num).toDouble(),
        windSpeed: (data['current']['wind_kph'] as num).toDouble(),
        sky: _mapSky(
          data['current']['condition']['text'],
          data['current']['is_day'],
        ),
      );
    } catch (e) {
      print('❌ ERROR while parsing weather: $e');
      rethrow;
    }
  }

  Category _mapSky(String description, int isDay) {
    final desc = description.toLowerCase();

    if (desc.contains('clear') || desc.contains('sunny')) {
      return isDay == 1 ? Category.clearDay : Category.clearNight;
    }

    if (desc.contains('partly cloudy')) {
      return isDay == 1 ? Category.partlyCloudyDay : Category.partlyCloudyNight;
    }

    if (desc.contains('cloud') || desc.contains('overcast')) {
      return Category.cloudy;
    }

    if (desc.contains('mist') ||
        desc.contains('fog') ||
        desc.contains('haze') ||
        desc.contains('smoke')) {
      return Category.cloudy;
    }

    if (desc.contains('rain') ||
        desc.contains('drizzle') ||
        desc.contains('shower')) {
      return Category.rainy;
    }

    if (desc.contains('thunder') || desc.contains('storm')) {
      return Category.stormy;
    }

    return isDay == 1 ? Category.clearDay : Category.clearNight;
  }
}
