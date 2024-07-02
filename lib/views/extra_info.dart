import 'package:flutter/material.dart';
import 'package:string_capitalize/string_capitalize.dart';
import 'package:weather/weather.dart';

class ExtraInfo extends StatelessWidget{

  final Weather? weather;

  const ExtraInfo({super.key, this.weather});

  @override
  Widget build(BuildContext context) {

    String? feelsLike = weather?.tempFeelsLike?.celsius?.toStringAsFixed(0);
    String? description = weather?.weatherDescription?.capitalize();
    String? weatherMain = weather?.weatherMain?.capitalize();

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Feels like $feelsLike°C. $description. $weatherMain",
          style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w600,
              fontSize: 20
          ),
        ),
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Max: ${weather?.tempMax?.celsius?.toStringAsFixed(0)}°C",
              style: const TextStyle(
                  fontSize: 15
              ),
            ),
            Text(
              "Min: ${weather?.tempMin?.celsius?.toStringAsFixed(0)}°C",
              style: const TextStyle(
                  fontSize: 15
              ),
            )
          ],
        ),
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Wind: ${weather?.windSpeed?.toStringAsFixed(0)}m/s",
              style: const TextStyle(
                  fontSize: 15
              ),
            ),
            Text(
              "Humidity: ${weather?.humidity?.toStringAsFixed(0)}%",
              style: const TextStyle(
                  fontSize: 15
              ),
            )
          ],
        )
      ],
    );
  }
}