import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import 'package:localstorage/localstorage.dart';
import 'package:qur_an/utils/app_colors.dart';
import 'package:qur_an/widgets/number.dart';

class ItemAyat extends StatefulWidget {
  const ItemAyat({
    super.key,
    required this.ar,
    required this.tr,
    required this.idn,
    required this.ayat,
    required this.audio,
    required this.onPlay,
    required this.isPlaying,
    required this.nomorSurah,
    required this.namaSurah,
    required this.setLastRead,
    this.isLastRead = false,
  });

  final int ayat;
  final String ar;
  final String tr;
  final String idn;
  final dynamic audio;
  final Function onPlay;
  final bool isPlaying;
  final int nomorSurah;
  final String namaSurah;
  final bool isLastRead;
  final Function setLastRead;
  @override
  _ItemAyatState createState() => _ItemAyatState();
}

class _ItemAyatState extends State<ItemAyat> {
  @override
  Widget build(BuildContext context) {
    return Container(
      // margin: const EdgeInsets.only(bottom: 50),

      child: Column(
        children: [
          Column(
            children: [
              Container(
                padding: EdgeInsets.only(top: 50),
                alignment: Alignment.centerRight,
                margin: const EdgeInsets.only(bottom: 15),
                child: RichText(
                  textAlign: TextAlign.right,
                  text: TextSpan(
                    children: [
                      // Teks untuk baris pertama
                      TextSpan(
                        text: widget.ar
                            .split('\n')[0], // Ambil teks dari baris pertama
                        style: GoogleFonts.amiri().copyWith(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF65D6FC),
                          height: 3,
                          letterSpacing: 1,
                          wordSpacing: 10,
                        ),
                      ),
                      // Teks untuk baris-baris berikutnya
                      if (widget.ar.split('\n').length > 1)
                        TextSpan(
                          text: '\n' +
                              widget.ar.split('\n').sublist(1).join('\n'),
                          style: GoogleFonts.amiri().copyWith(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFF65D6FC),
                            height: 3,
                            letterSpacing: 1,
                            wordSpacing: 10,
                          ),
                        ),
                    ],
                  ),
                ),
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
                    Container(
                      width: MediaQuery.of(context).size.width * 0.4,
                      // color: Colors.amber,
                      // color: Colors.red,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        // crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          ElevatedButton(
                              onPressed: () => {
                                    widget.setLastRead(widget.ayat.toString(),
                                        widget.nomorSurah, widget.namaSurah),
                                  },
                              style: ElevatedButton.styleFrom(
                                  shape: CircleBorder(),
                                  backgroundColor: Colors.transparent,
                                  shadowColor: Colors.transparent),
                              child: Icon(
                                widget.isLastRead
                                    ? Icons.bookmark
                                    : Icons.bookmark_outline,
                                size: 30,
                                color: Color(0xFF65D6FC),
                              )),
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
