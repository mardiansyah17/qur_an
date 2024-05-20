import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:localstorage/localstorage.dart';
import 'package:qur_an/models/surah.dart';
import 'package:qur_an/services/detail_surah_service.dart';
import 'package:qur_an/utils/app_colors.dart';
import 'package:qur_an/widgets/app_bar_title_text.dart';
import 'package:qur_an/widgets/item_ayat.dart';
import 'package:qur_an/widgets/loading_scree.dart';
import 'package:qur_an/widgets/scaffold_gradient.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class DetailSurah extends StatefulWidget {
  const DetailSurah({super.key});

  @override
  _DetailSurahState createState() => _DetailSurahState();
}

class _DetailSurahState extends State<DetailSurah> {
  final player = AudioPlayer();
  dynamic isPlaying;
  final ItemScrollController _scrollController = ItemScrollController();
  final ScrollOffsetController scrollOffsetController =
      ScrollOffsetController();
  final ItemPositionsListener itemPositionsListener =
      ItemPositionsListener.create();
  final ScrollOffsetListener scrollOffsetListener =
      ScrollOffsetListener.create();
  final nomor = Get.arguments['nomor'];

  Surah? surah;
  bool isLoading = false;
  Map<String, dynamic>? lastRead;

  Future<void> fetchSurah() async {
    setState(() {
      isLoading = true;
    });
    final result = await DetailSurahService.fetchSurah(nomor);

    setState(() {
      surah = result;
      isLoading = false;
    });

    // localStorage.setItem('nomorSurah', result.data.nomor.toString());
    // localStorage.setItem('namaSurah', result.data.namaLatin);
  }

  @override
  void initState() {
    super.initState();
    getLastRead();
    fetchSurah().then((_) => {
          if (nomor.toString() == lastRead!['nomorSurah'])
            {
              Future.delayed(
                  Duration(milliseconds: 100),
                  () => {
                        _scrollController.scrollTo(
                            index: int.parse(lastRead!["ayat"]) - 1,
                            duration: Duration(milliseconds: 1200),
                            curve: Curves.easeInOut)
                      })
            }
        });

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

  void getLastRead() {
    setState(() {
      lastRead = {
        "namaSurah": localStorage.getItem('namaSurah'),
        "nomorSurah": localStorage.getItem('nomorSurah'),
        "ayat": localStorage.getItem('ayat'),
      };
    });
  }

  void setLastRead(ayat, nomorSurah, namaSurah) {
    localStorage.setItem('nomorSurah', nomorSurah.toString());
    localStorage.setItem('ayat', ayat);
    localStorage.setItem('namaSurah', namaSurah);
    getLastRead();
    Fluttertoast.showToast(
        msg: "Berhasil di simpan sebagai surah terakhir dibaca",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 1,
        backgroundColor: AppColors.secondaryColor,
        textColor: Colors.white,
        fontSize: 16.0);
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
  Widget build(BuildContext context) {
    return PopScope(
        canPop: false,
        onPopInvoked: (didPop) => {dispose(), Get.toNamed('/')},
        child: ScaffoldGradient(
            title: AppBarTitleText(title: surah?.data.namaLatin ?? ""),
            body: isLoading
                ? const LoadingScreen()
                : ScrollablePositionedList.builder(
                    itemScrollController: _scrollController,
                    scrollOffsetController: scrollOffsetController,
                    itemPositionsListener: itemPositionsListener,
                    scrollOffsetListener: scrollOffsetListener,
                    itemCount: surah?.data.ayat.length ?? 0,
                    itemBuilder: (context, index) {
                      final ayat = surah!.data.ayat[index];
                      // print(surah!.data.nomor.toString() ==
                      //     lastRead!["nomorSurah"]);
                      return ItemAyat(
                        key: Key(ayat.nomorAyat.toString()),
                        setLastRead: setLastRead,
                        ayat: ayat.nomorAyat,
                        ar: ayat.teksArab,
                        tr: ayat.teksLatin,
                        idn: ayat.teksIndonesia,
                        audio: ayat.audio["01"] as String,
                        nomorSurah: surah!.data.nomor,
                        namaSurah: surah!.data.namaLatin,
                        isLastRead: lastRead != null &&
                            surah!.data.nomor.toString() ==
                                lastRead!["nomorSurah"] &&
                            ayat.nomorAyat.toString() == lastRead!['ayat'],
                        onPlay: () =>
                            onPlay(ayat.audio["01"] as String, ayat.nomorAyat),
                        isPlaying: isPlaying == ayat.nomorAyat,
                      );
                    },
                  )));
  }
}
