// ignore_for_file: avoid_dynamic_calls

import 'package:freezed_annotation/freezed_annotation.dart';

part 'weather.freezed.dart';
part 'weather.g.dart';

@freezed
class Weather with _$Weather {
  factory Weather({
    required DateTime date,
    required WeatherType type,
    required String description,
    required double temp,
    @JsonKey(name: 'feels_like_temp') required double feelsLikeTemp,
    @JsonKey(name: 'wind_speed') required double windSpeed,
    required int humidity,
  }) = _Weather;

  factory Weather.fromJson(Map<String, dynamic> json) =>
      _$WeatherFromJson(json);

  factory Weather.fromOpenWeatherMapJson(Map<String, dynamic> apiJson) {
    final newJson = <String, dynamic>{};

    newJson['date'] =
        DateTime.fromMillisecondsSinceEpoch((apiJson['dt'] as int) * 1000)
            .toString();

    newJson['temp'] = apiJson['main']!['temp'];
    newJson['feels_like_temp'] = apiJson['main']!['feels_like'];

    newJson['humidity'] = apiJson['main']!['humidity'];
    newJson['wind_speed'] = apiJson['wind']!['speed'];

    newJson['type'] =
        apiJson['weather']!.first['main'].toString().toLowerCase();
    newJson['description'] = apiJson['weather']!.first!['description'];

    return _$WeatherFromJson(newJson);
  }
}

enum WeatherType {
  thunderstorm,
  drizzle,
  rain,
  snow,
  atmosphere,
  clear,
  clouds,
}
