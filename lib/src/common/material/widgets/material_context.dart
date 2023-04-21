import 'package:flutter/material.dart';

import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:weather/src/common/router/router.dart';
import 'package:weather/src/common/theme/light_theme.dart';
import 'package:weather/src/features/l10n/l10n.dart';

/// Виджет содержащий в себе роут, локализацию и тему
@immutable
class AppMaterialContext extends StatefulWidget {
  const AppMaterialContext({
    super.key,
  });

  @override
  State<AppMaterialContext> createState() => _AppMaterialContextState();
}

class _AppMaterialContextState extends State<AppMaterialContext> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: lightTheme,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en'), // English
        Locale('ru'), // Russian
      ],
      debugShowCheckedModeBanner: false,
      routerConfig: MainRouter.goRouter,
    );
  }
}
