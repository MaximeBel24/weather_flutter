import 'package:flutter/material.dart';
import 'package:flutter_meteo/consts.dart';
import 'package:intl/intl.dart';
import 'package:string_capitalize/string_capitalize.dart';
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
          _locationHeader(),
          myPadding(20),
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
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  DateFormat("MMM d").format(now),
                  style: const TextStyle(
                      color: Colors.deepOrange,
                      fontSize: 18
                  ),
                ),
                const Text(", ",
                    style: TextStyle(
                        color: Colors.deepOrange,
                        fontSize: 18
                    )),
                // const Padding(padding: EdgeInsets.symmetric(horizontal: 3)),
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

    String? weatherMain = _weather?.weatherMain?.capitalize();

    return Row(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.teal.shade300,
                borderRadius: BorderRadius.circular(8),
              ),
              child:Padding(
                padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 5),
                child: Row(

                  children: [
                    Text(
                      "$weatherMain",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                    const Padding(padding: EdgeInsets.symmetric(horizontal: 5)),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child:const Padding(
                        padding: EdgeInsets.symmetric(vertical: 3, horizontal: 5),
                        child: Text(
                          "+4",
                          style: TextStyle(
                            color: Colors.teal,
                            fontSize: 13,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),

      ]
    );
  }

  Widget _weatherIcon() {

    String weatherIcon = "http://openweathermap.org/img/wn/${_weather?.weatherIcon}@4x.png";

    return Row(
      // mainAxisSize: MainAxisSize.max,
      children: [
        Image.network(
          weatherIcon,
          height: 70,
          width: 70,
        ),
        Text(
          "${_weather?.temperature?.celsius?.toStringAsFixed(0)}°C",
          style: const TextStyle(
              color: Colors.black,
              fontSize: 50,
              fontWeight: FontWeight.w400
          ),
        )

      ],
    );
  }

  Widget _extraInfo() {


    String? feelsLike = _weather?.tempFeelsLike?.celsius?.toStringAsFixed(0);
    String? description = _weather?.weatherDescription?.capitalize();
    String? weatherMain = _weather?.weatherMain?.capitalize();

    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Feels like $feelsLike°C. $description. $weatherMain",
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w600,
              fontSize: 20
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Max: ${_weather?.tempMax?.celsius?.toStringAsFixed(0)}°C",
                style: const TextStyle(
                  fontSize: 15
                ),
              ),
              Text(
                "Min: ${_weather?.tempMin?.celsius?.toStringAsFixed(0)}°C",
                style: const TextStyle(
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
                    fontSize: 15
                ),
              ),
              Text(
                "Humidity: ${_weather?.humidity?.toStringAsFixed(0)}%",
                style: const TextStyle(
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
    String day = DateFormat("EEE, MMM d").format(date);
    String iconUrl = "http://openweathermap.org/img/wn/${forecast.weatherIcon}@2x.png";
    String tempMax = "${forecast.tempMax?.celsius?.toStringAsFixed(0)}°";
    String tempMin = "${forecast.tempMin?.celsius?.toStringAsFixed(0)}°";
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          day,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
        Row(
          children: [
            Image.network(
              iconUrl,
              width: 45,
              height: 45,
            ),
            Text(
              "$tempMax / $tempMin C",
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        )
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