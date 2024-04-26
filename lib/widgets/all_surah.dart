import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:localstorage/localstorage.dart';
import 'package:qur_an/models/list_surah.dart';
import 'package:qur_an/screens/detail_surah.dart';
import 'package:qur_an/utils/app_colors.dart';
import 'package:qur_an/widgets/number.dart';

class AllSurah extends StatefulWidget {
  const AllSurah({super.key, required this.listSurah});

  final List<dynamic> listSurah;

  @override
  _AllSurahState createState() => _AllSurahState();
}

class _AllSurahState extends State<AllSurah> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 5),
      child: ListView.builder(
        // padding: const EdgeInsets.all(8),
        itemCount: widget.listSurah.length,
        scrollDirection: Axis.vertical,
        itemBuilder: (BuildContext context, int index) {
          final ListSurah surah = widget.listSurah[index];

          return GestureDetector(
            onTap: () => {
              // localStorage.setItem('nomorSurah', result.data.nomor.toString());
              Get.toNamed(
                '/detail-surah',
                arguments: {"nomor": surah.nomor},
              )
              // Get.to(() => const DetailSurah(),
            },
            child: Container(
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.only(top: 10),
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Color.fromRGBO(123, 128, 173, 0.35),
                    width: 1,
                  ),
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Number(nomor: surah.nomor),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          surah.namaLatin,
                          style: const TextStyle(
                            fontSize: 18,
                          ),
                        ),
                        Text(
                          surah.nama,
                          style: const TextStyle(
                              fontSize: 18, color: AppColors.primaryColor),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
