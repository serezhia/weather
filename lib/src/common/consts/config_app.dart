/// Ссылка на сервер Sentry
const sentryDNS = '';

/// Версия приложения (используется для Sentry)
const appVersion = '0.0.0';

/// API ключ от OpenWeatherMap
const openWeatherApiKey = String.fromEnvironment(
  'OPEN_WEATHER_API_KEY',
  defaultValue: '1d545015af9e284d31b0f5e3e74e7413',
);
