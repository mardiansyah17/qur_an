import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:qur_an/src/core/errors/failures.dart';
import 'package:qur_an/src/features/quran/data/datasources/al_quran_remote_datasource.dart';
import 'package:qur_an/src/features/quran/domain/entities/ayat.dart';
import 'package:qur_an/src/features/quran/domain/entities/surah.dart';
import 'package:qur_an/src/features/quran/domain/repositories/al_quran_repository.dart';

class AlQuranRepositoryImpl implements AlQuranRepository {
  final AlQuranRemoteDatasource alQuranRemoteDatasource;

  AlQuranRepositoryImpl({required this.alQuranRemoteDatasource});

  @override
  Future<Either<Failure, List<Surah>>> getAllSurah() async {
    try {
      final result = await alQuranRemoteDatasource.getAllSurah();
      return Right(result);
    } on DioException catch (e) {
      return Left(ServerFailure(e.message.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Ayat>>> getAyatBySurah(String id,
      {int? lastAyat}) async {
    try {
      final result =
          await alQuranRemoteDatasource.getAyatBySurah(id, lastAyat: lastAyat);
      return Right(result);
    } on DioException catch (e) {
      return Left(ServerFailure(e.message.toString()));
    }
  }
}
