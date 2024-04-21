import 'package:get/get.dart';
import 'package:qur_an/screens/detail_surah.dart';
import 'package:qur_an/screens/home.dart';
import 'package:qur_an/screens/jadwal_sholat.dart';
import 'package:qur_an/widgets/tab_wraper.dart';

appRoutes() => [
      // Tab
      GetPage(
          name: '/',
          page: () => TabWraper(),
          parameters: {'selectedIndex': "0"}),
      GetPage(
          name: '/jadwal-sholat',
          page: () => TabWraper(),
          parameters: {'selectedIndex': "1"}),
      GetPage(
          name: '/jadwal-sholat',
          page: () => TabWraper(),
          parameters: {'selectedIndex': "2"}),

      GetPage(
          name: '/detail-surah',
          page: () => DetailSurah(),
          transition: Transition.rightToLeft),
    ];
