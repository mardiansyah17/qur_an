import 'package:dartz/dartz.dart';
import 'package:qur_an/src/core/errors/failures.dart';
import 'package:qur_an/src/features/quran/domain/entities/ayat.dart';
import 'package:qur_an/src/features/quran/domain/entities/surah.dart';

abstract interface class AlQuranRepository {
  Future<Either<Failure, List<Surah>>> getAllSurah();

  Future<Either<Failure, List<Ayat>>> getAyatBySurah(String surat,
      {int lastAyat});
}
