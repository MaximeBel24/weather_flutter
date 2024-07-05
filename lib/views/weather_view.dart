import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_meteo/cubit/weather/weather_cubit.dart';
import 'package:flutter_meteo/views/forecast_item.dart';
import 'package:flutter_meteo/views/forecast_not_found.dart';
import 'package:flutter_meteo/views/weather_icon.dart';
import 'package:flutter_meteo/views/weather_info.dart';
import 'package:flutter_meteo/views/weather_search.dart';
import 'package:flutter_meteo/views/weather_ui.dart';
import '../service/logger.dart';
import 'extra_info.dart';
import 'location_header.dart';

class WeatherView extends StatelessWidget {
  const WeatherView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => WeatherCubit()..initWeather(),
      child: BlocBuilder<WeatherCubit, WeatherState>(
        builder: (context, state) {
          return Scaffold(
              appBar: AppBar(
                title: Text(
                  'Météo : ${state.weather?.areaName}',
                  style: const TextStyle(
                      color: Colors.teal,
                      fontWeight: FontWeight.w600,
                      fontSize: 25),
                ),
                bottom: PreferredSize(
                    preferredSize: const Size.fromHeight(4.0),
                    child: Container(
                      color: Colors.black,
                      height: 1.0,
                    )),
              ),
              body: const WeatherUi());
        },
      ),
    );
  }
}
