// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;

import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:weather/src/app.dart';

/// Запуск для веба
Future<void> runApp() {
  setUrlStrategy(PathUrlStrategy());

  return App.initializeAndRun(
    /// Удаление иконки загруки
    onSuccessfulInitialization: (_) {
      html.document
          .getElementsByClassName('loading')
          .toList(growable: false)
          .forEach((element) => element.remove());
    },
  );
}
