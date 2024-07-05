import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_meteo/views/forecast_list.dart';
import 'package:flutter_meteo/views/weather_icon.dart';
import 'package:flutter_meteo/views/weather_info.dart';
import 'package:flutter_meteo/views/weather_search.dart';
import 'package:flutter_meteo/views/weather_ui.dart';

import '../cubit/weather/weather_cubit.dart';
import '../service/logger.dart';
import 'error_dialog.dart';
import 'extra_info.dart';
import 'location_header.dart';

class WeatherBackground extends StatelessWidget {
  const WeatherBackground({super.key});

  @override
  Widget build(BuildContext context) {
    late double temperature;

    return BlocProvider(
      create: (context) => WeatherCubit()..initWeather(),
      child: Scaffold(
        backgroundColor: Colors.black,
        extendBodyBehindAppBar: true,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(25, 50, 25, 20),
            child: BlocConsumer<WeatherCubit, WeatherState>(
              listener: (context, state) {
                late Color backgroundColor =
                    getBackgroundColor(state.weather?.temperature?.celsius);
                if (state.status == WeatherStatus.error) {
                  logger.e(state.status.name);
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return ErrorDialog(
                          errorMessage: state.error.toString(),
                          backgroundColor: backgroundColor,
                        );
                      });
                }
              },
              builder: (context, state) {
                late Color backgroundColor =
                    getBackgroundColor(state.weather?.temperature?.celsius);

                if (state.status == WeatherStatus.loading ||
                    state.weather == null) {
                  return const Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 300, horizontal: 150),
                      child: CircularProgressIndicator(
                        color: Colors.white,
                      ));
                }
                return SizedBox(
                  child: Stack(
                    children: [
                      Align(
                        alignment: const AlignmentDirectional(0, -1.2),
                        child: Container(
                          height: 700,
                          width: 1000,
                          decoration: BoxDecoration(color: backgroundColor),
                        ),
                      ),
                      BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 120, sigmaY: 120),
                        // blendMode: BlendMode,
                        child: Container(
                          decoration:
                              const BoxDecoration(color: Colors.transparent),
                        ),
                      ),
                      const SizedBox(child: WeatherUi())
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Color getBackgroundColor(double? temperature) {
    if (temperature != null) {
      if (temperature >= 30.0) {
        return Colors.red;
      } else if (temperature >= 20.0) {
        return Colors.orange;
      } else if (temperature >= 10.0) {
        return Colors.yellow;
      } else if (temperature >= 0) {
        return Colors.blue;
      } else {
        return Colors.cyan;
      }
    } else {
      return Colors.deepPurple;
    }
  }
}
