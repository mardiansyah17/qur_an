import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:qur_an/models/city.dart';

class CityService {
  static const baseurl = 'https://api.myquran.com/v2/sholat/kota/';
  static Future<City> fetchCities({String search = ""}) async {
    final response = await http
        .get(Uri.parse('$baseurl${search.isEmpty ? 'semua' : 'cari/$search'}'));
    final result = jsonDecode(response.body);
    City city = City.fromJson(result);
    return city;
  }
}
