import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:qur_an/src/core/errors/failures.dart';
import 'package:qur_an/src/features/prayer_time/data/datasources/remote/prayer_time_remote_datasource.dart';
import 'package:qur_an/src/features/prayer_time/data/models/prayer_time_model.dart';
import 'package:qur_an/src/features/prayer_time/domain/repositories/prayer_time_repository.dart';

class PrayerTimeRepositoryImpl implements PrayerTimeRepository {
  final PrayerTimeRemoteDatasource remoteDataSource;

  PrayerTimeRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, PrayerTimeModel>> getPrayerTime(
      String city, String date) async {
    try {
      final result = await remoteDataSource.getPrayerTime(city, date);
      return Right(result);
    } on DioException catch (e) {
      return Left(ServerFailure(e.message.toString()));
    }
  }
}
