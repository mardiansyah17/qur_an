import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:localstorage/localstorage.dart';
import 'package:qur_an/services/surah_services.dart';
import 'package:qur_an/widgets/all_surah.dart';
import 'package:qur_an/widgets/loading_scree.dart';
import 'package:qur_an/widgets/search_box.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with WidgetsBindingObserver {
  String lastReadSurah = '';
  final inputSearchSurah = TextEditingController();
  Map<String, dynamic>? lastRead;

  List<dynamic> listSurah = [];
  bool isLoading = false;

  void fetchSurah() async {
    setState(() {
      isLoading = true;
    });
    final result = await SurahService.fetchSurah();

    setState(() {
      listSurah = result;
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    fetchSurah();

    setState(() {
      var nomorSurah = localStorage.getItem('nomorSurah');
      if (nomorSurah != null) {
        lastRead = {
          "namaSurah": localStorage.getItem('namaSurah'),
          "nomorSurah": nomorSurah,
          "ayat": localStorage.getItem('ayat'),
        };
      }
    });
  }

  Future changeHandler(String value) async {
    setState(() {
      isLoading = true;
    });
    await SurahService.fetchSurah().then((surah) => {
          setState(() {
            listSurah = surah
                .where((element) => element.namaLatin
                    .toLowerCase()
                    .contains(value.toLowerCase()))
                .toList();
            isLoading = false;
          })
        });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SearchBox(
          changeHandler: changeHandler,
          hintText: "Cari surah",
        ),
        lastRead == null
            ? Container()
            : LastRead(
                nomorSurah: int.parse(lastRead!['nomorSurah']),
                ayat: int.parse(lastRead!['ayat']),
                namaSurah: lastRead!['namaSurah'],
              ),
        Expanded(
          child: isLoading
              ? LoadingScreen()
              : AllSurah(
                  listSurah: listSurah,
                ),
        )
      ],
    );
  }
}

class LastRead extends StatelessWidget {
  const LastRead({
    super.key,
    required this.namaSurah,
    required this.ayat,
    required this.nomorSurah,
  });

  final String namaSurah;
  final int nomorSurah;
  final int ayat;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => {
        Get.toNamed(
          '/detail-surah',
          arguments: {"nomor": nomorSurah},
        )
      },
      child: Container(
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
                    "Surah : $namaSurah $nomorSurah:$ayat",
                  )
                ],
              ),
            ),
            // Positioned(
            //   bottom: 0,
            //   right: 0,
            //   child: SvgPicture.asset(
            //     'assets/svg/quran.svg',
            //     height: 100,
            //     colorFilter: const ColorFilter.mode(
            //       Color.fromARGB(255, 44, 184, 254),
            //       BlendMode.srcIn,
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
