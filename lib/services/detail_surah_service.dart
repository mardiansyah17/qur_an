import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:qur_an/models/surah.dart';

class DetailSurahService {
  static const String baseUrl = "https://quran-api.santrikoding.com/api/surah";

  static Future<Surah> fetchSurah(int nomor) async {
    final response =
        await http.get(Uri.parse("https://equran.id/api/v2/surat/$nomor"));
    final result = jsonDecode(response.body);
    Surah detailSurah = Surah.fromJson(result);

    return detailSurah;
  }
}
