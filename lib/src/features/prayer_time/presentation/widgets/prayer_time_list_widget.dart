import 'package:flutter/material.dart';
import 'package:qur_an/src/features/prayer_time/domain/entities/prayer_time.dart';
import 'package:qur_an/src/features/prayer_time/presentation/widgets/prayer_time_item_widget.dart';

class PrayerTimeListWidget extends StatelessWidget {
  final PrayerTime prayerTime;
  final Map<String, dynamic>? nextTime;
  const PrayerTimeListWidget({
    super.key,
    required this.prayerTime,
    this.nextTime,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 280,
      left: 0,
      right: 0,
      bottom: 0,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF000000).withOpacity(0.1),
              offset: const Offset(0, -5),
              blurRadius: 22,
              spreadRadius: 5,
            ),
          ],
          color: Colors.white,
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(30), topRight: Radius.circular(30)),
        ),
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            for (int i = 0; i < prayerTime.toMap().length; i++)
              PrayerTimeItemWidget(
                name: prayerTime.toMap().keys.toList()[i],
                time: prayerTime.toMap().values.toList()[i],
                isActive: nextTime != null
                    ? i ==
                        prayerTime
                            .toMap()
                            .keys
                            .toList()
                            .indexOf(nextTime!.keys.first)
                    : false,
              ),
          ],
        )),
      ),
    );
  }
}
