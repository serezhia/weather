import 'package:flutter/material.dart';
import 'package:weather/src/features/l10n/l10n.dart';

/// Виджет с отображением переведенной ошибки и кнопки с действием
class ErrorWeatherWidget extends StatelessWidget {
  const ErrorWeatherWidget({
    super.key,
    required this.onPressed,
    required this.code,
  });

  /// Действие
  final void Function() onPressed;

  /// Код ошибки
  final int code;

  @override
  Widget build(BuildContext context) {
    String getTranslatedError(int code) {
      switch (code) {
        case 0:
          return context.l10n.error0;

        case 4001:
          return context.l10n.error4001;
        case 4002:
          return context.l10n.error4002;
        case 999:
          return context.l10n.error999;
        case 9999:
          return context.l10n.error9999;
        default:
          return context.l10n.errorUnimplemented;
      }
    }

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            getTranslatedError(code),
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),
          ElevatedButton(
            onPressed: onPressed,
            child: const Text(
              'Повторить',
            ),
          )
        ],
      ),
    );
  }
}
