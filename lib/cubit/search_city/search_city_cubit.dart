import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:meta/meta.dart';

part 'search_city_cubit.freezed.dart';

part 'search_city_state.dart';

class SearchCityCubit extends Cubit<SearchCityState> {
  SearchCityCubit() : super(const SearchCityState());

  Future<void> initSearchCity() async {
    emit(state.copyWith(
      status: SearchCityStatus.loading,
    ));
    try {} catch (e) {
      emit(state.copyWith(
        status: SearchCityStatus.error,
        error: Exception(e),
      ));
    }
  }
}
