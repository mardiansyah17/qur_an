import 'package:dartz/dartz.dart';
import 'package:qur_an/src/core/errors/failures.dart';
import 'package:qur_an/src/core/usecase/usecase.dart';
import 'package:qur_an/src/features/quran/domain/entities/surah.dart';
import 'package:qur_an/src/features/quran/domain/repositories/al_quran_repository.dart';

class GetAllSurah implements UseCase<List<Surah>, NoParams> {
  final AlQuranRepository repository;

  GetAllSurah(this.repository);

  @override
  Future<Either<Failure, List<Surah>>> call(NoParams params) {
    return repository.getAllSurah();
  }
}
