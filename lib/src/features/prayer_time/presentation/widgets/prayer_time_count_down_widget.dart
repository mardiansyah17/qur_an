import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qur_an/src/core/extensions/datetime_extension.dart';
import 'package:qur_an/src/core/extensions/string_extension.dart';
import 'package:qur_an/src/core/theme/app_pallete.dart';
import 'package:qur_an/src/features/prayer_time/domain/entities/prayer_time.dart';
import 'package:qur_an/src/features/prayer_time/presentation/blocs/prayer_time_bloc/prayer_time_bloc.dart';
import 'package:intl/intl.dart';

class PrayerTimeCountDownWidget extends StatefulWidget {
  final Map<String, String>? nextTime;
  final PrayerTime prayerTime;
  const PrayerTimeCountDownWidget(
      {super.key, required this.nextTime, required this.prayerTime});

  @override
  State<PrayerTimeCountDownWidget> createState() =>
      _PrayerTimeCountDownWidgetState();
}

class _PrayerTimeCountDownWidgetState extends State<PrayerTimeCountDownWidget> {
  String? counterString;
  Timer? _timer;

  @override
  void initState() {
    DateTime waktuSholat =
        DateFormat("EEEE, dd/MM/yyyy").parse(widget.prayerTime.tanggal);

    if (waktuSholat.isToday && widget.nextTime != null) {
      counter();
    }
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    log('close');
    _timer!.cancel();
  }

  void counter() {
    DateTime waktuSholat = DateFormat("EEEE, dd/MM/yyyy HH:mm")
        .parse("${widget.prayerTime.tanggal} ${widget.nextTime!.values.first}");

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      // log(timer.tick.toString());
      DateTime now = DateTime.now();
      Duration rentang = waktuSholat.difference(now);
      if (rentang.inSeconds < 0) {
        timer.cancel();
        context.read<PrayerTimeBloc>().add(UpdateNextTime());
        return;
      }
      setState(() {
        counterString =
            "${rentang.inHours} jam ${rentang.inMinutes.remainder(60)} menit ${rentang.inSeconds.remainder(60)} detik lagi";
      });
    });
  }

  @override
  void didUpdateWidget(covariant PrayerTimeCountDownWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.nextTime != oldWidget.nextTime) {
      _timer?.cancel();
      counter();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            widget.nextTime == null
                ? "Isya"
                : widget.nextTime!.keys.first.toCapitalized(),
            style: const TextStyle(fontSize: 20, color: AppPallete.white),
          ),
          const SizedBox(height: 5),
          Text(
            widget.nextTime == null
                ? widget.prayerTime.isya
                : widget.nextTime!.values.first,
            style: const TextStyle(fontSize: 22, color: AppPallete.white),
          ),
          const SizedBox(height: 5),
          Text(
            counterString ?? "",
            style: const TextStyle(fontSize: 16, color: AppPallete.white),
          ),
        ],
      ),
    );
  }
}
