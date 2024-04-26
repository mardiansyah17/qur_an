import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:localstorage/localstorage.dart';
import 'package:qur_an/utils/app_colors.dart';
import 'package:qur_an/widgets/number.dart';

class ItemAyat extends StatefulWidget {
  const ItemAyat(
      {super.key,
      required this.ar,
      required this.tr,
      required this.idn,
      required this.ayat,
      required this.audio,
      required this.onPlay,
      required this.isPlaying,
      required this.nomorSurah,
      required this.namaSurah});

  final int ayat;
  final String ar;
  final String tr;
  final String idn;
  final dynamic audio;
  final Function onPlay;
  final bool isPlaying;
  final int nomorSurah;
  final String namaSurah;

  @override
  _ItemAyatState createState() => _ItemAyatState();
}

class _ItemAyatState extends State<ItemAyat> {
  void setLastRead(ayat) {
    localStorage.setItem('noSurah', widget.nomorSurah.toString());
    localStorage.setItem('ayat', ayat);
    localStorage.setItem('namaSurah', widget.namaSurah);

    Fluttertoast.showToast(
        msg: "Berhasil di simpan sebagai surah terakhir dibaca",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 1,
        backgroundColor: AppColors.secondaryColor,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 50),
      child: Column(
        children: [
          Column(
            children: [
              Container(
                alignment: Alignment.centerRight,
                margin: const EdgeInsets.only(bottom: 15),
                child: Text(widget.ar,
                    style: GoogleFonts.amiri().copyWith(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF65D6FC),
                        height: 1.5,
                        letterSpacing: 2,
                        wordSpacing: 10)),
              ),
              Container(
                alignment: Alignment.centerLeft,
                margin: const EdgeInsets.only(bottom: 4),
                child: Text(
                  widget.tr,
                  style: GoogleFonts.inter().copyWith(
                      color: const Color(0xFF65D6FC),
                      fontWeight: FontWeight.w200),
                ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  widget.idn,
                  // style: TextStyle(fontSize: 15),
                ),
              )
            ],
          ),
          Stack(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 15),
                padding: const EdgeInsets.only(bottom: 15),
                decoration: const BoxDecoration(
                  border: Border(
                      bottom: BorderSide(
                    color: Color(0xffD9D9D9),
                    width: 0.4,
                  )),
                ),
                // padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Number(nomor: widget.ayat),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.2,
                      // color: Colors.red,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          // ElevatedButton(
                          //     onPressed: () => {
                          //           setLastRead(widget.ayat.toString()),
                          //         },
                          //     style: ElevatedButton.styleFrom(
                          //         shape: CircleBorder(),
                          //         backgroundColor: Colors.transparent,
                          //         shadowColor: Colors.transparent),
                          //     child: const Icon(
                          //       Icons.bookmark_border_outlined,
                          //       size: 30,
                          //       color: Color(0xFF65D6FC),
                          //     )),
                          ElevatedButton(
                            onPressed: () => widget.onPlay(),
                            style: ElevatedButton.styleFrom(
                                shape: CircleBorder(),
                                backgroundColor: Colors.transparent,
                                shadowColor: Colors.transparent),
                            child: widget.isPlaying
                                ? const Icon(
                                    Icons.stop,
                                    size: 30,
                                    color: Color(0XFF65d6fc),
                                  )
                                : const Icon(
                                    Icons.play_arrow_sharp,
                                    size: 30,
                                    color: Color(0XFF65d6fc),
                                  ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
