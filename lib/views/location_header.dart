import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather/weather.dart';

class LocationHeader extends StatelessWidget {

  final Weather? weather;

  const LocationHeader({super.key, required this.weather});

  @override
  Widget build(BuildContext context) {

    DateTime now = weather!.date!;
    String areaName = weather!.areaName!;
    String countryCode = weather!.country!.toUpperCase();
    String countryInitials = countryCode.substring(0, 2);

    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Column(
            children: [
              Row(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    DateFormat("MMM d").format(now),
                    style: const TextStyle(
                        color: Colors.deepOrange,
                        fontSize: 18
                    ),
                  ),
                  const Text(", ",
                      style: TextStyle(
                          color: Colors.deepOrange,
                          fontSize: 18
                      )),
                  // const Padding(padding: EdgeInsets.symmetric(horizontal: 3)),
                  Text(
                    DateFormat("h:mm a").format(now),
                    style: const TextStyle(
                      color: Colors.deepOrange,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    areaName ?? "",
                    style: const TextStyle(
                        fontSize: 35,
                        fontWeight: FontWeight.w500
                    ),
                  ),
                  Text(
                    ", $countryInitials",
                    style: const TextStyle(
                        fontSize: 35,
                        fontWeight: FontWeight.w500
                    ),
                  ),
                ],
              )
            ],
          )
      ),
    );
  }
}