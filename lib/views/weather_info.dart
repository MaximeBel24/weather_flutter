import 'package:flutter/material.dart';
import 'package:string_capitalize/string_capitalize.dart';
import 'package:weather/weather.dart';

class WeatherInfo extends StatelessWidget {

  final Weather? weather;

  const WeatherInfo({super.key, this.weather});

  @override
  Widget build(BuildContext context) {

    String? weatherMain = weather?.weatherMain?.capitalize();

    return Row(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.teal.shade300,
              borderRadius: BorderRadius.circular(8),
            ),
            child:Padding(
              padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 5),
              child: Row(

                children: [
                  Text(
                    "$weatherMain",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                  const Padding(padding: EdgeInsets.symmetric(horizontal: 5)),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child:const Padding(
                      padding: EdgeInsets.symmetric(vertical: 3, horizontal: 5),
                      child: Text(
                        "+4",
                        style: TextStyle(
                          color: Colors.teal,
                          fontSize: 13,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),

        ]
    );
  }
}