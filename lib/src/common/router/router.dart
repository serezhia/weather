import 'package:go_router/go_router.dart';
import 'package:weather/src/features/weather/view/choose_city_screen.dart';

class MainRouter {
  GoRouter get goRouter => GoRouter(
        debugLogDiagnostics: true,
        initialLocation: '/choosecity',
        routes: [
          GoRoute(
            path: '/choosecity',
            builder: (context, state) => const ChooseCityScreen(),
          ),
        ],
      );
}
