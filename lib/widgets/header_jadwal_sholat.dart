import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:localstorage/localstorage.dart';
import 'package:qur_an/screens/select_city.dart';
import 'package:qur_an/utils/app_colors.dart';
import 'package:qur_an/widgets/date_picker.dart';

class HeaderJadwalSholat extends StatefulWidget {
  HeaderJadwalSholat({super.key});

  @override
  State<HeaderJadwalSholat> createState() => _HeaderJadwalSholatState();
}

class _HeaderJadwalSholatState extends State<HeaderJadwalSholat> {
  String? selectedDateSchedule = localStorage.getItem('selectedDateSchedule');

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () => {
            Get.to(const SelectCity(),
                transition: Transition.downToUp,
                duration: Duration(milliseconds: 450))
          },
          child: Container(
            margin: EdgeInsets.only(bottom: 20),
            child: Text(localStorage.getItem('city_name') ?? "Pilih Kota",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                )),
          ),
        ),
        Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
              ),
              GestureDetector(
                onTap: () => {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return Dialog(
                          backgroundColor: Colors.transparent,
                          insetAnimationCurve: Curves.bounceInOut,
                          insetAnimationDuration: Duration(milliseconds: 8000),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Color.fromARGB(255, 69, 89, 217),
                                  ),
                                  child: DatePicker(
                                    // selectedDate: selectedDateSchedule != null
                                    //     ? DateTime.parse(selectedDateSchedule!)
                                    //     : null,
                                    onDaySelected: (p0, p1) => {
                                      setState(() {
                                        selectedDateSchedule = p0.toString();
                                      }),
                                      localStorage.setItem(
                                          'selectedDateSchedule',
                                          p0.toString()),
                                      print(
                                        p0.toString(),
                                      )
                                    },
                                  )),
                              const SizedBox(height: 15),
                            ],
                          ),
                        );
                      })
                },
                child: Text(
                  DateFormat('y MMMM d', 'id-ID').format(
                      DateTime.parse(selectedDateSchedule!) ?? DateTime.now()),
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 17,
                      color: AppColors.primaryColor),
                ),
              ),
              Icon(
                Icons.arrow_forward_ios,
                color: Colors.white,
              ),
            ],
          ),
        )
      ],
    );
  }
}
