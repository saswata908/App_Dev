import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

enum Category {
  clearDay,
  clearNight,
  cloudy,
  partlyCloudyDay,
  partlyCloudyNight,
  rainy,
  stormy,
}

const categoryIcons = {
  Category.clearDay: 'assets/images/clear_day.png',
  Category.clearNight: 'assets/images/clear_night.png',
  Category.cloudy: 'assets/images/cloudy.png',
  Category.partlyCloudyDay: 'assets/images/partly_cloudy_day.png',
  Category.partlyCloudyNight: 'assets/images/partly_cloudy_night.png',
  Category.rainy: 'assets/images/rainy.png',
  Category.stormy: 'assets/images/stormy.png',
};

class Weather {
  Weather({
    required this.temp,
    required this.city,
    required this.humidity,
    required this.windSpeed,
    required this.sky,
  });

  final double temp;
  final String city;
  final double humidity;
  final double windSpeed;
  final Category sky;
}
