import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_meteo/cubit/weather/weather_cubit.dart';
import 'package:flutter_meteo/service/logger.dart';

import 'forecast_item.dart';
import 'forecast_not_found.dart';

class ForecastList extends StatelessWidget {
  const ForecastList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WeatherCubit, WeatherState>(
      builder: (context, state) {
        if (state.status == WeatherStatus.loading ||
            state.forecastWeather == null) {
          return const ForecastNotFound();
        }
        // logger.e(state.forecastWeather);
        return SizedBox(
          height: 240,
          width: 580,
          child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: state.forecastWeather!.length,
              separatorBuilder: (context, index) => const Divider(),
              itemBuilder: (context, index) {
                final weather = state.forecastWeather![index];
                return ForecastItem(
                  forecast: weather,
                );
              }),
        );
      },
    );
  }
}
