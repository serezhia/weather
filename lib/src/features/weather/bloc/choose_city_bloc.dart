import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart' as concurrency;
import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:weather/src/features/weather/models/city/city.dart';

part 'choose_city_event.dart';
part 'choose_city_state.dart';
part 'choose_city_bloc.freezed.dart';

class ChooseCityBloc extends Bloc<ChooseCityBlocEvent, ChooseCityBlocState> {
  ChooseCityBloc()
      : super(
          const ChooseCityBlocState(
            currentSug: [],
            pickedCity: null,
          ),
        ) {
    on<_ChangeSuggChooseCityBlocEvent>(
      (event, emit) async {
        print(event.name);
        if (event.name.isEmpty) {
          return;
        }
        await Future<void>.delayed(const Duration(milliseconds: 500));
        final response = await dio.get<List<dynamic>>(
          'http://api.openweathermap.org/geo/1.0/direct?q=${event.name}&limit=10&appid=1d545015af9e284d31b0f5e3e74e7413',
        );

        if (response.data == null || response.data!.isEmpty) {
          emit(state.copyWith(currentSug: []));
        } else {
          print(response.data);
          final city = <City>[];
          for (final el in response.data!) {
            city.add(City.fromJson(el as Map<String, Object?>));
          }
          emit(state.copyWith(currentSug: city));
        }
      },
      transformer: concurrency.concurrent(),
    );
    on<_PickCityChooseCityBlocEvent>((event, emit) {
      emit(state.copyWith(pickedCity: event.city));
    });
  }
  final dio = Dio();
}
