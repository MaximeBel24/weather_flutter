import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_meteo/cubit/search_city/search_city_cubit.dart';
import 'package:flutter_meteo/service/logger.dart';
import 'package:flutter_meteo/views/error_dialog.dart';
import 'package:flutter_meteo/views/forecast_list.dart';
import 'package:flutter_meteo/views/weather_icon.dart';
import 'package:flutter_meteo/views/weather_info.dart';
import 'package:flutter_meteo/views/weather_search.dart';
import 'package:flutter_meteo/views/weather_search_city.dart';

import '../cubit/weather/weather_cubit.dart';
import 'extra_info.dart';
import 'location_header.dart';

class WeatherUi extends StatelessWidget {
  const WeatherUi({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        myPadding(20),
        // WeatherSearch(
        //   onSubmitted: (newString) {
        //     context.read<WeatherCubit>().updateWeather(newString);
        //   },
        // ),
        WeatherSearchCity(
          onSelected: (city) {
            context.read<WeatherCubit>().updateWeather(city);
          },
        ),
        BlocBuilder<WeatherCubit, WeatherState>(
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
                myPadding(40),
                LocationHeader(
                  weather: state.weather,
                ),
                myPadding(10),
                WeatherIcon(
                  weather: state.weather,
                ),
                // myPadding(10),
                // WeatherInfo(
                //   weather: state.weather,
                // ),
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
