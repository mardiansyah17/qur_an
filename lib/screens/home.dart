import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:localstorage/localstorage.dart';
import 'package:qur_an/services/surah_services.dart';
import 'package:qur_an/widgets/all_surah.dart';
import 'package:qur_an/widgets/search_box.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with WidgetsBindingObserver {
  String lastReadSurah = '';
  final inputSearchSurah = TextEditingController();

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
        // LastRead(),
        Expanded(
          child: isLoading
              ? Center(
                  child: LoadingAnimationWidget.inkDrop(
                      color: const Color(0xFF65D6FC), size: 40),
                )
              : AllSurah(
                  listSurah: listSurah,
                ),
        )
      ],
    );
  }
}

class LastRead extends StatefulWidget {
  const LastRead({
    super.key,
  });

  @override
  State<LastRead> createState() => _LastReadState();
}

class _LastReadState extends State<LastRead> {
  String lastReadSurah = '';

  @override
  void initState() {
    super.initState();
    setState(() {
      lastReadSurah = localStorage.getItem('namaSurah') ?? "";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
                  "Surah : $lastReadSurah",
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
              colorFilter: const ColorFilter.mode(
                Color.fromARGB(255, 44, 184, 254),
                BlendMode.srcIn,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
