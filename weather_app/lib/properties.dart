import 'package:flutter/material.dart';
import 'package:weather_app/model/weather.dart';
import 'package:google_fonts/google_fonts.dart';

class Properties extends StatelessWidget {
  const Properties({super.key, required this.givenWeather});
  final Weather givenWeather;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            categoryIcons[givenWeather.sky]!,
            width: 120,
            height: 120,
            fit: BoxFit.contain,
            color: const Color.fromARGB(250, 255, 255, 255),
          ),
          SizedBox(height: 6),
          Text(
            '${givenWeather.temp.toString()} °C',
            style: GoogleFonts.lato(
              color: const Color.fromARGB(244, 255, 255, 255),
              fontSize: 60,
              fontWeight: FontWeight.w300,
            ),
          ),
          SizedBox(height: 6),
          Text(
            givenWeather.city,
            style: GoogleFonts.lato(
              color: const Color.fromARGB(244, 255, 255, 255),
              fontSize: 30,
              fontWeight: FontWeight.w300,
            ),
          ),
          SizedBox(height: 60),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  Row(
                    children: [
                      Image.asset(
                        'assets/images/humidity.png',
                        width: 30,
                        color: const Color.fromARGB(250, 255, 255, 255),
                      ),
                      const SizedBox(width: 7),
                      Text(
                        '${givenWeather.humidity.toString()} %',
                        style: GoogleFonts.lato(
                          color: const Color.fromARGB(244, 255, 255, 255),
                          fontSize: 25,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Text(
                    'Humidity',
                    style: GoogleFonts.lato(
                      color: const Color.fromARGB(244, 255, 255, 255),
                      fontSize: 20,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 30),
              Column(
                children: [
                  Row(
                    children: [
                      Image.asset(
                        'assets/images/wind_speed.png',
                        width: 30,
                        color: const Color.fromARGB(250, 255, 255, 255),
                      ),
                      const SizedBox(width: 7),
                      Text(
                        '${givenWeather.windSpeed.toString()} km/h',
                        style: GoogleFonts.lato(
                          color: const Color.fromARGB(244, 255, 255, 255),
                          fontSize: 25,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Text(
                    'Wind Speed',
                    style: GoogleFonts.lato(
                      color: const Color.fromARGB(244, 255, 255, 255),
                      fontSize: 20,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
