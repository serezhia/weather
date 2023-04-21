import 'package:dio/dio.dart';
import 'package:weather/src/features/weather/models/city/city.dart';
import 'package:weather/src/features/weather/models/weather/weather.dart';

abstract class IWeatherRepository {
  Future<List<City>> getCitysByName({required String name});

  Future<City?> getCityByCoords({
    required double lat,
    required double lon,
  });

  Future<List<Weather>> getWeathersByDay({
    required City city,
    required DateTime date,
  });

  Future<List<Weather>> getWeathersByThreeDay({
    required City city,
  });

  Future<Weather> getCurrentWeather({
    required City city,
  });
}

class OpenWeatherMapWeatherRepository implements IWeatherRepository {
  const OpenWeatherMapWeatherRepository(this.dio, this.appId);

  final Dio dio;
  final String appId;
  @override
  Future<City?> getCityByCoords({
    required double lat,
    required double lon,
  }) async {
    final response = await dio.get<List<dynamic>>(
      'https://api.openweathermap.org/geo/1.0/reverse?lat=$lat&lon=$lon&limit=1&appid=$appId',
    );

    if (response.data == null || response.data!.isEmpty) {
      return null;
    } else {
      return City.fromJson(
        response.data!.first as Map<String, Object?>,
      );
    }
  }

  @override
  Future<List<City>> getCitysByName({required String name}) async {
    final response = await dio.get<List<dynamic>>(
      'https://api.openweathermap.org/geo/1.0/direct?q=$name&limit=10&appid=$appId',
    );

    if (response.data == null || response.data!.isEmpty) {
      return [];
    } else {
      final city = <City>[];
      for (final el in response.data!) {
        city.add(City.fromJson(el as Map<String, Object?>));
      }
      return city;
    }
  }

  @override
  Future<Weather> getCurrentWeather({required City city}) {
    // TODO: implement getCurrentWeather
    throw UnimplementedError();
  }

  @override
  Future<List<Weather>> getWeathersByDay(
      {required City city, required DateTime date}) {
    // TODO: implement getWeathersByDay
    throw UnimplementedError();
  }

  @override
  Future<List<Weather>> getWeathersByThreeDay({required City city}) async {
    final response = await dio.get<dynamic>(
      'https://api.openweathermap.org/data/2.5/forecast?lat=${city.lat}&lon=${city.lon}&units=metric&appid=$appId',
    );

    if (response.data == null) {
      return [];
    } else {
      final weathers = <Weather>[];
      for (final el in response.data!['list'] as List<dynamic>) {
        weathers.add(
          Weather.fromOpenWeatherMapJson(el as Map<String, Object?>),
        );
      }
      return weathers;
    }
  }
}
