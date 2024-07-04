import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_meteo/views/forecast_list.dart';
import 'package:flutter_meteo/views/weather_icon.dart';
import 'package:flutter_meteo/views/weather_info.dart';
import 'package:flutter_meteo/views/weather_search.dart';
import 'package:flutter_meteo/views/weather_ui.dart';

import '../cubit/weather_cubit.dart';
import 'extra_info.dart';
import 'location_header.dart';

class WeatherBackground extends StatelessWidget {
  const WeatherBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => WeatherCubit()..initWeather(),
      child: Scaffold(
        backgroundColor: Colors.black,
        extendBodyBehindAppBar: true,
        body: Padding(
          padding: const EdgeInsets.fromLTRB(25, 50, 25, 20),
          child: SizedBox(
            child: Stack(
              children: [
                Align(
                  alignment: const AlignmentDirectional(3, -0.3),
                  child: Container(
                    height: 900,
                    width: 300,
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle, color: Colors.teal),
                  ),
                ),
                Align(
                  alignment: const AlignmentDirectional(-3, -0.3),
                  child: Container(
                    height: 900,
                    width: 300,
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle, color: Colors.teal),
                  ),
                ),
                Align(
                  alignment: const AlignmentDirectional(0, -1.2),
                  child: Container(
                    height: 350,
                    width: 1000,
                    decoration: const BoxDecoration(color: Colors.deepOrange),
                  ),
                ),
                BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 100, sigmaY: 100),
                  child: Container(
                    decoration: const BoxDecoration(color: Colors.transparent),
                  ),
                ),
                const SizedBox(child: WeatherUi())
              ],
            ),
          ),
        ),
      ),
    );
  }

  static myPadding(double value) {
    return SizedBox(height: value);
  }
}
