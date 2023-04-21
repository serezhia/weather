import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:l/l.dart';

/// Для логирвоания (ошибки, изменения) всех блоков ниже по дереву
class AppBlocObserver extends BlocObserver {
  const AppBlocObserver();

  @override
  void onChange(BlocBase<dynamic> bloc, Change<dynamic> change) {
    super.onChange(bloc, change);
    l.v6('onChange(${bloc.runtimeType}, $change)');
  }

  @override
  void onError(BlocBase<dynamic> bloc, Object error, StackTrace stackTrace) {
    l.e('onError(${bloc.runtimeType}, $error, $stackTrace)');
    super.onError(bloc, error, stackTrace);
  }
}

Future<void> bootstrap(void Function() builder) async {
  FlutterError.onError = (details) {
    l.e(details.exceptionAsString(), details.stack);
  };

  Bloc.observer = const AppBlocObserver();

  await runZonedGuarded(
    () async => builder(),
    (error, stackTrace) => l.e(error.toString(), stackTrace),
  );
}
