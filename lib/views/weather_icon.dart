import 'package:flutter/material.dart';
import 'package:weather/weather.dart';

class WeatherIcon extends StatelessWidget {

  final Weather? weather;
  const WeatherIcon({super.key, this.weather});

  @override
  Widget build(BuildContext context) {

    String weatherIcon = "http://openweathermap.org/img/wn/${weather?.weatherIcon}@4x.png";

    return Row(
      // mainAxisSize: MainAxisSize.max,
      children: [
        Image.network(
          weatherIcon,
          height: 70,
          width: 70,
        ),
        Text(
          "${weather?.temperature?.celsius?.toStringAsFixed(0)}°C",
          style: const TextStyle(
              color: Colors.black,
              fontSize: 50,
              fontWeight: FontWeight.w400
          ),
        )

      ],
    );
  }
}