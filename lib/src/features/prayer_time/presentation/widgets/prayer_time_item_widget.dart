import 'package:flutter/material.dart';
import 'package:qur_an/src/core/extensions/string_extension.dart';
import 'package:qur_an/src/core/theme/app_pallete.dart';

class PrayerTimeItemWidget extends StatelessWidget {
  final String name;
  final String time;
  final bool isActive;
  const PrayerTimeItemWidget({
    super.key,
    required this.name,
    required this.time,
    this.isActive = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: isActive ? AppPallete.primary : Colors.white,
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF000000).withOpacity(0.1),
            offset: const Offset(0, 5),
            blurRadius: 10,
            spreadRadius: 1,
          ),
        ],
        border: Border.all(
          color: AppPallete.second,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(name.toCapitalized(),
              style: TextStyle(
                color: isActive ? Colors.white : AppPallete.primary,
              )),
          Row(
            children: [
              Text(time,
                  style: TextStyle(
                    color: isActive ? Colors.white : AppPallete.primary,
                  )),
              const SizedBox(width: 10),
              Icon(
                Icons.notifications_on,
                color: isActive ? Colors.white : AppPallete.primary,
              ),
            ],
          )
        ],
      ),
    );
  }
}
