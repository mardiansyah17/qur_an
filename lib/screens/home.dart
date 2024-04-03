import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:qur_an/widgets/all_surah.dart';
import 'package:localstorage/localstorage.dart';

class Home extends StatefulWidget {
  const Home({super.key});
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            // tinggi 130 lebar 80% dari layar
            margin: const EdgeInsets.only(top: 30),
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
            child: Stack(
              children: [
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Terakhir dibaca",
                          style: TextStyle(fontSize: 18, color: Colors.white)),
                      Text(
                        "Surah : ${localStorage.getItem('namaSurah')}",
                      )
                    ],
                  ),
                ),
                Positioned(
                    bottom: 0,
                    right: 0,
                    child: SvgPicture.asset(
                      'assets/svg/quran.svg',
                      height: 100,
                      // width: 100,
                      colorFilter: const ColorFilter.mode(
                          Color.fromARGB(255, 44, 184, 254), BlendMode.srcIn),
                    )),
              ],
            )),
        const AllSurah()
      ],
    );
  }
}
