import 'package:bloc/bloc.dart';
import 'package:flutter_meteo/service/logger.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather/weather.dart';

import '../consts.dart';

part 'weather_cubit.freezed.dart';

part 'weather_state.dart';

class WeatherCubit extends Cubit<WeatherState> {
  final WeatherFactory wf = WeatherFactory(OPENWEATHER_API_KEY);

  WeatherCubit() : super(const WeatherState());

  Future<void> initWeather() async {
    emit(state.copyWith(
      status: WeatherStatus.loading,
    ));
    try {
      await checkPermission();
      final Position coordinates = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best,
      );
      final Weather weather = await wf.currentWeatherByLocation(
          coordinates.latitude, coordinates.longitude);
      emit(state.copyWith(
        status: WeatherStatus.loaded,
        weather: weather,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: WeatherStatus.error,
        error: Exception(e),
      ));
    }
  }

  Future<void> updateWeather(String cityName) async {
    logger.i(cityName);
    emit(state.copyWith(status: WeatherStatus.loading));
    try {
      final Weather weather = await wf.currentWeatherByCityName(cityName);
      final List<Weather> forecastWeather =
          await wf.fiveDayForecastByCityName(cityName);
      emit(state.copyWith(
          status: WeatherStatus.loaded,
          weather: weather,
          forecastWeather: forecastWeather));
    } catch (e) {
      emit(state.copyWith(
        status: WeatherStatus.error,
        error: Exception("Une erreur s'est produite."),
      ));
    }
  }

  static Future<void> checkPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw Exception('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw Exception('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      throw Exception(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
  }
}
