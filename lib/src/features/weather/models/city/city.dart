import 'package:freezed_annotation/freezed_annotation.dart';

part 'city.freezed.dart';
part 'city.g.dart';

@freezed
class City with _$City {
  factory City({
    @JsonKey(name: 'name') required String name,
    @JsonKey(name: 'lat') required double lat,
    @JsonKey(name: 'lon') required double lon,
    @JsonKey(name: 'country') required String country,
    @JsonKey(name: 'local_names') required Map<String, String>? localNames,
    @JsonKey(name: 'state') String? state,
  }) = _City;

  factory City.fromJson(Map<String, dynamic> json) => _$CityFromJson(json);
}
