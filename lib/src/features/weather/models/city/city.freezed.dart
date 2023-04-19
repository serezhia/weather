// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'city.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

City _$CityFromJson(Map<String, dynamic> json) {
  return _City.fromJson(json);
}

/// @nodoc
mixin _$City {
  @JsonKey(name: 'name')
  String get name => throw _privateConstructorUsedError;
  @JsonKey(name: 'lat')
  double get lat => throw _privateConstructorUsedError;
  @JsonKey(name: 'lon')
  double get lon => throw _privateConstructorUsedError;
  @JsonKey(name: 'country')
  String get country => throw _privateConstructorUsedError;
  @JsonKey(name: 'local_names')
  Map<String, String>? get localNames => throw _privateConstructorUsedError;
  @JsonKey(name: 'state')
  String? get state => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CityCopyWith<City> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CityCopyWith<$Res> {
  factory $CityCopyWith(City value, $Res Function(City) then) =
      _$CityCopyWithImpl<$Res, City>;
  @useResult
  $Res call(
      {@JsonKey(name: 'name') String name,
      @JsonKey(name: 'lat') double lat,
      @JsonKey(name: 'lon') double lon,
      @JsonKey(name: 'country') String country,
      @JsonKey(name: 'local_names') Map<String, String>? localNames,
      @JsonKey(name: 'state') String? state});
}

/// @nodoc
class _$CityCopyWithImpl<$Res, $Val extends City>
    implements $CityCopyWith<$Res> {
  _$CityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? lat = null,
    Object? lon = null,
    Object? country = null,
    Object? localNames = freezed,
    Object? state = freezed,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      lat: null == lat
          ? _value.lat
          : lat // ignore: cast_nullable_to_non_nullable
              as double,
      lon: null == lon
          ? _value.lon
          : lon // ignore: cast_nullable_to_non_nullable
              as double,
      country: null == country
          ? _value.country
          : country // ignore: cast_nullable_to_non_nullable
              as String,
      localNames: freezed == localNames
          ? _value.localNames
          : localNames // ignore: cast_nullable_to_non_nullable
              as Map<String, String>?,
      state: freezed == state
          ? _value.state
          : state // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_CityCopyWith<$Res> implements $CityCopyWith<$Res> {
  factory _$$_CityCopyWith(_$_City value, $Res Function(_$_City) then) =
      __$$_CityCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'name') String name,
      @JsonKey(name: 'lat') double lat,
      @JsonKey(name: 'lon') double lon,
      @JsonKey(name: 'country') String country,
      @JsonKey(name: 'local_names') Map<String, String>? localNames,
      @JsonKey(name: 'state') String? state});
}

/// @nodoc
class __$$_CityCopyWithImpl<$Res> extends _$CityCopyWithImpl<$Res, _$_City>
    implements _$$_CityCopyWith<$Res> {
  __$$_CityCopyWithImpl(_$_City _value, $Res Function(_$_City) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? lat = null,
    Object? lon = null,
    Object? country = null,
    Object? localNames = freezed,
    Object? state = freezed,
  }) {
    return _then(_$_City(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      lat: null == lat
          ? _value.lat
          : lat // ignore: cast_nullable_to_non_nullable
              as double,
      lon: null == lon
          ? _value.lon
          : lon // ignore: cast_nullable_to_non_nullable
              as double,
      country: null == country
          ? _value.country
          : country // ignore: cast_nullable_to_non_nullable
              as String,
      localNames: freezed == localNames
          ? _value._localNames
          : localNames // ignore: cast_nullable_to_non_nullable
              as Map<String, String>?,
      state: freezed == state
          ? _value.state
          : state // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_City implements _City {
  _$_City(
      {@JsonKey(name: 'name')
          required this.name,
      @JsonKey(name: 'lat')
          required this.lat,
      @JsonKey(name: 'lon')
          required this.lon,
      @JsonKey(name: 'country')
          required this.country,
      @JsonKey(name: 'local_names')
          required final Map<String, String>? localNames,
      @JsonKey(name: 'state')
          this.state})
      : _localNames = localNames;

  factory _$_City.fromJson(Map<String, dynamic> json) => _$$_CityFromJson(json);

  @override
  @JsonKey(name: 'name')
  final String name;
  @override
  @JsonKey(name: 'lat')
  final double lat;
  @override
  @JsonKey(name: 'lon')
  final double lon;
  @override
  @JsonKey(name: 'country')
  final String country;
  final Map<String, String>? _localNames;
  @override
  @JsonKey(name: 'local_names')
  Map<String, String>? get localNames {
    final value = _localNames;
    if (value == null) return null;
    if (_localNames is EqualUnmodifiableMapView) return _localNames;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  @JsonKey(name: 'state')
  final String? state;

  @override
  String toString() {
    return 'City(name: $name, lat: $lat, lon: $lon, country: $country, localNames: $localNames, state: $state)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_City &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.lat, lat) || other.lat == lat) &&
            (identical(other.lon, lon) || other.lon == lon) &&
            (identical(other.country, country) || other.country == country) &&
            const DeepCollectionEquality()
                .equals(other._localNames, _localNames) &&
            (identical(other.state, state) || other.state == state));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, name, lat, lon, country,
      const DeepCollectionEquality().hash(_localNames), state);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_CityCopyWith<_$_City> get copyWith =>
      __$$_CityCopyWithImpl<_$_City>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_CityToJson(
      this,
    );
  }
}

abstract class _City implements City {
  factory _City(
      {@JsonKey(name: 'name')
          required final String name,
      @JsonKey(name: 'lat')
          required final double lat,
      @JsonKey(name: 'lon')
          required final double lon,
      @JsonKey(name: 'country')
          required final String country,
      @JsonKey(name: 'local_names')
          required final Map<String, String>? localNames,
      @JsonKey(name: 'state')
          final String? state}) = _$_City;

  factory _City.fromJson(Map<String, dynamic> json) = _$_City.fromJson;

  @override
  @JsonKey(name: 'name')
  String get name;
  @override
  @JsonKey(name: 'lat')
  double get lat;
  @override
  @JsonKey(name: 'lon')
  double get lon;
  @override
  @JsonKey(name: 'country')
  String get country;
  @override
  @JsonKey(name: 'local_names')
  Map<String, String>? get localNames;
  @override
  @JsonKey(name: 'state')
  String? get state;
  @override
  @JsonKey(ignore: true)
  _$$_CityCopyWith<_$_City> get copyWith => throw _privateConstructorUsedError;
}
