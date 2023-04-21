import 'package:weather/src/common/appdata/model/app_metadata.dart';
import 'package:weather/src/features/weather/data/weather_repository.dart';

/// Класс отвечающий за все нужные репозитории в приложении
/// При добавлении новой фичи нужно добавить сюда, в InitializationProgress,
/// в InitializationProgressStatus все необходимые компоненты
///  + этап инициализации

class RepositoryStorage {
  RepositoryStorage({
    required this.appMetadata,
    required this.weatherRepository,
  });

  final AppMetadata appMetadata;
  final IWeatherRepository weatherRepository;
}
