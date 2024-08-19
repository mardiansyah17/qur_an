import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qur_an/init_depedencies.dart';
import 'package:qur_an/src/core/theme/app_theme.dart';
import 'package:qur_an/src/core/widgets/main_screen.dart';
import 'package:qur_an/src/features/prayer_time/presentation/blocs/city_bloc/city_bloc.dart';
import 'package:qur_an/src/features/prayer_time/presentation/blocs/prayer_time_bloc/prayer_time_bloc.dart';
import 'package:qur_an/src/features/quran/presentation/blocs/ayat_bloc/ayat_bloc.dart';
import 'package:qur_an/src/features/quran/presentation/blocs/surah_bloc/surah_bloc.dart';
import 'package:qur_an/src/features/quran/presentation/pages/detail_surah_screen.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDepedencies();
  initializeDateFormatting('id');
  Intl.defaultLocale = 'id_ID';
  runApp(MultiBlocProvider(providers: [
    BlocProvider(create: (_) => sl<PrayerTimeBloc>()),
    BlocProvider(create: (_) => sl<CityBloc>()),
    BlocProvider(create: (_) => sl<SurahBloc>()),
    BlocProvider(create: (_) => sl<AyatBloc>()),
  ], child: const MainApp()));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme.lightTheme,
      debugShowCheckedModeBanner: false,
      home: const MainScreen(),
    );
  }
}
