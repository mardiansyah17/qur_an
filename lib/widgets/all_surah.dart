import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:qur_an/models/list_surah.dart';
import 'package:qur_an/screens/detail_surah.dart';
import 'package:qur_an/services/surah_services.dart';
import 'package:qur_an/utils/app_colors.dart';
import 'package:qur_an/widgets/number.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class AllSurah extends StatefulWidget {
  const AllSurah({super.key});

  @override
  _AllSurahState createState() => _AllSurahState();
}

class _AllSurahState extends State<AllSurah> {
  List<dynamic> listSurah = [];
  bool isLoading = false;

  void fetchSurah() async {
    setState(() {
      isLoading = true;
    });
    final result = await SurahService.fetchSurah();

    // print(listSurah);
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

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: isLoading
          ? Center(
              child: LoadingAnimationWidget.inkDrop(
                  color: const Color(0xFF65D6FC), size: 40),
            )
          : Container(
              margin: const EdgeInsets.only(top: 30),
              child: ListView.builder(
                // padding: const EdgeInsets.all(8),
                itemCount: listSurah.length,
                scrollDirection: Axis.vertical,
                itemBuilder: (BuildContext context, int index) {
                  final ListSurah surah = listSurah[index];

                  return GestureDetector(
                    onTap: () => {
                      Get.to(const DetailSurah(),
                          arguments: {"nomor": surah.nomor},
                          transition: Transition.rightToLeftWithFade)
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
                                      fontSize: 18,
                                      color: AppColors.primaryColor),
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
            ),
    );
  }
}
