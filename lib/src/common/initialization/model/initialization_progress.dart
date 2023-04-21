import 'package:dio/dio.dart';
import 'package:weather/src/common/appdata/model/app_metadata.dart';
import 'package:weather/src/common/initialization/model/repository_storage.dart';
import 'package:weather/src/features/weather/data/weather_repository.dart';

class InitializationProgress {
  const InitializationProgress({
    this.appMetadata,
    this.dio,
    this.weatherRepository,
  });
  final AppMetadata? appMetadata;
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

  RepositoryStorage getResult() => RepositoryStorage(
        appMetadata: appMetadata!,
        weatherRepository: weatherRepository!,
      );
}
