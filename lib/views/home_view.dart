import 'package:flutter/material.dart';
import 'package:flutter_meteo/consts.dart';
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
      setState(() {
        _weather = w;
      });
    });
  }
  void _getForecastWeather(String cityName) {
    _wf.fiveDayForecastByCityName(cityName).then((fw) {
      setState(() {
        _forecastWeather = fw;
      });
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Météo : ${_weather?.areaName}"
        ),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(4.0),
            child: Container(
            color: Colors.black,
            height: 1.0,)
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: buildUI(),
        ),
      )
    );
  }

  Padding myPadding(double value){
    return Padding(padding: EdgeInsets.only(top: value));
  }


  Widget buildUI() {

    String countryCode = _weather!.country!.toUpperCase();

    if(_weather == null) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    return SizedBox(

      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          myPadding(30),
          _weatherSearch(),
          myPadding(60),
          LocationHeader(weather: _weather,),
          myPadding(20),
          WeatherIcon(weather: _weather,),
          myPadding(10),
          WeatherInfo(weather: _weather,),
          myPadding(20),
          ExtraInfo(weather: _weather,),
          myPadding(20),
          ..._buildForecastList(),
        ],
      ),
    );
  }

  Widget _weatherSearch(){
    return TextField(
      decoration: InputDecoration(
        hintText: "Saisissez un nom de ville",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25)
        )
      ),
      onSubmitted: (newString) {
        setState(() {
          cityName = newString;
        });
        _updateWeather(cityName);
        _getForecastWeather(cityName);
      },
    );
  }

  List<Widget> _buildForecastList() {
    if (_forecastWeather == null) {
      return [];
    }
    return _forecastWeather!.sublist(1).map((forecast) => ForecastItem(forecast: forecast,)).toList();
  }


}