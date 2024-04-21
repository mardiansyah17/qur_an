// To parse this JSON data, do
//
//     final jadwal = jadwalFromJson(jsonString);

import 'dart:convert';

Jadwal jadwalFromJson(String str) => Jadwal.fromJson(json.decode(str));

String jadwalToJson(Jadwal data) => json.encode(data.toJson());

class Jadwal {
  bool status;
  Request request;
  Data data;
  String? message;

  Jadwal({
    required this.status,
    required this.request,
    required this.data,
    this.message,
  });

  factory Jadwal.fromJson(Map<String, dynamic> json) => Jadwal(
        status: json["status"],
        request: Request.fromJson(json["request"]),
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "request": request.toJson(),
        "data": data.toJson(),
      };
}

class Data {
  int id;
  String lokasi;
  String daerah;
  JadwalClass jadwal;

  Data({
    required this.id,
    required this.lokasi,
    required this.daerah,
    required this.jadwal,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        lokasi: json["lokasi"],
        daerah: json["daerah"],
        jadwal: JadwalClass.fromJson(json["jadwal"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "lokasi": lokasi,
        "daerah": daerah,
        "jadwal": jadwal.toJson(),
      };
}

class JadwalClass {
  String tanggal;
  String imsak;
  String subuh;
  String terbit;
  String dhuha;
  String dzuhur;
  String ashar;
  String maghrib;
  String isya;
  DateTime date;

  JadwalClass({
    required this.tanggal,
    required this.imsak,
    required this.subuh,
    required this.terbit,
    required this.dhuha,
    required this.dzuhur,
    required this.ashar,
    required this.maghrib,
    required this.isya,
    required this.date,
  });

  factory JadwalClass.fromJson(Map<String, dynamic> json) => JadwalClass(
        tanggal: json["tanggal"],
        imsak: json["imsak"],
        subuh: json["subuh"],
        terbit: json["terbit"],
        dhuha: json["dhuha"],
        dzuhur: json["dzuhur"],
        ashar: json["ashar"],
        maghrib: json["maghrib"],
        isya: json["isya"],
        date: DateTime.parse(json["date"]),
      );

  Map<String, dynamic> toJson() => {
        "tanggal": tanggal,
        "imsak": imsak,
        "subuh": subuh,
        "terbit": terbit,
        "dhuha": dhuha,
        "dzuhur": dzuhur,
        "ashar": ashar,
        "maghrib": maghrib,
        "isya": isya,
        "date":
            "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
      };
}

class Request {
  String path;
  String year;
  String month;
  String date;

  Request({
    required this.path,
    required this.year,
    required this.month,
    required this.date,
  });

  factory Request.fromJson(Map<String, dynamic> json) => Request(
        path: json["path"],
        year: json["year"],
        month: json["month"],
        date: json["date"],
      );

  Map<String, dynamic> toJson() => {
        "path": path,
        "year": year,
        "month": month,
        "date": date,
      };
}
