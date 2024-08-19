class PrayerTime {
  final String imsak;
  final String tanggal;
  final String subuh;
  final String dhuha;
  final String dzuhur;
  final String ashar;
  final String maghrib;
  final String isya;

  PrayerTime({
    required this.imsak,
    required this.tanggal,
    required this.subuh,
    required this.dhuha,
    required this.dzuhur,
    required this.ashar,
    required this.maghrib,
    required this.isya,
  });

  Map<String, String> toMap() {
    return {
      "imsak": imsak,
      "subuh": subuh,
      "dzuhur": dzuhur,
      "ashar": ashar,
      "maghrib": maghrib,
      "isya": isya,
    };
  }
}
