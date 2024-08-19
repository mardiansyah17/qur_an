import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:qur_an/src/core/constants/base_url.dart';
import 'package:qur_an/src/features/quran/data/models/ayat_model.dart';
import 'package:qur_an/src/features/quran/data/models/surah_model.dart';

abstract interface class AlQuranRemoteDatasource {
  Future<List<SurahModel>> getAllSurah();
  Future<List<AyatModel>> getAyatBySurah(String surat, {int? lastAyat});
}

class AlQuranRemoteDatasourceImpl implements AlQuranRemoteDatasource {
  final Dio dio;

  AlQuranRemoteDatasourceImpl(this.dio);

  @override
  Future<List<SurahModel>> getAllSurah() async {
    try {
      final response = await dio.get("$baseUrlQuran/surat/semua");

      return (response.data['data'] as List)
          .map((e) => SurahModel.fromJson(e))
          .toList();
    } on DioException catch (e) {
      log(e.response!.statusCode.toString());
      rethrow;
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<List<AyatModel>> getAyatBySurah(String surat, {int? lastAyat}) async {
    try {
      final response = await dio.get("$baseUrlQuran/ayat/$surat/$lastAyat/10");
      // log(response.data['data'].toString());

      return (response.data['data'] as List)
          .map((e) => AyatModel.fromJson(e))
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
