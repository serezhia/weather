part of 'choose_city_bloc.dart';

@freezed
class ChooseCityBlocEvent with _$ChooseCityBlocEvent {
  const factory ChooseCityBlocEvent.init() = _InitChooseCityBlocEvent;
  const factory ChooseCityBlocEvent.changeSugg(String name) =
      _ChangeSuggChooseCityBlocEvent;
  const factory ChooseCityBlocEvent.pickCity(City city) =
      _PickCityChooseCityBlocEvent;
}
