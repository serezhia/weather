import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart' as concurrency;
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:weather/src/features/weather/data/weather_repository.dart';
import 'package:weather/src/features/weather/models/city/city.dart';
import 'package:weather/src/features/weather/models/weather/weather.dart';

part 'weather_city_bloc.freezed.dart';

@freezed
class WeatherCityEvent with _$WeatherCityEvent {
  const factory WeatherCityEvent.init({
    required double lat,
    required double lon,
  }) = _InitWeatherCityEvent;
  const factory WeatherCityEvent.refresh() = _RefreshWeatherCityEvent;
}

@freezed
class WeatherCityState with _$WeatherCityState {
  const factory WeatherCityState({
    /// Текущий город
    required City? city,

    /// Текущие часы погоды
    required List<Weather> weathers,
    required bool isLoading,
    required bool isRefresh,
    required String? error,
  }) = _WeatherCityBlocState;
}

class WeatherCityBloc extends Bloc<WeatherCityEvent, WeatherCityState> {
  WeatherCityBloc(
    this.weatherRepository,
  ) : super(
          const WeatherCityState(
            city: null,
            weathers: [],
            error: null,
            isLoading: true,
            isRefresh: false,
          ),
        ) {
    on<_InitWeatherCityEvent>(
      (event, emit) async {
        emit(state.copyWith(isLoading: true));

        /// Получение города
        final city = await weatherRepository.getCityByCoords(
          lat: event.lat,
          lon: event.lon,
        );
        emit(
          state.copyWith(
            city: city,
          ),
        );

        /// Получение погоды

        final weathers = await weatherRepository.getWeathers(city: city!);
        emit(
          state.copyWith(
            weathers: weathers,
            isLoading: false,
          ),
        );
      },
      transformer: concurrency.concurrent(),
    );
    on<_RefreshWeatherCityEvent>(
      (event, emit) async {
        if (state.isLoading) {
          return;
        }
        emit(state.copyWith(isRefresh: true));

        /// Получение погоды
        final weathers = await weatherRepository.getWeathers(city: state.city!);

        emit(
          state.copyWith(
            weathers: weathers,
            isRefresh: false,
          ),
        );
      },

      /// Чтобы при повторном рефреше дропись все остальные евенты
      transformer: concurrency.concurrent(),
    );
  }
  final IWeatherRepository weatherRepository;
}
