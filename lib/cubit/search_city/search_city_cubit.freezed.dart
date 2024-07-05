// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'search_city_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$SearchCityState {
  SearchCityStatus get status => throw _privateConstructorUsedError;
  Exception? get error => throw _privateConstructorUsedError;
  List<City> get cities => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $SearchCityStateCopyWith<SearchCityState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SearchCityStateCopyWith<$Res> {
  factory $SearchCityStateCopyWith(
          SearchCityState value, $Res Function(SearchCityState) then) =
      _$SearchCityStateCopyWithImpl<$Res, SearchCityState>;
  @useResult
  $Res call({SearchCityStatus status, Exception? error, List<City> cities});
}

/// @nodoc
class _$SearchCityStateCopyWithImpl<$Res, $Val extends SearchCityState>
    implements $SearchCityStateCopyWith<$Res> {
  _$SearchCityStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? error = freezed,
    Object? cities = null,
  }) {
    return _then(_value.copyWith(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as SearchCityStatus,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as Exception?,
      cities: null == cities
          ? _value.cities
          : cities // ignore: cast_nullable_to_non_nullable
              as List<City>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SearchCityStateImplCopyWith<$Res>
    implements $SearchCityStateCopyWith<$Res> {
  factory _$$SearchCityStateImplCopyWith(_$SearchCityStateImpl value,
          $Res Function(_$SearchCityStateImpl) then) =
      __$$SearchCityStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({SearchCityStatus status, Exception? error, List<City> cities});
}

/// @nodoc
class __$$SearchCityStateImplCopyWithImpl<$Res>
    extends _$SearchCityStateCopyWithImpl<$Res, _$SearchCityStateImpl>
    implements _$$SearchCityStateImplCopyWith<$Res> {
  __$$SearchCityStateImplCopyWithImpl(
      _$SearchCityStateImpl _value, $Res Function(_$SearchCityStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? error = freezed,
    Object? cities = null,
  }) {
    return _then(_$SearchCityStateImpl(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as SearchCityStatus,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as Exception?,
      cities: null == cities
          ? _value._cities
          : cities // ignore: cast_nullable_to_non_nullable
              as List<City>,
    ));
  }
}

/// @nodoc

class _$SearchCityStateImpl implements _SearchCityState {
  const _$SearchCityStateImpl(
      {this.status = SearchCityStatus.init,
      this.error,
      final List<City> cities = const []})
      : _cities = cities;

  @override
  @JsonKey()
  final SearchCityStatus status;
  @override
  final Exception? error;
  final List<City> _cities;
  @override
  @JsonKey()
  List<City> get cities {
    if (_cities is EqualUnmodifiableListView) return _cities;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_cities);
  }

  @override
  String toString() {
    return 'SearchCityState(status: $status, error: $error, cities: $cities)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SearchCityStateImpl &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.error, error) || other.error == error) &&
            const DeepCollectionEquality().equals(other._cities, _cities));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, status, error, const DeepCollectionEquality().hash(_cities));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SearchCityStateImplCopyWith<_$SearchCityStateImpl> get copyWith =>
      __$$SearchCityStateImplCopyWithImpl<_$SearchCityStateImpl>(
          this, _$identity);
}

abstract class _SearchCityState implements SearchCityState {
  const factory _SearchCityState(
      {final SearchCityStatus status,
      final Exception? error,
      final List<City> cities}) = _$SearchCityStateImpl;

  @override
  SearchCityStatus get status;
  @override
  Exception? get error;
  @override
  List<City> get cities;
  @override
  @JsonKey(ignore: true)
  _$$SearchCityStateImplCopyWith<_$SearchCityStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
