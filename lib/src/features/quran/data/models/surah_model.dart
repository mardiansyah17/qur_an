import 'package:qur_an/src/features/quran/domain/entities/surah.dart';

class SurahModel extends Surah {
  SurahModel({
    required super.number,
    required super.name,
    required super.arabicName,
    required super.numberOfVerses,
  });

  factory SurahModel.fromJson(Map<String, dynamic> json) {
    return SurahModel(
      number: json['number'],
      name: json['name_id'],
      arabicName: json['name_short'],
      numberOfVerses: json['number_of_verses'],
    );
  }
}
