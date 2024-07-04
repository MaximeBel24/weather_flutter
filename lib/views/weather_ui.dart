import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_meteo/views/forecast_list.dart';
import 'package:flutter_meteo/views/weather_icon.dart';
import 'package:flutter_meteo/views/weather_info.dart';
import 'package:flutter_meteo/views/weather_search.dart';

import '../cubit/weather_cubit.dart';
import '../service/logger.dart';
import 'extra_info.dart';
import 'forecast_item.dart';
import 'forecast_not_found.dart';
import 'location_header.dart';

class WeatherUi extends StatelessWidget {
  const WeatherUi({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        myPadding(20),
        WeatherSearch(
          onSubmitted: (newString) {
            context.read<WeatherCubit>().updateWeather(newString);
          },
        ),
        BlocConsumer<WeatherCubit, WeatherState>(
          listener: (context, state) {
            if (state.status == WeatherStatus.error) {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text(
                        "Erreur",
                        style: TextStyle(
                            color: Colors.red, fontWeight: FontWeight.w700),
                      ),
                      content: Text(state.error.toString()),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text('OK'),
                        )
                      ],
                    );
                  });
            }
          },
          builder: (context, state) {
            if (state.status == WeatherStatus.loading ||
                state.weather == null) {
              return const Padding(
                  padding: EdgeInsets.symmetric(vertical: 300),
                  child: CircularProgressIndicator(
                    color: Colors.white,
                  ));
            }
            // logger.i('Forecast weather: $state.forecastWeather');
            return Column(
              children: [
                myPadding(20),
                LocationHeader(
                  weather: state.weather,
                ),
                myPadding(20),
                WeatherIcon(
                  weather: state.weather,
                ),
                myPadding(20),
                WeatherInfo(
                  weather: state.weather,
                ),
                myPadding(20),
                ExtraInfo(
                  weather: state.weather,
                ),
                myPadding(20),
                const Text(
                  "Prévisions météo :",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 25),
                ),
                myPadding(20),
                const ForecastList()
              ],
            );
          },
        ),
      ],
    );
  }

  static myPadding(double value) {
    return SizedBox(height: value);
  }
}
