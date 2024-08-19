import 'package:flutter/material.dart';
import 'package:qur_an/src/core/theme/app_pallete.dart';
import 'package:qur_an/src/features/quran/domain/entities/surah.dart';
import 'package:qur_an/src/features/quran/presentation/pages/detail_surah_screen.dart';
import 'package:qur_an/src/features/quran/presentation/widgets/number_widget.dart';
import 'package:page_transition/page_transition.dart';

class ItemSurahWidget extends StatelessWidget {
  final Surah surah;
  const ItemSurahWidget({super.key, required this.surah});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            PageTransition(
                type: PageTransitionType.rightToLeft,
                child: DetailSurahScreen(
                  surat: surah.number,
                  name: surah.name,
                  maxAyat: int.parse(surah.numberOfVerses),
                )));
      },
      child: Ink(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
          decoration: const BoxDecoration(
            // color: Colors.amber,
            border: Border(
              bottom: BorderSide(
                color: Color.fromRGBO(2, 137, 255, 0.349),
                width: 1,
              ),
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              NumberWidget(
                nomor: surah.number,
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text(surah.name, style: const TextStyle(fontSize: 18)),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          "(${surah.arabicName})",
                          style: const TextStyle(
                              fontSize: 18, color: AppPallete.primary),
                        ),
                      ],
                    ),
                    Text(
                      surah.numberOfVerses.toString(),
                      style: const TextStyle(
                          fontSize: 18, color: AppPallete.primary),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
