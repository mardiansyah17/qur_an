import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:localstorage/localstorage.dart';
import 'package:qur_an/models/jadwal.dart';
import 'package:qur_an/services/jadwal_service.dart';
import 'package:qur_an/utils/showAlert.dart';
import 'package:qur_an/widgets/header_jadwal_sholat.dart';
import 'package:qur_an/widgets/list_jadwal_sholat.dart';

class JadwalSholat extends StatefulWidget {
  const JadwalSholat({super.key});

  @override
  State<JadwalSholat> createState() => _JadwalSholatState();
}

class _JadwalSholatState extends State<JadwalSholat> {
  final String? city_id = localStorage.getItem('city_id');
  Jadwal? jadwalSholat;
  bool isLoading = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    fetchJadwal();
  }

  fetchJadwal() async {
    setState(() {
      isLoading = true;
    });
    if (city_id == null) {
      Future.delayed(Duration.zero, () {
        // return print('mantao');
        return showAlert(context, "Perhatian", "Anda belum memilih kota");
      });
      return;
    }
    Jadwal resJadwal = await JadwalService.getJadwalSholat(city_id!);

    if (!resJadwal.status) {
      showAlert(
          context, "Perhatian", resJadwal.message ?? "Gagal mengambil data");
    }
    setState(() {
      jadwalSholat = resJadwal;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        HeaderJadwalSholat(
          fetchJadwal: fetchJadwal,
        ),
        Container(
          margin: const EdgeInsets.only(top: 30),
          padding: EdgeInsets.all(10),
          height: 130,
          width: double.infinity,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: const Color(0xff65D6FC).withOpacity(0.5),
                spreadRadius: 0,
                blurRadius: 23,
                offset: const Offset(0, 0), // changes position of shadow
              ),
            ],
            borderRadius: BorderRadius.circular(20),
            gradient: const LinearGradient(colors: [
              Color(0xff65CEFC),
              Color(0xff455EB5),
            ], begin: Alignment.topLeft, end: Alignment.bottomRight),
          ),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Waktu selanjutnya Maghrib",
                      style: TextStyle(fontSize: 17, color: Colors.white)),
                ],
              ),
              Container(
                margin: EdgeInsets.only(top: 16),
                child: Text(
                  '- 02:20:10',
                  style: TextStyle(fontSize: 22),
                ),
              )
            ],
          ),
        ),
        city_id == null
            ? Container()
            : Container(
                alignment: Alignment.center,
                constraints: BoxConstraints(
                  minHeight: 200,
                ),
                child: isLoading
                    ? Center(
                        child: LoadingAnimationWidget.inkDrop(
                            color: const Color(0xFF65D6FC), size: 40),
                      )
                    : ListJadwalSholat(
                        city_id: city_id!,
                        jadwal: jadwalSholat,
                      ))
      ],
    );
  }
}
