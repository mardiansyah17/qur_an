import 'package:dartz/dartz.dart';
import 'package:qur_an/src/core/errors/failures.dart';
import 'package:qur_an/src/core/usecase/usecase.dart';
import 'package:qur_an/src/features/prayer_time/domain/entities/city.dart';
import 'package:qur_an/src/features/prayer_time/domain/repositories/city_repository.dart';

class GetCities implements UseCase<List<City>, NoParams> {
  final CityRepository repository;

  GetCities(this.repository);

  @override
  Future<Either<Failure, List<City>>> call(NoParams params) async {
    return await repository.getCities();
  }
}
