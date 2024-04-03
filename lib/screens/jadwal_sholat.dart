import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:qur_an/screens/select_city.dart';
import 'package:qur_an/utils/app_colors.dart';
import 'package:qur_an/widgets/list_jadwal_sholat.dart';

class JadwalSholat extends StatelessWidget {
  const JadwalSholat({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [header(), ListJadwalSholat()],
    );
  }
}

class header extends StatelessWidget {
  const header({
    super.key,
  });

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
            child: Text("Jakarta Timur",
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
              Column(
                children: [
                  Text(
                    "Rabu, 03 April 2024",
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 17,
                        color: AppColors.primaryColor),
                  ),
                  Text("23 Ramadhan 1945",
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                          color: AppColors.primaryColor))
                ],
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
