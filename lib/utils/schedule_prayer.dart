import 'dart:convert';

import 'package:intl/intl.dart';
import 'package:localstorage/localstorage.dart';
import 'package:qur_an/models/jadwal.dart';
import 'package:qur_an/services/jadwal_service.dart';

class SchedulePrayer {
  static String? cityId = localStorage.getItem('city_id') ?? "1634";

  Future getSchedule() async {
    print('ini cityId $cityId');
    if (cityId != null) {
      Jadwal resJadwal = await JadwalService.getJadwalSholat(cityId!);
      if (resJadwal.status == true) {
        String jadwalToString = jsonEncode(resJadwal.data.jadwal);

        localStorage.setItem("jadwal_sholat", jadwalToString);
        print(jadwalToString);
      }
    }
  }

  bool isSubuhTime() {
    String? jadwalSholat = localStorage.getItem('jadwal_sholat');
    if (jadwalSholat != null) {
      String? jadwalSholat = localStorage.getItem('jadwal_sholat')!;

      Map<String, dynamic> jadwal = jsonDecode(jadwalSholat);
      DateFormat format = DateFormat("EEEE, dd/MM/yyyy HH:mm", 'id-ID');
      DateTime subuh = format.parse("${jadwal["tanggal"]} ${jadwal['subuh']}");
      DateTime now = DateTime.now();
      if (now.isAfter(subuh)) {
        return true;
      }
    }
    return false;
  }
}
