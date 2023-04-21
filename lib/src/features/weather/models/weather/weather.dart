// ignore_for_file: avoid_dynamic_calls

import 'package:freezed_annotation/freezed_annotation.dart';

part 'weather.freezed.dart';
part 'weather.g.dart';

@freezed
class Weather with _$Weather {
  factory Weather({
    required DateTime date,

    /// Тип погоды (дождь, солнце)
    required WeatherType type,

    /// Точное описание
    required String description,

    /// Температура
    required double temp,

    /// По ощущениям
    @JsonKey(name: 'feels_like_temp') required double feelsLikeTemp,

    /// Скорость ветра
    @JsonKey(name: 'wind_speed') required double windSpeed,

    /// Влажность
    required int humidity,
  }) = _Weather;

  factory Weather.fromJson(Map<String, dynamic> json) =>
      _$WeatherFromJson(json);

  /// Метод перевода из OpenWeatherMap в объект
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

/// Типы погодных явлений
enum WeatherType {
  /// Шторм
  thunderstorm,

  /// Моросит
  drizzle,

  /// Дождь
  rain,

  /// Снег
  snow,

  /// Всякое другое
  atmosphere,

  /// Безоблачно
  clear,

  ///Облачно
  clouds,
}
