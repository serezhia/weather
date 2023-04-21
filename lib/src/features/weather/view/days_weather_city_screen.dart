// ignore_for_file: lines_longer_than_80_chars

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:weather/src/common/initialization/widgets/repository_scope.dart';
import 'package:weather/src/common/router/router.dart';
import 'package:weather/src/features/l10n/l10n.dart';
import 'package:weather/src/features/weather/bloc/three_days_weather_city/bloc/days_weather_bloc.dart';

import 'package:weather/src/features/weather/models/weather/weather.dart';
import 'package:weather/src/features/weather/view/widgets/error_widget.dart';
import 'package:weather/src/features/weather/view/widgets/weather_icon_widget.dart';
import 'package:weather_icons/weather_icons.dart';

class DaysWeatherScreen extends StatefulWidget {
  const DaysWeatherScreen({
    super.key,
    required this.lat,
    required this.lon,
  });

  final double lat;
  final double lon;
  @override
  State<DaysWeatherScreen> createState() => _DaysWeatherScreenState();
}

class _DaysWeatherScreenState extends State<DaysWeatherScreen> {
  late final DaysWeatherBloc bloc;

  @override
  void initState() {
    bloc = DaysWeatherBloc(
      RepositoryScope.of(context).weatherRepository,
    )..add(
        DaysWeatherEvent.started(
          lat: widget.lat,
          lon: widget.lon,
        ),
      );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        leading: BackButton(
          onPressed: () {
            if (GoRouter.of(context).canPop()) {
              GoRouter.of(context).pop();
            } else {
              context.go(
                '${MainRouter.weather}?lat=${widget.lat}&lon=${widget.lon}',
              );
            }
          },
        ),

        /// Динамический заголовок в зависимости от состояния загрузки
        title: BlocBuilder<DaysWeatherBloc, DaysWeatherState>(
          bloc: bloc,
          builder: (context, state) {
            if (state.city == null) {
              return Text(context.l10n.appName);
            } else {
              late final String name;

              if (state.city?.localNames?[context.l10n.localeName] is String) {
                name =
                    // ignore: cast_nullable_to_non_nullable
                    state.city?.localNames?[context.l10n.localeName] as String;
              } else {
                name = state.city!.name;
              }
              return Text(name);
            }
          },
        ),
      ),
      body: BlocProvider.value(
        value: bloc,
        child: BlocBuilder<DaysWeatherBloc, DaysWeatherState>(
          bloc: bloc,
          builder: (context, state) {
            if (state.isLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state.codeError != null) {
              return ErrorWeatherWidget(
                code: state.codeError!,
                onPressed: () {
                  bloc.add(
                    DaysWeatherEvent.started(
                      lat: widget.lat,
                      lon: widget.lon,
                    ),
                  );
                },
              );
            } else {
              return RefreshIndicator(
                onRefresh: () async {
                  bloc.add(const DaysWeatherEvent.refresh());
                  await bloc.stream.firstWhere((state) => !state.isRefresh);
                  return;
                },
                child: ListView.builder(
                  itemCount: state.coldWeather != null
                      ? state.weathers.length + 1
                      : state.weathers.length,

                  /// Условия появления заголовка/даты у итема
                  itemBuilder: (context, index) {
                    if (state.coldWeather != null) {
                      if (index == 0) {
                        return _WeatherDaysItem(
                          weather: state.coldWeather!,
                          title:
                              '${context.l10n.coldestHourTitle} ${DateFormat.MMMEd(context.l10n.localeName).format(state.coldWeather!.date)}',
                        );
                      } else if (index == 1 ||
                          (state.weathers[index - 2].date.day !=
                              state.weathers[index - 1].date.day)) {
                        return _WeatherDaysItem(
                          weather: state.weathers[index - 1],
                          title: DateFormat.MMMEd(context.l10n.localeName)
                              .format(state.weathers[index - 1].date),
                        );
                      } else {
                        return _WeatherDaysItem(
                          weather: state.weathers[index - 1],
                          title: null,
                        );
                      }
                    } else {
                      if (index == 0 ||
                          (state.weathers[index - 1].date.day !=
                              state.weathers[index].date.day)) {
                        return _WeatherDaysItem(
                          weather: state.weathers[index],
                          title: DateFormat.MMMEd(context.l10n.localeName)
                              .format(state.weathers[index].date),
                        );
                      } else {
                        return _WeatherDaysItem(
                          weather: state.weathers[index],
                          title: null,
                        );
                      }
                    }
                  },
                ),
              );
            }
          },
        ),
      ),
    );
  }
}

class _WeatherDaysItem extends StatelessWidget {
  const _WeatherDaysItem({required this.weather, required this.title});

  final String? title;
  final Weather weather;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (title != null)
            Text(
              title!,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w500,
              ),
            ),
          SizedBox(
            height: 80,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 60,
                  child: Text(
                    DateFormat.Hm(context.l10n.localeName)
                        .format(weather.date.toLocal()),
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Expanded(
                  child: Row(
                    children: [
                      SizedBox(
                        height: 50,
                        width: 50,
                        child: WeatherIcon(type: weather.type, size: 30),
                      ),
                      Text(
                        '${weather.temp.floor()}°',
                        style: const TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    children: [
                      const SizedBox(
                        height: 50,
                        width: 50,
                        child: Icon(
                          WeatherIcons.humidity,
                          size: 30,
                        ),
                      ),
                      Text(
                        '${weather.humidity}%',
                        style: const TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    children: [
                      const SizedBox(
                        height: 50,
                        width: 50,
                        child: Icon(
                          WeatherIcons.wind,
                          size: 30,
                        ),
                      ),
                      Text(
                        '${weather.windSpeed.floor()} ${context.l10n.metersAndSeconds}',
                        style: const TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
