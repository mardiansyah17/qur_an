import 'package:dartz/dartz.dart';
import 'package:qur_an/src/core/errors/failures.dart';
import 'package:qur_an/src/features/prayer_time/domain/entities/city.dart';

abstract interface class CityRepository {
  Future<Either<Failure, List<City>>> getCities();
}
