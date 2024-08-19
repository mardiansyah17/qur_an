import 'package:dartz/dartz.dart';
import 'package:qur_an/src/core/errors/failures.dart';
import 'package:qur_an/src/features/prayer_time/domain/entities/prayer_time.dart';

abstract interface class PrayerTimeRepository {
  Future<Either<Failure, PrayerTime>> getPrayerTime(String city, String date);
}
