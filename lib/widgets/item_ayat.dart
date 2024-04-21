import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qur_an/widgets/number.dart';

class ItemAyat extends StatefulWidget {
  const ItemAyat(
      {super.key,
      required this.ar,
      required this.tr,
      required this.idn,
      required this.nomor,
      required this.audio,
      required this.onPlay,
      required this.isPlaying});

  final int nomor;
  final String ar;
  final String tr;
  final String idn;
  final dynamic audio;
  final Function onPlay;
  final bool isPlaying;

  @override
  _ItemAyatState createState() => _ItemAyatState();
}

class _ItemAyatState extends State<ItemAyat> {
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  @override
  // void dispose() {
  //   // Release decoders and buffers back to the operating system making them
  //   // available for other apps to use.
  //   player.dispose();
  //   super.dispose();
  // }

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
                    Number(nomor: widget.nomor),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.3,
                      // color: Colors.red,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          const Icon(
                            Icons.share,
                            color: Color(0xFF65D6FC),
                          ),
                          const Icon(
                            Icons.bookmark,
                            color: Color(0xFF65D6FC),
                          ),
                          GestureDetector(
                            onTap: () => {widget.onPlay()},
                            child: widget.isPlaying
                                ? const Icon(
                                    Icons.stop,
                                    size: 25,
                                    color: Color(0XFF65d6fc),
                                  )
                                : const Icon(
                                    Icons.play_arrow_sharp,
                                    size: 25,
                                    color: Color(0XFF65d6fc),
                                  ),

                            // Icon(
                            //   isPlaying ? Icons.stop : Icons.play_arrow,
                            //   // size: 25,
                            //   color: Color(0xFF65D6FC),
                            // ),
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
