import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qur_an/src/core/theme/app_pallete.dart';
import 'package:qur_an/src/core/widgets/app_button.dart';
import 'package:qur_an/src/core/widgets/app_loading.dart';
import 'package:qur_an/src/features/prayer_time/presentation/blocs/prayer_time_bloc/prayer_time_bloc.dart';
import 'package:qur_an/src/features/prayer_time/presentation/pages/no_location_screen.dart';
import 'package:qur_an/src/features/prayer_time/presentation/widgets/location_and_date_widget.dart';
import 'package:qur_an/src/features/prayer_time/presentation/widgets/prayer_time_count_down_widget.dart';
import 'package:qur_an/src/features/prayer_time/presentation/widgets/prayer_time_list_widget.dart';
import 'package:intl/intl.dart';

class PrayerTimeScreen extends StatefulWidget {
  const PrayerTimeScreen({super.key});

  @override
  State<PrayerTimeScreen> createState() => _PrayerTimeScreenState();
}

class _PrayerTimeScreenState extends State<PrayerTimeScreen> {
  final String date = DateFormat("yyyy-MM-dd").format(DateTime.now());

  @override
  void initState() {
    context.read<PrayerTimeBloc>().add(LoadPrayerTime(date: date));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.expand(
        child: BlocBuilder<PrayerTimeBloc, PrayerTimeState>(
          builder: (context, state) {
            if (state is PrayerTimeLoading) {
              return const AppLoading();
            }
            if (state is LocationIsNotExist) {
              return const NoLocationScreen();
            }

            if (state is InternetIsNotConnected) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Tidak ada koneksi internet"),
                    const SizedBox(height: 10),
                    AppButton(
                      text: "Coba lagi",
                      onPressed: () {
                        context
                            .read<PrayerTimeBloc>()
                            .add(LoadPrayerTime(date: date));
                      },
                    ),
                  ],
                ),
              );
            }

            if (state is PrayerTimeLoaded) {
              return Stack(
                children: [
                  Container(
                    height: 350,
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          AppPallete.primary,
                          AppPallete.second,
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                  ),
                  SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          LocationAndDateWidget(
                            dateTime: state.date,
                            city: state.city,
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          PrayerTimeCountDownWidget(
                            nextTime: state.nextTime,
                            prayerTime: state.prayerTime!,
                          ),
                        ],
                      ),
                    ),
                  ),
                  PrayerTimeListWidget(
                    prayerTime: state.prayerTime!,
                    nextTime: state.nextTime,
                  )
                ],
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
