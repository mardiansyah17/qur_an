import 'dart:convert';

import 'package:qur_an/models/jadwal.dart';
import 'package:http/http.dart' as http;
import 'package:qur_an/utils/contants.dart';

class JadwalService {
  static String _baseUrl = '${Constants.base_url_jadwal_sholat}sholat/jadwal/';

  static Future<Jadwal> getJadwalSholat(String kota, String date) async {
    final response = await http.get(Uri.parse('$_baseUrl$kota/$date'));

    if (response.statusCode == 200) {
      return Jadwal.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load jadwal sholat');
    }
  }
}
