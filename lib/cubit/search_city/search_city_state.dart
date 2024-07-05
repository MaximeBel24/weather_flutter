part of 'search_city_cubit.dart';

enum SearchCityStatus { init, loading, loaded, error }

@freezed
class SearchCityState with _$SearchCityState {
  const factory SearchCityState({
    @Default(SearchCityStatus.init) SearchCityStatus status,
    Exception? error,
    @Default([]) List<City> cities,
  }) = _SearchCityState;
}
