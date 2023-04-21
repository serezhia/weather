import 'package:weather/src/common/appdata/model/app_metadata.dart';
import 'package:weather/src/features/weather/data/weather_repository.dart';

class RepositoryStorage {
  RepositoryStorage({
    required this.appMetadata,
    required this.weatherRepository,
  });

  final AppMetadata appMetadata;
  final IWeatherRepository weatherRepository;
}
