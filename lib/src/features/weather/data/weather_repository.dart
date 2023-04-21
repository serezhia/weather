import 'package:dio/dio.dart';
import 'package:weather/src/features/weather/models/city/city.dart';
import 'package:weather/src/features/weather/models/exeption/weather_exeption.dart';
import 'package:weather/src/features/weather/models/weather/weather.dart';

abstract class IWeatherRepository {
  /// Получение городов по имени
  Future<List<City>> getCitiesByName({required String name});

  /// Получние города по координатам
  Future<City> getCityByCoords({
    required double lat,
    required double lon,
  });

  /// Получение погоды по городу
  Future<List<Weather>> getWeathers({
    required City city,
  });
}

class OpenWeatherMapWeatherRepository implements IWeatherRepository {
  const OpenWeatherMapWeatherRepository(this.dio, this.appId);

  final Dio dio;

  /// Api key
  final String appId;
  @override
  Future<City> getCityByCoords({
    required double lat,
    required double lon,
  }) async {
    try {
      final response = await dio.get<List<dynamic>>(
        'https://api.openweathermap.org/geo/1.0/reverse?lat=$lat&lon=$lon&limit=1&appid=$appId',
      );

      if (response.data == null || response.data!.isEmpty) {
        throw WeatherExeption.cityNotFound();
      } else {
        return City.fromJson(
          response.data!.first as Map<String, Object?>,
        );
      }
    } on DioError catch (e) {
      if (e.type == DioErrorType.connectionError) {
        throw WeatherExeption.noConnection();
      } else {
        throw WeatherExeption.unimplemented();
      }
    } on WeatherExeption catch (_) {
      rethrow;
    } catch (_) {
      throw WeatherExeption.unimplemented();
    }
  }

  @override
  Future<List<City>> getCitiesByName({required String name}) async {
    try {
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
    } on DioError catch (e) {
      if (e.type == DioErrorType.connectionError) {
        throw WeatherExeption.noConnection();
      } else {
        throw WeatherExeption.internetUnimplemented();
      }
    } catch (_) {
      throw WeatherExeption.unimplemented();
    }
  }

  @override
  Future<List<Weather>> getWeathers({required City city}) async {
    try {
      final response = await dio.get<dynamic>(
        'https://api.openweathermap.org/data/2.5/forecast?lat=${city.lat}&lon=${city.lon}&units=metric&appid=$appId',
      );

      if (response.data == null) {
        return [];
      } else {
        final weathers = <Weather>[];
        // ignore: avoid_dynamic_calls
        for (final el in response.data!['list'] as List<dynamic>) {
          weathers.add(
            Weather.fromOpenWeatherMapJson(el as Map<String, Object?>),
          );
        }
        return weathers;
      }
    } on DioError catch (e) {
      if (e.type == DioErrorType.connectionError) {
        throw WeatherExeption.noConnection();
      } else {
        throw WeatherExeption.internetUnimplemented();
      }
    } catch (_) {
      throw WeatherExeption.unimplemented();
    }
  }
}
