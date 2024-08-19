import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:qur_an/src/core/errors/failures.dart';
import 'package:qur_an/src/features/prayer_time/data/datasources/remote/city_remote_data_source.dart';
import 'package:qur_an/src/features/prayer_time/data/models/city_model.dart';
import 'package:qur_an/src/features/prayer_time/domain/repositories/city_repository.dart';

class CityRepositoryImpl implements CityRepository {
  final CityRemoteDataSource remoteDataSource;

  CityRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, List<CityModel>>> getCities() async {
    try {
      final result = await remoteDataSource.getCities();

      return Right(result);
    } on DioException catch (e) {
      return Left(ServerFailure(e.message.toString()));
    }
  }
}
