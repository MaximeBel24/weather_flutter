import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_meteo/consts.dart';
import 'package:flutter_meteo/service/logger.dart';
import 'package:flutter_meteo/views/extra_info.dart';
import 'package:flutter_meteo/views/location_header.dart';
import 'package:flutter_meteo/views/weather_icon.dart';
import 'package:flutter_meteo/views/weather_info.dart';
import 'package:intl/intl.dart';
import 'package:string_capitalize/string_capitalize.dart';
import 'package:weather/weather.dart';

import 'forecast_item.dart';

class HomeView extends StatefulWidget {
  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<HomeView> {
  final WeatherFactory _wf = WeatherFactory(OPENWEATHER_API_KEY);

  Weather? _weather;
  List<Weather>? _forecastWeather;
  String cityName = "Brive";

  @override
  void initState() {
    super.initState();
    _updateWeather(cityName);
    _getForecastWeather(cityName);
  }

  void _updateWeather(String cityName) {
    _wf.currentWeatherByCityName(cityName).then((w) {
      logger.i(w);
      setState(() {
        _weather = w;
      });
    });
  }

  void _getForecastWeather(String cityName) {
    _wf.fiveDayForecastByCityName(cityName).then((fw) {
      logger.e(fw);
      setState(() {
        _forecastWeather = fw;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Météo : ${_weather?.areaName}"),
          bottom: PreferredSize(
              preferredSize: const Size.fromHeight(4.0),
              child: Container(
                color: Colors.black,
                height: 1.0,
              )),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Placeholder(),
          ),
        ));
  }

  List<Widget> _buildForecastList() {
    if (_forecastWeather == null) {
      return [];
    }
    return _forecastWeather!
        .sublist(1)
        .map((forecast) => ForecastItem(
              forecast: forecast,
            ))
        .toList();
  }
}
