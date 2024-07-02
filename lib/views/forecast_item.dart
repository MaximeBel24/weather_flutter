import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather/weather.dart';

class ForecastItem extends StatelessWidget {

  final Weather? forecast;

  const ForecastItem({super.key, this.forecast});

  @override
  Widget build(BuildContext context) {
    DateTime date = forecast!.date!;
    String day = DateFormat("EEE, MMM d").format(date);
    String iconUrl = "http://openweathermap.org/img/wn/${forecast?.weatherIcon}@2x.png";
    String tempMax = "${forecast?.tempMax?.celsius?.toStringAsFixed(0)}°";
    String tempMin = "${forecast?.tempMin?.celsius?.toStringAsFixed(0)}°";

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          day,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
        Row(
          children: [
            Image.network(
              iconUrl,
              width: 45,
              height: 45,
            ),
            Text(
              "$tempMax / $tempMin C",
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        )
      ],
    );
  }
}