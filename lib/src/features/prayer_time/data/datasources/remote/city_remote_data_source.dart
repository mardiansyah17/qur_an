import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:qur_an/src/core/constants/base_url.dart';
import 'package:qur_an/src/features/prayer_time/data/models/city_model.dart';

abstract interface class CityRemoteDataSource {
  Future<List<CityModel>> getCities();
}

class CityRemoteDataSourceImpl implements CityRemoteDataSource {
  final Dio dio;

  CityRemoteDataSourceImpl(this.dio);

  @override
  Future<List<CityModel>> getCities() async {
    try {
      final response = await dio.get("$baseUrlPrayerTime/sholat/kota/semua");

      return (response.data['data'] as List)
          .map((e) => CityModel.fromJson(e))
          .toList();
    } on DioException catch (e) {
      log(e.response!.statusCode.toString());
      rethrow;
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }
}
