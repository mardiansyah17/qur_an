import 'dart:convert';

import 'package:intl/intl.dart';
import 'package:localstorage/localstorage.dart';
import 'package:qur_an/models/jadwal.dart';
import 'package:qur_an/services/jadwal_service.dart';
import 'package:qur_an/utils/notification_helper.dart';

class SchedulePrayer {
  Future<void> getSchedule() async {
    String? cityId = localStorage.getItem('city_id');
    String? jadwalSholat = localStorage.getItem('jadwal_sholat');

    if (cityId == null || jadwalSholat == null) {
      // Jika cityId atau jadwalSholat kosong, ambil jadwal sholat terbaru
      if (cityId != null) {
        await saveToLocalStorage(cityId);
      }
    } else {
      // Jika sudah ada jadwal sholat yang tersimpan, periksa apakah masih valid untuk hari ini
      Map<String, dynamic> jadwal = jsonDecode(jadwalSholat);
      bool isToday =
          DateFormat("EEEE, d/MM/yyyy", "id-ID").format(DateTime.now()) ==
              jadwal['tanggal'];

      if (!isToday) {
        // Jika jadwal sholat yang tersimpan bukan untuk hari ini, ambil jadwal sholat terbaru
        Jadwal resJadwal = await JadwalService.getJadwalSholat(
            cityId); // cityId pasti tidak null di sini
        if (resJadwal.status == true) {
          String jadwalToString = jsonEncode(resJadwal.data.jadwal);
          localStorage.setItem("jadwal_sholat", jadwalToString);
        }
      }
    }
  }

  Future<void> saveToLocalStorage(String cityId) async {
    Jadwal resJadwal = await JadwalService.getJadwalSholat(cityId);
    if (resJadwal.status == true) {
      String jadwalToString = jsonEncode(resJadwal.data.jadwal);
      localStorage.setItem("jadwal_sholat", jadwalToString);
    }
  }

  Future<void> schedulePrayerTimes() async {
    String? jadwalSholat = localStorage.getItem('jadwal_sholat')!;

    Map<String, dynamic> jadwal = jsonDecode(jadwalSholat);
    DateFormat format = DateFormat("EEEE, dd/MM/yyyy HH:mm", 'id-ID');
    DateTime subuh = format.parse("${jadwal["tanggal"]} ${jadwal['subuh']}");
    DateTime dzuhur = format.parse("${jadwal["tanggal"]} ${jadwal['dzuhur']}");
    DateTime ashar = format.parse("${jadwal["tanggal"]} ${jadwal['ashar']}");
    DateTime maghrib =
        format.parse("${jadwal["tanggal"]} ${jadwal['maghrib']}");
    DateTime isya = format.parse("${jadwal["tanggal"]} ${jadwal['isya']}");
    await NotificationHelper.scheduleNotification(
        1, subuh, "Waktunya sholat", "Sholat Subuh");
    await NotificationHelper.scheduleNotification(
        2, dzuhur, "Waktunya sholat", "Sholat Dzuhur");
    await NotificationHelper.scheduleNotification(
        3, ashar, "Waktunya sholat", "Sholat Ashar");
    await NotificationHelper.scheduleNotification(
        4, maghrib, "Waktunya sholat", "Sholat Maghrib");
    await NotificationHelper.scheduleNotification(
        5, isya, "Waktunya sholat", "Sholat Isya");
  }
}
