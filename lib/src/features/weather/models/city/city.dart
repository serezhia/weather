import 'package:freezed_annotation/freezed_annotation.dart';

part 'city.freezed.dart';
part 'city.g.dart';

@freezed
class City with _$City {
  factory City({
    /// Название города на английском
    @JsonKey(name: 'name') required String name,

    /// Широта
    @JsonKey(name: 'lat') required double lat,

    /// Долгота
    @JsonKey(name: 'lon') required double lon,

    /// Страна в 2 буквах
    @JsonKey(name: 'country') required String country,

    /// Словарь с переводом городов на другие языки
    @JsonKey(name: 'local_names') required Map<String, String>? localNames,

    /// Штат/Область/Регион
    @JsonKey(name: 'state') String? state,
  }) = _City;

  factory City.fromJson(Map<String, dynamic> json) => _$CityFromJson(json);
}
