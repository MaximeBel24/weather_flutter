import 'package:flutter/material.dart';
import 'package:weather/weather.dart';

class WeatherIcon extends StatelessWidget {
  final Weather? weather;

  const WeatherIcon({super.key, this.weather});

  @override
  Widget build(BuildContext context) {
    String weatherIcon =
        "http://openweathermap.org/img/wn/${weather?.weatherIcon}@4x.png";

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        Image.network(weatherIcon, width: 120, height: 120),
        const SizedBox(
          width: 30,
        ),
        Text(
          "${weather?.temperature?.celsius?.toStringAsFixed(0)}°C",
          style: const TextStyle(
              color: Colors.white, fontSize: 50, fontWeight: FontWeight.w400),
        )
      ],
    );
  }
}
