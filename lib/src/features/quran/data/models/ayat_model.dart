import 'package:qur_an/src/features/quran/domain/entities/ayat.dart';

class AyatModel extends Ayat {
  AyatModel({
    required super.id,
    required super.number,
    required super.arab,
    required super.audio,
    required super.latin,
    required super.terjemahan,
    super.noteNumber,
    super.noteText,
  });

  factory AyatModel.fromJson(Map<String, dynamic> json) {
    final number =
        RegExp(r'^\d+').firstMatch(json['notes'].toString())?.group(0);
    return AyatModel(
      id: json['id'],
      number: json['ayah'],
      arab: json['arab'],
      audio: json['audio'],
      latin: json['latin'],
      terjemahan: json['text'],
      noteNumber: json['notes'] != null ? number : null, // Remove this line
      noteText: json['notes'],
    );
  }
}
