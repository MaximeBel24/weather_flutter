import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:http/http.dart' as http;
import 'package:xml/xml.dart';

import '../../model/city.dart';

part 'search_city_cubit.freezed.dart';

part 'search_city_state.dart';

class SearchCityCubit extends Cubit<SearchCityState> {
  SearchCityCubit() : super(const SearchCityState());

  Future<void> initSearchCities(String cityName) async {
    emit(state.copyWith(
      status: SearchCityStatus.loading,
    ));
    try {
      final response = await http.get(Uri.parse(
          'http://api.geonames.org/search?name=$cityName&maxRows=5&username=maxmax2244'));
      if (response.statusCode == 200) {
        final document = XmlDocument.parse(response.body);
        final cities = document
            .findAllElements('geoname')
            .map((node) => City.fromXml(node))
            .toList();
        emit(state.copyWith(status: SearchCityStatus.loaded, cities: cities));
      } else {
        emit(state.copyWith(
          status: SearchCityStatus.error,
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        status: SearchCityStatus.error,
        error: Exception(e),
      ));
    }
  }
}
