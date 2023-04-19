import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:weather/src/features/l10n/l10n.dart';
import 'package:weather/src/features/weather/bloc/choose_city_bloc.dart';
import 'package:weather/src/features/weather/models/city/city.dart';

class ChooseCityScreen extends StatefulWidget {
  const ChooseCityScreen({super.key});

  @override
  State<ChooseCityScreen> createState() => _ChooseCityScreenState();
}

class _ChooseCityScreenState extends State<ChooseCityScreen> {
  final textController = TextEditingController();

  late ChooseCityBloc bloc;

  @override
  void initState() {
    bloc = ChooseCityBloc();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.l10n.appName),
      ),
      body: SafeArea(
        maintainBottomViewPadding: true,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: BlocProvider.value(
            value: bloc,
            child: BlocBuilder<ChooseCityBloc, ChooseCityBlocState>(
              bloc: bloc,
              builder: (context, state) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          const Text(
                            'Что за город ?',
                            style: TextStyle(
                              fontSize: 50,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextFormField(
                            controller: textController,
                            onChanged: (value) {
                              bloc.add(ChooseCityBlocEvent.changeSugg(value));
                            },
                          ),
                          Expanded(
                            child: ListView.builder(
                              itemCount: state.currentSug.length,
                              itemBuilder: (context, index) => CityItemWidget(
                                city: state.currentSug[index],
                                isPicked:
                                    state.pickedCity == state.currentSug[index],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 41,
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: state.pickedCity == null ? null : () {},
                        child: const Text('Далее'),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

class CityItemWidget extends StatelessWidget {
  const CityItemWidget({
    super.key,
    required this.city,
    required this.isPicked,
  });

  final City city;
  final bool isPicked;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context
          .read<ChooseCityBloc>()
          .add(ChooseCityBlocEvent.pickCity(city)),
      child: Container(
        color: isPicked ? Colors.black.withOpacity(0.2) : null,
        height: 40,
        margin: const EdgeInsets.all(8),
        child: Text(
          '${city.country} ${city.name} ${city.localNames?[context.l10n.localeName] ?? ''}',
        ),
      ),
    );
  }
}
