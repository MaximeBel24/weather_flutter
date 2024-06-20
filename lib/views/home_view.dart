import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_meteo/consts.dart';
import 'package:intl/intl.dart';
import 'package:weather/weather.dart';

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
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: buildUI(),
        ),
      )
    );
  }

  Padding myPadding(double value){
    return Padding(padding: EdgeInsets.only(top: value));
  }


  Widget buildUI() {
    if(_weather == null) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    return SizedBox(
      width: MediaQuery.sizeOf(context).width,
      height: MediaQuery.sizeOf(context).height,
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.max,
        children: [
          myPadding(30),
          _weatherSearch(),
          myPadding(50),
          _locationHeader(),
          _weatherIcon(),
          _weatherInfo(),
          myPadding(10),
          _extraInfo(),
          myPadding(10),
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
      },
    );
  }

  Widget _locationHeader(){

    DateTime now = _weather!.date!;
    String countryCode = _weather!.country!.toUpperCase();
    String countryInitials = countryCode.substring(0, 2);

    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.only(left: 10),
        child: Column(
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  DateFormat("MMM d").format(now),
                  style: const TextStyle(
                      color: Colors.deepOrange,
                      fontSize: 18
                  ),
                ),
                const Padding(padding: EdgeInsets.symmetric(horizontal: 3)),
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
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  _weather?.areaName ?? "",
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

  Widget _weatherInfo() {
    return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
            decoration: BoxDecoration(
              color: Colors.cyan,
              borderRadius: BorderRadius.circular(10),
            ),
            child:Padding(
              padding: EdgeInsets.all(6),
              child: Text(
              _weather?.weatherDescription ?? "",
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
            ),
          ),
        ),
            // Container(
            //   decoration: BoxDecoration(
            //     color: Colors.white,
            //     borderRadius: BorderRadius.circular(10),
            //   ),
            //   child:Padding(
            //     padding: EdgeInsets.all(6),
            //     child: Text(
            //       "+4",
            //       style: const TextStyle(
            //         color: Colors.cyan,
            //         fontSize: 20,
            //       ),
            //     ),
            //   ),
            // )
      ]
    );
  }

  Widget _weatherIcon() {
    return Row(
      // mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      // crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          height: MediaQuery.sizeOf(context).height * 0.20,
          width: MediaQuery.sizeOf(context).width * 0.20,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(
                      "http://openweathermap.org/img/wn/${_weather?.weatherIcon}@4x.png"
                  )
              )
          ),
        ),

        Text(
          "${_weather?.temperature?.celsius?.toStringAsFixed(0)}° C",
          style: const TextStyle(
              color: Colors.black,
              fontSize: 50,
              fontWeight: FontWeight.w400
          ),
        )

      ],
    );
  }

  // Widget _currentTemp() {
  //   return ;
  // }

  Widget _extraInfo() {
    return Container(
      height: MediaQuery.sizeOf(context).height * 0.15,
      width: MediaQuery.sizeOf(context).width * 0.80,
      decoration: BoxDecoration(color: Colors.cyan, borderRadius: BorderRadius.circular(10)),
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Max: ${_weather?.tempMax?.celsius?.toStringAsFixed(0)}° C",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 15
                ),
              ),
              Text(
                "Min: ${_weather?.tempMin?.celsius?.toStringAsFixed(0)}° C",
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15
                ),
              )
            ],
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Wind: ${_weather?.windSpeed?.toStringAsFixed(0)}m/s",
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15
                ),
              ),
              Text(
                "Humidity: ${_weather?.humidity?.toStringAsFixed(0)}%",
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget _forecastItem(Weather forecast) {
    DateTime date = forecast.date!;
    String day = DateFormat("EEE").format(date);
    String iconUrl = "http://openweathermap.org/img/wn/${forecast.weatherIcon}@2x.png";
    String temp = "${forecast.temperature?.celsius?.toStringAsFixed(0)}°";
    return Row(
      children: [
        Text(
          day,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(width: 10),
        Image.network(
          iconUrl,
          width: 30,
          height: 30,
        ),
        const SizedBox(width: 10),
        Text(
          temp,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  List<Widget> _buildForecastList() {
    if (_forecastWeather == null) {
      return [];
    }
    return _forecastWeather!.sublist(1).map((forecast) => _forecastItem(forecast)).toList();
  }
}