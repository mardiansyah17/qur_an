import 'package:dartz/dartz.dart';
import 'package:qur_an/src/core/errors/failures.dart';
import 'package:qur_an/src/core/usecase/usecase.dart';
import 'package:qur_an/src/features/prayer_time/domain/entities/prayer_time.dart';
import 'package:qur_an/src/features/prayer_time/domain/repositories/prayer_time_repository.dart';

class GetPrayerTime implements UseCase<PrayerTime, GetPrayerTimeParams> {
  final PrayerTimeRepository repository;

  GetPrayerTime(this.repository);

  @override
  Future<Either<Failure, PrayerTime>> call(GetPrayerTimeParams params) async {
    return await repository.getPrayerTime(params.city, params.date);
  }
}

class GetPrayerTimeParams {
  final String city;
  final String date;

  GetPrayerTimeParams({required this.city, required this.date});
}
