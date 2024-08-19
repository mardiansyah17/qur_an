part of 'prayer_time_bloc.dart';

@immutable
sealed class PrayerTimeEvent {}

final class LoadPrayerTime extends PrayerTimeEvent {
  final String date;

  LoadPrayerTime({required this.date});
}

final class UpdateNextTime extends PrayerTimeEvent {}
