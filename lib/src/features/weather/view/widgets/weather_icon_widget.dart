import 'package:flutter/material.dart';
import 'package:weather/src/features/weather/models/weather/weather.dart';
import 'package:weather_icons/weather_icons.dart';

class WeatherIcon extends StatelessWidget {
  const WeatherIcon({
    super.key,
    required this.type,
    required this.size,
  });

  final WeatherType type;
  final double size;

  @override
  Widget build(BuildContext context) {
    late final IconData icon;

    switch (type) {
      case WeatherType.snow:
        icon = WeatherIcons.snow;
        break;
      case WeatherType.clear:
        icon = WeatherIcons.day_sunny;
        break;
      case WeatherType.clouds:
        icon = WeatherIcons.cloud;
        break;
      case WeatherType.drizzle:
        icon = WeatherIcons.raindrop;
        break;
      case WeatherType.rain:
        icon = WeatherIcons.rain;
        break;
      case WeatherType.thunderstorm:
        icon = WeatherIcons.thunderstorm;
        break;
      case WeatherType.atmosphere:
        icon = WeatherIcons.dust;
        break;
    }

    return Icon(
      icon,
      size: size,
    );
  }
}
