import 'package:flutter/material.dart';
import 'package:qur_an/models/jadwal.dart';
import 'package:qur_an/widgets/item_jadwal_sholat.dart';

class ListJadwalSholat extends StatelessWidget {
  const ListJadwalSholat({
    super.key,
    required this.city_id,
    required this.jadwal,
    required this.nextTime,
  });

  final String city_id;
  final Jadwal? jadwal;
  final String nextTime;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ItemJadwalSholat(
          title: "Imsak",
          time: jadwal?.data.jadwal.imsak ?? "",
          isActivated: nextTime == "imsak",
        ),
        ItemJadwalSholat(
          title: "Subuh",
          time: jadwal?.data.jadwal.subuh ?? "",
          isActivated: nextTime == "subuh",
        ),
        ItemJadwalSholat(
          title: "Dzuhur",
          // isActivated: true,
          time: jadwal?.data.jadwal.dzuhur ?? "",
          isActivated: nextTime == "dzuhur",
        ),
        ItemJadwalSholat(
          title: "Ashar",
          time: jadwal?.data.jadwal.ashar ?? "",
          isActivated: nextTime == "ashar",
        ),
        ItemJadwalSholat(
          title: "Maghrib",
          time: jadwal?.data.jadwal.maghrib ?? "",
          isActivated: nextTime == "maghrib",
        ),
        ItemJadwalSholat(
          title: "Isya",
          time: jadwal?.data.jadwal.isya ?? "",
          isActivated: nextTime == "isya",
        ),
      ],
    );
  }
}
