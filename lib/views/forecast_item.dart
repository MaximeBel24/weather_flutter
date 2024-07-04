import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:string_capitalize/string_capitalize.dart';
import 'package:weather/weather.dart';

class ForecastItem extends StatelessWidget {
  final Weather? forecast;

  const ForecastItem({super.key, this.forecast});

  @override
  Widget build(BuildContext context) {
    DateTime date = forecast!.date!;
    String day =
        DateFormat.MMMMEEEEd('fr_FR').add_Hm().format(date).capitalize();
    String iconUrl =
        "http://openweathermap.org/img/wn/${forecast?.weatherIcon}@2x.png";
    String tempMax = "${forecast?.tempMax?.celsius?.toStringAsFixed(0)}°";
    String tempMin = "${forecast?.tempMin?.celsius?.toStringAsFixed(0)}°";
    String? description = forecast?.weatherDescription?.capitalize();

    return Card(
      elevation: 4,
      color: Colors.transparent,
      shadowColor: Colors.black54,
      child: Container(
        width: 180,
        height: 200,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          // color: Colors.teal.shade100,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              day,
              textAlign: TextAlign.center,
              style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w500,
                  color: Colors.white),
            ),
            Image.network(
              iconUrl,
              width: 100,
              height: 100,
            ),
            Text(
              description!,
              style: const TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontStyle: FontStyle.italic),
            ),
            Text(
              "Max : $tempMax    Min : $tempMin °C",
              style: const TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontStyle: FontStyle.italic),
            ),
          ],
        ),
      ),
    );
  }
}
