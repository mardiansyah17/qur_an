import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qur_an/src/core/widgets/app_loading.dart';
import 'package:qur_an/src/core/widgets/app_search_widget.dart';
import 'package:qur_an/src/core/widgets/main_screen.dart';
import 'package:qur_an/src/features/prayer_time/presentation/blocs/city_bloc/city_bloc.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SelectCity extends StatefulWidget {
  const SelectCity({super.key});
  @override
  State<SelectCity> createState() => _SelectCityState();
}

class _SelectCityState extends State<SelectCity> {
  final TextEditingController controller = TextEditingController();

  @override
  void initState() {
    context.read<CityBloc>().add(LoadedCities());
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          surfaceTintColor: Colors.transparent,
          title: AppSearchWidget(
            onChanged: (value) =>
                context.read<CityBloc>().add(SearchCityByQuery(value)),
            title: "Cari Kota",
          ),
        ),
        body: BlocBuilder<CityBloc, CityState>(
          builder: (context, state) {
            if (state is CityLoading) {
              return const AppLoading();
            } else if (state is CityLoaded) {
              return ListView.builder(
                itemCount: state.cities.length,
                itemBuilder: (context, index) {
                  final city = state.cities[index];
                  return ListTile(
                    title: Text(city.name),
                    onTap: () async {
                      final SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      prefs.setString('cityId', city.id);
                      prefs.setString('cityName', city.name);
                      if (context.mounted) {
                        Navigator.push(
                            context,
                            PageTransition(
                                type: PageTransitionType.leftToRight,
                                duration: const Duration(milliseconds: 300),
                                child: const MainScreen(
                                  index: 0,
                                )));
                      }
                    },
                  );
                },
              );
            } else {
              return const Center(
                child: Text("Error"),
              );
            }
          },
        ));
  }
}
