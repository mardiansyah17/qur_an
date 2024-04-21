import 'package:get/get.dart';
import 'package:qur_an/screens/detail_surah.dart';
import 'package:qur_an/screens/home.dart';
import 'package:qur_an/screens/jadwal_sholat.dart';
import 'package:qur_an/widgets/tab_wraper.dart';

appRoutes() => [
      GetPage(name: '/', page: () => TabWraper()),
      GetPage(name: '/home', page: () => Home()),
      GetPage(
          name: '/detail-surah',
          page: () => DetailSurah(),
          transition: Transition.rightToLeft),
      GetPage(name: '/jadwal-sholat', page: () => JadwalSholat()),
    ];
