import 'package:flutter/material.dart';
import 'package:weather/src/app.dart';

/// Запуск приложения как web
Future<void> runApp() async {
  // Перехватывать ошибки флатера в релизе
  final sourceFlutterError = FlutterError.onError;
  FlutterError.onError = (details) {
    sourceFlutterError?.call(details);
  };

  // Инициализировать и запустить приложение
  await App.initializeAndRun();
}
