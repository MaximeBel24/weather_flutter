import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_meteo/cubit/weather_cubit.dart';
import 'package:flutter_meteo/views/forecast_item.dart';
import 'package:flutter_meteo/views/weather_icon.dart';
import 'package:flutter_meteo/views/weather_info.dart';
import 'package:flutter_meteo/views/weather_search.dart';

import 'extra_info.dart';
import 'location_header.dart';

class WeatherView extends StatelessWidget {
  const WeatherView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => WeatherCubit()..initWeather(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Météo'),
          bottom: PreferredSize(
              preferredSize: const Size.fromHeight(4.0),
              child: Container(
                color: Colors.black,
                height: 1.0,
              )),
        ),
        body: BlocBuilder<WeatherCubit, WeatherState>(
          builder: (context, state) {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    myPadding(30),
                    WeatherSearch(
                      onSubmitted: (newString) {
                        context.read<WeatherCubit>().updateWeather(newString);
                      },
                    ),
                    BlocBuilder<WeatherCubit, WeatherState>(
                      builder: (context, state) {
                        if (state.status == WeatherStatus.loading ||
                            state.weather == null) {
                          return const Padding(
                            padding: EdgeInsets.symmetric(vertical: 300),
                            child: CircularProgressIndicator(),
                          );
                        }
                        if (state.status == WeatherStatus.error) {
                          return Padding(
                            padding: const EdgeInsets.only(top: 50),
                            child: Text(
                              state.error.toString(),
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 25),
                            ),
                          );
                        }
                        return Column(
                          children: [
                            myPadding(60),
                            LocationHeader(
                              weather: state.weather,
                            ),
                            myPadding(20),
                            WeatherIcon(
                              weather: state.weather,
                            ),
                            myPadding(10),
                            WeatherInfo(
                              weather: state.weather,
                            ),
                            myPadding(20),
                            ExtraInfo(
                              weather: state.weather,
                            ),
                            myPadding(20),
                            const Text("Prévisions météo"),
                          ],
                        );
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  static myPadding(double value) {
    return SizedBox(height: value);
  }
}
