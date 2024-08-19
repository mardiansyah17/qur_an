import 'package:qur_an/src/features/prayer_time/domain/entities/city.dart';

class CityModel extends City {
  CityModel({required super.name, required super.id});

  factory CityModel.fromJson(Map<String, dynamic> json) {
    return CityModel(name: json['lokasi'], id: json['id']);
  }
}
