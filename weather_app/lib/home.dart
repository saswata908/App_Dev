import 'package:flutter/material.dart';
import 'package:weather_app/model/weather.dart';
import 'package:weather_app/properties.dart';
import 'package:weather_app/weather_service.dart';
import 'package:geolocator/geolocator.dart';

class Home extends StatefulWidget {
  const Home({super.key});
  @override
  State<Home> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<Home> {
  final _searchController = TextEditingController();

  Weather _chosenWeather = Weather(
    temp: 29,
    city: 'Delhi',
    humidity: 89,
    windSpeed: 5,
    sky: Category.clearNight,
  );

  final WeatherService _weatherService = WeatherService();

  void _searchCity(String cityName) async {
    try {
      Weather weather = await _weatherService.fetchWeather(cityName);
      setState(() {
        _chosenWeather = weather;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('City Not Found')), // TEMP for debugging
      );
    }
  }

  Future<Position> determinePosition() async {
    LocationPermission permission;

    // Check if location services are enabled
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw Exception('Location services are disabled.');
    }

    // Check permission
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw Exception('Location permission denied.');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      throw Exception('Location permission permanently denied.');
    }

    // Return current position
    return await Geolocator.getCurrentPosition();
  }

  void _loadCurrentLocationWeather() async {
    try {
      final position = await determinePosition();
      final weather = await _weatherService.fetchWeatherByLocation(
        position.latitude,
        position.longitude,
      );
      setState(() {
        _chosenWeather = weather;
      });
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Location error: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.teal, Colors.deepPurple],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Column(
            children: [
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 30,
                    horizontal: 25,
                  ),
                  child: TextField(
                    controller: _searchController,
                    onSubmitted: _searchCity,
                    decoration: InputDecoration(
                      hintText: "Search City",
                      prefixIcon: Icon(Icons.search),
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: EdgeInsets.symmetric(vertical: 0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ),
              SizedBox(height: 90),
              Properties(givenWeather: _chosenWeather),
              SizedBox(height: 80),
              ElevatedButton.icon(
                onPressed: _loadCurrentLocationWeather,
                icon: Icon(Icons.my_location),
                label: Text('Use Current Location'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black,
                  shape: StadiumBorder(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
