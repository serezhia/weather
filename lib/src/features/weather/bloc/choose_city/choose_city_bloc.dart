import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart' as concurrency;
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:weather/src/features/weather/data/weather_repository.dart';
import 'package:weather/src/features/weather/models/city/city.dart';

part 'choose_city_bloc.freezed.dart';

@freezed
class ChooseCityBlocEvent with _$ChooseCityBlocEvent {
  const factory ChooseCityBlocEvent.changeSugg(String name) =
      _ChangeSuggChooseCityBlocEvent;

  const factory ChooseCityBlocEvent.pickCity(City city) =
      _PickCityChooseCityBlocEvent;
}

@freezed
class ChooseCityBlocState with _$ChooseCityBlocState {
  const factory ChooseCityBlocState({
    /// Города при текущем поиске
    required List<City> currentSug,

    /// Выбранный город
    required City? pickedCity,
  }) = _ChooseCityBlocState;
}

/// Блок отвечающий за поиск и выбор города
class ChooseCityBloc extends Bloc<ChooseCityBlocEvent, ChooseCityBlocState> {
  ChooseCityBloc(this.weatherRepository)
      : super(
          const ChooseCityBlocState(
            currentSug: [],
            pickedCity: null,
          ),
        ) {
    on<_ChangeSuggChooseCityBlocEvent>(
      (event, emit) async {
        if (event.name.isEmpty) {
          return;
        }

        final cities =
            await weatherRepository.getCitiesByName(name: event.name);

        emit(state.copyWith(currentSug: cities));
      },

      /// Отброс предыдущих эвентов чтобы избежать долгого поиска
      transformer: concurrency.concurrent(),
    );
    on<_PickCityChooseCityBlocEvent>((event, emit) {
      emit(state.copyWith(pickedCity: event.city));
    });
  }

  final IWeatherRepository weatherRepository;
}
