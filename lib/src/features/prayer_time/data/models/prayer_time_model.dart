import 'package:qur_an/src/features/prayer_time/domain/entities/prayer_time.dart';

class PrayerTimeModel extends PrayerTime {
  PrayerTimeModel({
    required super.imsak,
    required super.tanggal,
    required super.subuh,
    required super.dhuha,
    required super.dzuhur,
    required super.ashar,
    required super.maghrib,
    required super.isya,
  });

  factory PrayerTimeModel.fromJson(Map<String, dynamic> json) {
    return PrayerTimeModel(
      imsak: json['imsak'],
      tanggal: json['tanggal'],
      subuh: json['subuh'],
      dhuha: json['dhuha'],
      dzuhur: json['dzuhur'],
      ashar: json['ashar'],
      maghrib: json['maghrib'],
      isya: json['isya'],
    );
  }
}
