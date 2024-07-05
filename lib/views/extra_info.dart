import 'package:flutter/material.dart';
import 'package:string_capitalize/string_capitalize.dart';
import 'package:weather/weather.dart';

class ExtraInfo extends StatelessWidget {
  final Weather? weather;

  const ExtraInfo({super.key, this.weather});

  @override
  Widget build(BuildContext context) {
    String? feelsLike = weather?.tempFeelsLike?.celsius?.toStringAsFixed(0);
    String? description = weather?.weatherDescription?.capitalize();

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text(
          "Ressentie $feelsLike°C. $description.",
          style: const TextStyle(
              color: Colors.white, fontWeight: FontWeight.w600, fontSize: 18),
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Max: ${weather?.tempMax?.celsius?.toStringAsFixed(0)}°C",
              style: const TextStyle(fontSize: 15, color: Colors.white),
            ),
            Text(
              "Min: ${weather?.tempMin?.celsius?.toStringAsFixed(0)}°C",
              style: const TextStyle(fontSize: 15, color: Colors.white),
            )
          ],
        ),
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Vent: ${weather?.windSpeed?.toStringAsFixed(0)}m/s",
              style: const TextStyle(fontSize: 15, color: Colors.white),
            ),
            Text(
              "Humidité: ${weather?.humidity?.toStringAsFixed(0)}%",
              style: const TextStyle(fontSize: 15, color: Colors.white),
            )
          ],
        )
      ],
    );
  }
}
