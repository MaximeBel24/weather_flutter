part of 'weather_cubit.dart';

enum WeatherStatus { init, loading, loaded, error }

@freezed
class WeatherState with _$WeatherState {
  const factory WeatherState({
    @Default(WeatherStatus.init) WeatherStatus status,
    Exception? error,
    Weather? weather,
    List<Weather>? forecastWeather,
  }) = _WeatherState;
}
