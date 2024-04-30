
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qur_an/models/jadwal.dart';
import 'package:qur_an/utils/app_colors.dart';

class CountDownSholat extends StatefulWidget {
  const CountDownSholat(
      {super.key,
      required this.jadwal,
      required this.nextTime,
      required this.counterString});

  final JadwalClass jadwal;
  final Map<String, dynamic>? nextTime;
  final String counterString;
  @override
  State<CountDownSholat> createState() => _CountDownSholatState();
}

class _CountDownSholatState extends State<CountDownSholat> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // onLoad();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
              Text(
                  "${widget.nextTime == null ? "Waktu Isya sudah lewat" : 'Waktu selanjutnya ${widget.nextTime!['nama'].toString().capitalize}'}",
                  style: TextStyle(fontSize: 17, color: Colors.white)),
            ],
          ),
          Container(
            margin: EdgeInsets.only(top: 16),
            child: Text(
              widget.counterString == null ? "" : widget.counterString!,
              style: TextStyle(fontSize: 22, color: AppColors.primaryColor),
            ),
          )
        ],
      ),
    );
  }
}
