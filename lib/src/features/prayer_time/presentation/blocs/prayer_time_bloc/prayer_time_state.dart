part of 'prayer_time_bloc.dart';

@immutable
sealed class PrayerTimeState {}

class PrayerTimeInitial extends PrayerTimeState {}

class PrayerTimeLoading extends PrayerTimeState {}

class LocationIsNotExist extends PrayerTimeState {}

class InternetIsNotConnected extends PrayerTimeState {}

class PrayerTimeLoaded extends PrayerTimeState {
  final DateTime date;
  final City city;
  final PrayerTime? prayerTime;
  final Map<String, String>? nextTime;
  final Map<String, String>? isyaTime;

  PrayerTimeLoaded({
    required this.date,
    required this.city,
    this.prayerTime,
    this.nextTime,
    this.isyaTime,
  });
}
