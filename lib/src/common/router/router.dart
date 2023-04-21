import 'package:go_router/go_router.dart';
import 'package:weather/src/features/weather/view/choose_city_screen.dart';
import 'package:weather/src/features/weather/view/days_weather_city_screen.dart';
import 'package:weather/src/features/weather/view/weather_city_screen.dart';

/// Главный роутер
class MainRouter {
  static const String choose = '/choose';
  static const String weather = '/weather';
  static const String threeDays = '/three';

  static GoRouter get goRouter => GoRouter(
        debugLogDiagnostics: true,
        initialLocation: choose,
        routes: [
          /// Страница с выбором города
          GoRoute(
            path: choose,
            builder: (context, state) => const ChooseCityScreen(),
          ),

          /// Страница с текущей и почасовой погодой за сегодня
          GoRoute(
            path: weather,
            builder: (context, state) => WeatherCityScreen(
              lat: double.parse(state.queryParams['lat']!),
              lon: double.parse(state.queryParams['lon']!),
            ),
          ),

          /// Страница с погодой на 5 дней с промежутком в 3 часа
          GoRoute(
            path: threeDays,
            builder: (context, state) => DaysWeatherScreen(
              lat: double.parse(state.queryParams['lat']!),
              lon: double.parse(state.queryParams['lon']!),
            ),
          ),
        ],
        redirect: (context, state) {
          /// При переходе без долготы и широты пересылать на выбор города
          if ((state.path == threeDays || state.path == weather) &&
              (state.queryParams['lat']! is double ||
                  state.queryParams['lon']! is double)) {
            return choose;
          } else {
            return null;
          }
        },
      );
}
