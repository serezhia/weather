import 'package:weather/src/common/appdata/model/app_metadata.dart';
import 'package:weather/src/common/initialization/model/repository_storage.dart';

class InitializationProgress {
  const InitializationProgress({
    this.appMetadata,
  });
  final AppMetadata? appMetadata;

  InitializationProgress copyWith({
    AppMetadata? appMetadata,
  }) =>
      InitializationProgress(
        appMetadata: appMetadata ?? this.appMetadata,
      );

  RepositoryStorage getResult() => RepositoryStorage(
        appMetadata: appMetadata!,
      );
}
