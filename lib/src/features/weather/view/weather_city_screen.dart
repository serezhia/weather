import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:weather/src/common/initialization/widgets/repository_scope.dart';
import 'package:weather/src/common/router/router.dart';
import 'package:weather/src/features/l10n/l10n.dart';
import 'package:weather/src/features/weather/bloc/weather_city/weather_city_bloc.dart';
import 'package:weather/src/features/weather/models/weather/weather.dart';
import 'package:weather/src/features/weather/view/widgets/error_widget.dart';
import 'package:weather/src/features/weather/view/widgets/weather_icon_widget.dart';
import 'package:weather_icons/weather_icons.dart';

class WeatherCityScreen extends StatefulWidget {
  const WeatherCityScreen({
    super.key,
    required this.lat,
    required this.lon,
  });

  final double lat;
  final double lon;

  @override
  State<WeatherCityScreen> createState() => _WeatherCityScreenState();
}

class _WeatherCityScreenState extends State<WeatherCityScreen> {
  late final WeatherCityBloc weatherCityBloc;
  @override
  void initState() {
    weatherCityBloc =
        WeatherCityBloc(RepositoryScope.of(context).weatherRepository)
          ..add(
            WeatherCityEvent.init(
              lat: widget.lat,
              lon: widget.lon,
            ),
          );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: BackButton(
          onPressed: () {
            context.go(MainRouter.choose);
          },
        ),
        title: BlocBuilder<WeatherCityBloc, WeatherCityState>(
          bloc: weatherCityBloc,
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
        actions: [
          IconButton(
            icon: const Icon(Icons.more_horiz_outlined),
            onPressed: () {
              context.push(
                '${MainRouter.threeDays}?lat=${widget.lat}&lon=${widget.lon}',
              );
            },
          )
        ],
      ),
      body: BlocBuilder<WeatherCityBloc, WeatherCityState>(
        bloc: weatherCityBloc,
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state.codeError != null) {
            return ErrorWeatherWidget(
              code: state.codeError!,
              onPressed: () {
                weatherCityBloc.add(
                  WeatherCityEvent.init(
                    lat: widget.lat,
                    lon: widget.lon,
                  ),
                );
              },
            );
          } else {
            return RefreshIndicator(
              onRefresh: () async {
                weatherCityBloc.add(const WeatherCityEvent.refresh());
                await weatherCityBloc.stream
                    .firstWhere((state) => !state.isRefresh);
                return;
              },
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 120,
                          width: 120,
                          child: WeatherIcon(
                            type: state.weathers.first.type,
                            size: 80,
                          ),
                        ),
                        Text(
                          '${state.weathers.first.temp}°',
                          style: const TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.w700,
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 30),
                    Text(
                      DateFormat.MMMEd(context.l10n.localeName)
                          .format(DateTime.now()),
                      style: const TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const SizedBox(
                              height: 50,
                              width: 50,
                              child: Icon(
                                WeatherIcons.humidity,
                                size: 40,
                              ),
                            ),
                            Text(
                              '${state.weathers.first.humidity}%',
                              style: const TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.w700,
                              ),
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const SizedBox(
                              height: 50,
                              width: 50,
                              child: Icon(
                                WeatherIcons.wind,
                                size: 40,
                              ),
                            ),
                            Text(
                              '${state.weathers.first.windSpeed.floor()} м/c',
                              style: const TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.w700,
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    const SizedBox(
                      child: Text(
                        'По часам',
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      height: 300,
                      child: ListView.builder(
                        itemCount: state.weathers.length - 1,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) => _WeatherPerHourItem(
                          weather: state.weathers[index + 1],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }
}

class _WeatherPerHourItem extends StatelessWidget {
  const _WeatherPerHourItem({required this.weather});

  final Weather weather;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100,
      child: Column(
        children: [
          Text(
            DateFormat.Hm(context.l10n.localeName)
                .format(weather.date.toLocal()),
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 60,
            width: 60,
            child: WeatherIcon(
              type: weather.type,
              size: 40,
            ),
          ),
          Text(
            '${weather.temp.floor()}°',
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
