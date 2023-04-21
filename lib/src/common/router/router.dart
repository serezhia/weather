import 'package:go_router/go_router.dart';
import 'package:weather/src/features/weather/view/choose_city_screen.dart';
import 'package:weather/src/features/weather/view/days_weather_city_screen.dart';
import 'package:weather/src/features/weather/view/weather_city_screen.dart';

class MainRouter {
  static const String choose = '/choose';
  static const String weather = '/weather';
  static const String threeDays = '/three';

  static GoRouter get goRouter => GoRouter(
        debugLogDiagnostics: true,
        initialLocation: threeDays,
        routes: [
          GoRoute(
            path: choose,
            builder: (context, state) => const ChooseCityScreen(),
          ),
          GoRoute(
            path: weather,
            builder: (context, state) => WeatherCityScreen(
              lat: double.parse(state.queryParams['lat'] ?? '51.5085'),
              lon: double.parse(state.queryParams['lon'] ?? '-0.1257'),
            ),
          ),
          GoRoute(
            path: threeDays,
            builder: (context, state) => DaysWeatherScreen(
              lat: double.parse(state.queryParams['lat'] ?? '51.5085'),
              lon: double.parse(state.queryParams['lon'] ?? '-0.1257'),
            ),
          ),
        ],
      );
}
