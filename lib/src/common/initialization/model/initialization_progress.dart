import 'package:dio/dio.dart';
import 'package:weather/src/common/appdata/model/app_metadata.dart';
import 'package:weather/src/common/initialization/model/repository_storage.dart';
import 'package:weather/src/features/weather/data/weather_repository.dart';

/// Содержит все нужные репозитории/объекты на момент инициализации
class InitializationProgress {
  const InitializationProgress({
    this.appMetadata,
    this.dio,
    this.weatherRepository,
  });

  /// Содержит все информацию об устройстве
  final AppMetadata? appMetadata;

  /// Для сетевых взаимодействий
  final Dio? dio;
  final IWeatherRepository? weatherRepository;

  InitializationProgress copyWith({
    AppMetadata? appMetadata,
    IWeatherRepository? weatherRepository,
    Dio? dio,
  }) =>
      InitializationProgress(
        appMetadata: appMetadata ?? this.appMetadata,
        weatherRepository: weatherRepository ?? this.weatherRepository,
        dio: dio ?? this.dio,
      );

  /// Получение только нужных репозиториев без объектов
  /// (например Dio, sharedPrefs)
  RepositoryStorage getResult() => RepositoryStorage(
        appMetadata: appMetadata!,
        weatherRepository: weatherRepository!,
      );
}
