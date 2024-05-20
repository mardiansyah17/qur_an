import 'dart:async';

import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:localstorage/localstorage.dart';
import 'package:qur_an/models/jadwal.dart';
import 'package:qur_an/services/jadwal_service.dart';
import 'package:qur_an/utils/helpers.dart';
import 'package:qur_an/utils/showAlert.dart';
import 'package:qur_an/widgets/count_down_sholat.dart';
import 'package:qur_an/widgets/header_jadwal_sholat.dart';
import 'package:qur_an/widgets/list_jadwal_sholat.dart';
import 'package:qur_an/widgets/loading_scree.dart';

class JadwalSholat extends StatefulWidget {
  const JadwalSholat({super.key});

  @override
  State<JadwalSholat> createState() => _JadwalSholatState();
}

class _JadwalSholatState extends State<JadwalSholat> {
  final String? city_id = localStorage.getItem('city_id');
  Jadwal? jadwalSholat;
  bool isLoading = true;
  Map<String, dynamic>? nextTime;
  String? counterString;
  Map<String, dynamic>? waktuIsya;

  bool _isMounted = true;
  Timer? _timer;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _isMounted = true;
    fetchJadwal().then((value) => loadCounter());
  }

  @override
  void dispose() {
    _isMounted = false;
    _timer?.cancel();
    super.dispose();
  }

  Future fetchJadwal() async {
    setState(() {
      isLoading = true;
    });
    if (city_id == null) {
      Future.delayed(Duration.zero, () {
        return showAlert(context, "Perhatian", "Anda belum memilih kota");
      });
      return;
    }
    Jadwal resJadwal = await JadwalService.getJadwalSholat(city_id!);

    if (!resJadwal.status) {
      showAlert(
          context, "Perhatian", resJadwal.message ?? "Gagal mengambil data");
    }

    // loadCounter();

    setState(() {
      jadwalSholat = resJadwal;
      isLoading = false;
    });
  }

  void loadCounter() {
    if (jadwalSholat != null) {
      findNextTime().then((value) => {counter()});
    }
  }

  void counter() {
    int tanggalSekarang = DateTime.now().day;

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      // Check if the timer has been canceled
      if (!_isMounted || timer.isActive == false) {
        timer.cancel(); // Ensure the timer is canceled
        return;
      }

      DateTime now = DateTime.now();
      if (now.day != tanggalSekarang) {
        fetchJadwal().then((value) => loadCounter());
        setState(() {
          waktuIsya = null;
        });
        return;
      }
      if (waktuIsya != null) {
        DateTime jamSholat = waktuIsya!['waktu'];
        Duration rentang = now.difference(jamSholat);
        if (rentang.inSeconds == 0) {
          timer.cancel();
          loadCounter();
          return;
        }
        setState(() {
          counterString =
              '${Helpers.formatTwoDigits(rentang.inHours)}:${Helpers.formatTwoDigits(rentang.inMinutes.remainder(60))}:${Helpers.formatTwoDigits(rentang.inSeconds.remainder(60))}';
        });
      } else {
        DateTime jamSholat = nextTime!["waktu"];
        Duration rentang = jamSholat.difference(now);
        if (rentang.inSeconds == 0) {
          timer.cancel();
          loadCounter();
          return;
        }
        if (_isMounted) {
          setState(() {
            counterString =
                '${Helpers.formatTwoDigits(rentang.inHours)}:${Helpers.formatTwoDigits(rentang.inMinutes.remainder(60))}:${Helpers.formatTwoDigits(rentang.inSeconds.remainder(60))}';
          });
        }
      }
    });
  }

  Future<void> findNextTime() async {
    Map<String, dynamic> _jadwal = jadwalSholat!.data.jadwal.toJson();
    DateTime now = DateTime.now();
    List nextTimes = [];
    // Object _waktuIsya;
    _jadwal.forEach((x, y) {
      if (x != "tanggal" && x != "date") {
        String jamSholat = y;

        int jam = int.parse(jamSholat.split(":")[0]);
        int menit = int.parse(jamSholat.split(":")[1]);
        DateTime waktuSholat =
            DateTime(now.year, now.month, now.day, jam, menit);
        if (waktuSholat.isAfter(now) && now.isBefore(waktuSholat)) {
          nextTimes.add({"nama": x, "waktu": waktuSholat});
        } else if (x == "isya") {
          setState(() {
            waktuIsya = {"nama": x, "waktu": waktuSholat};
          });
        }
      }
    });
    if (nextTimes.isNotEmpty) {
      setState(() {
        nextTime = nextTimes[0];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      children: [
        HeaderJadwalSholat(
          fetchJadwal: fetchJadwal,
        ),
        if (city_id == null || jadwalSholat?.data == null)
          Container()
        else
          Container(
            child: isLoading
                ? LoadingScreen()
                : Column(
                    children: [
                      CountDownSholat(
                        jadwal: jadwalSholat!.data.jadwal,
                        counterString:
                            counterString == null ? "" : counterString!,
                        nextTime: nextTime,
                      ),
                      Container(
                          alignment: Alignment.center,
                          constraints: BoxConstraints(
                            minHeight: 200,
                          ),
                          child: ListJadwalSholat(
                            city_id: city_id!,
                            jadwal: jadwalSholat,
                            nextTime: nextTime?['nama'] == null
                                ? ""
                                : nextTime!['nama'],
                            // waktuIsya: isIsyaTimePassed,
                          ))
                    ],
                  ),
          )
      ],
    ));
  }
}
