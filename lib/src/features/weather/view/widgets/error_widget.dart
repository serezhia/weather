import 'package:flutter/material.dart';

class ErrorWeatherWidget extends StatelessWidget {
  const ErrorWeatherWidget({
    super.key,
    required this.onPressed,
    required this.code,
  });

  final void Function() onPressed;
  final int code;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Отсуствет интернет соединение'),
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
