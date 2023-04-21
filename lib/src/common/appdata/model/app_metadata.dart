/// Содержит всю необходимую информацию для отладки багов и крашей приложений
/// Используется для отправки в Sentry
class AppMetadata {
  const AppMetadata({
    required this.isWeb,
    required this.isRelease,
    required this.appVersion,
    required this.appPackageName,
    required this.appName,
    required this.operatingSystem,
    required this.processorsCount,
    required this.appLaunchedTimestamp,
    required this.locale,
    required this.deviceRepresentation,
    required this.deviceLogicalSideMin,
    required this.deviceLogicalSideMax,
  });

  /// Тип запуска
  final bool isWeb;

  /// Тип запуска
  final bool isRelease;

  /// Версия приложения
  final String appVersion;

  /// Время запуска
  final int appLaunchedTimestamp;

  final String appPackageName;
  final String appName;
  final String operatingSystem;
  final int processorsCount;

  /// Локаль в системе при запуске приложения
  final String locale;

  /// Тип устройства
  final String deviceRepresentation;

  /// Минимальное количество логических пикселей по ширине/высоте
  final num deviceLogicalSideMin;

  /// Максимальное количество логических пикселей по ширине/высоте
  final num deviceLogicalSideMax;

  Map<String, String> toHeaders() => <String, String>{
        'Mt-Is-Web': isWeb ? 'true' : 'false',
        'Mt-Is-Release': isRelease ? 'true' : 'false',
        'Mt-App-Version': appVersion,
        'Mt-App-Package-Name': appPackageName,
        'Mt-App-Name': appName,
        'Mt-Operating-System': operatingSystem,
        'Mt-Processors-Count': processorsCount.toString(),
        'Mt-App-Launched-Timestamp': appLaunchedTimestamp.toString(),
        'Mt-Locale': locale,
        'Mt-Device-Representation': deviceRepresentation,
        'Mt-Device-Logical-Side-Min': deviceLogicalSideMin.toString(),
        'Mt-Device-Logical-Side-Max': deviceLogicalSideMax.toString(),
      };
}
