part of 'choose_city_bloc.dart';

@freezed
class ChooseCityBlocState with _$ChooseCityBlocState {
  const factory ChooseCityBlocState({
    required List<City> currentSug,
    required City? pickedCity,
  }) = _ChooseCityBlocState;
}
