import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:qur_an/models/surah.dart';
import 'package:qur_an/services/detail_surah_service.dart';
import 'package:qur_an/widgets/app_bar_title_text.dart';
import 'package:qur_an/widgets/container_gradient.dart';
import 'package:qur_an/widgets/item_ayat.dart';
import 'package:qur_an/widgets/scaffold_gradient.dart';

class DetailSurah extends StatefulWidget {
  const DetailSurah({super.key});

  @override
  _DetailSurahState createState() => _DetailSurahState();
}

class _DetailSurahState extends State<DetailSurah> {
  Surah? surah;
  bool isLoading = false;
  final player = AudioPlayer();
  dynamic isPlaying = null;

  final nomor = Get.arguments['nomor'];

  void fetchSurah() async {
    setState(() {
      isLoading = true;
    });
    final result = await DetailSurahService.fetchSurah(nomor);

    setState(() {
      surah = result;
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    fetchSurah();

    // await initLocalStorage();
    // print(surah);
    player.playerStateStream.listen((event) {
      printError(info: event.processingState.toString());
      switch (event.processingState) {
        case ProcessingState.completed:
          setState(() {
            isPlaying = null;
          });
          break;
        default:
      }
    });
  }

  Future onPlay(String url, int nomorAyat) async {
    if (isPlaying != null) {
      await player.stop();
      setState(() {
        isPlaying = null;
      });
    } else {
      setState(() {
        isPlaying = nomorAyat;
      });
      await player.setUrl(url);
      await player.play();
    }
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => PopScope(
          child: ScaffoldGradient(
        title: AppBarTitleText(title: surah?.data.namaLatin ?? ""),
        body: isLoading
            ? Center(
                child: LoadingAnimationWidget.inkDrop(
                    color: const Color(0xFF65D6FC), size: 40),
              )
            : SingleChildScrollView(
                child: Column(
                    children: surah?.data.ayat
                            .map((e) => ItemAyat(
                                key: Key(e.nomorAyat.toString()),
                                nomor: e.nomorAyat,
                                ar: e.teksArab,
                                tr: e.teksLatin,
                                idn: e.teksIndonesia,
                                audio: e.audio,
                                onPlay: () => {
                                      onPlay(
                                          e.audio["01"] as String, e.nomorAyat)
                                    },
                                isPlaying: isPlaying == e.nomorAyat))
                            .toList() ??
                        []),
              ),
      ));
}
