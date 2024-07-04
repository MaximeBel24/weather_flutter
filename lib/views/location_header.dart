import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:string_capitalize/string_capitalize.dart';
import 'package:weather/weather.dart';

class LocationHeader extends StatelessWidget {
  final Weather? weather;

  const LocationHeader({super.key, required this.weather});

  @override
  Widget build(BuildContext context) {
    DateTime date = weather!.date!;
    String day =
        DateFormat.MMMMEEEEd('fr_FR').add_Hm().format(date).capitalize();
    String areaName = weather!.areaName!;
    String countryCode = weather!.country!.toUpperCase();
    String countryInitials = countryCode.substring(0, 2);

    return Align(
      child: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    day,
                    style: const TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    areaName ?? "",
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 35,
                        fontWeight: FontWeight.w500),
                  ),
                  Text(
                    ", $countryInitials",
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 35,
                        fontWeight: FontWeight.w500),
                  ),
                ],
              )
            ],
          )),
    );
  }
}
