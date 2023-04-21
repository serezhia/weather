import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:weather/src/features/weather/data/weather_repository.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart' as concurrency;

import 'package:weather/src/features/weather/models/city/city.dart';
import 'package:weather/src/features/weather/models/weather/weather.dart';

part 'days_weather_bloc.freezed.dart';

@freezed
class DaysWeatherEvent with _$DaysWeatherEvent {
  const factory DaysWeatherEvent.started({
    required double lat,
    required double lon,
  }) = _StartedDaysWeatherEvent;
  const factory DaysWeatherEvent.refresh() = _RefreshDaysWeatherEvent;
}

@freezed
class DaysWeatherState with _$DaysWeatherState {
  const factory DaysWeatherState({
    required Weather? coldWeather,
    required List<Weather> weathers,
    required City? city,
    required bool isLoading,
    required bool isRefresh,
  }) = _DaysWeatherState;
}

class DaysWeatherBloc extends Bloc<DaysWeatherEvent, DaysWeatherState> {
  DaysWeatherBloc(this.weatherRepository)
      : super(
          const DaysWeatherState(
            coldWeather: null,
            weathers: [],
            city: null,
            isLoading: true,
            isRefresh: false,
          ),
        ) {
    on<_StartedDaysWeatherEvent>((event, emit) async {
      emit(state.copyWith(isLoading: true));

      /// Получение города
      final city = await weatherRepository.getCityByCoords(
        lat: event.lat,
        lon: event.lon,
      );
      emit(
        state.copyWith(city: city),
      );

      ///Получаем погоду
      final weathers =
          await weatherRepository.getWeathersByThreeDay(city: city!);
      emit(
        state.copyWith(weathers: weathers),
      );

      ///Вычисляем самый холодный час
      final coldWeather =
          weathers.reduce((curr, next) => curr.temp < next.temp ? curr : next);
      emit(
        state.copyWith(coldWeather: coldWeather, isLoading: false),
      );
    });
    on<_RefreshDaysWeatherEvent>(
      (event, emit) async {
        emit(state.copyWith(isRefresh: true));

        ///Получаем погоду
        final weathers =
            await weatherRepository.getWeathersByThreeDay(city: state.city!);
        emit(
          state.copyWith(weathers: weathers),
        );

        ///Вычисляем самый холодный час
        final coldWeather = weathers
            .reduce((curr, next) => curr.temp < next.temp ? curr : next);

        emit(
          state.copyWith(
            coldWeather: coldWeather,
            isLoading: false,
            isRefresh: false,
          ),
        );
      },
      transformer: concurrency.concurrent(),
    );
  }
  final IWeatherRepository weatherRepository;
}
