import 'dart:convert';

import 'package:qur_an/models/ListCity.dart';

City cityFromJson(String str) => City.fromJson(json.decode(str));

String cityToJson(City data) => json.encode(data.toJson());

class City {
  bool status;

  List<ListCity> data;

  City({
    required this.status,
    required this.data,
  });

  factory City.fromJson(Map<String, dynamic> json) => City(
        status: json["status"],
        data:
            List<ListCity>.from(json["data"].map((x) => ListCity.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}
