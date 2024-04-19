import 'dart:convert';

import 'package:qur_an/models/list_surah.dart';
import 'package:http/http.dart' as http;

class SurahService {
  static const String baseUrl = "https://equran.id/api/v2/surat";
  static Future<List<ListSurah>> fetchSurah() async {
    final response = await http.get(Uri.parse(baseUrl));
    final result = jsonDecode(response.body);
    List<ListSurah> listSurah = List<ListSurah>.from(
      result['data'].map((surah) => ListSurah.fromJson(surah)),
    );

    return listSurah;
  }
}
