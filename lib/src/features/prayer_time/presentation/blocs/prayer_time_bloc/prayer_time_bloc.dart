import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:qur_an/src/features/prayer_time/domain/entities/city.dart';
import 'package:qur_an/src/features/prayer_time/domain/entities/prayer_time.dart';
import 'package:qur_an/src/features/prayer_time/domain/usecases/get_prayer_time.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'prayer_time_event.dart';
part 'prayer_time_state.dart';

class PrayerTimeBloc extends Bloc<PrayerTimeEvent, PrayerTimeState> {
  final GetPrayerTime _getPrayerTime;

  PrayerTimeBloc({required GetPrayerTime getPrayerTime})
      : _getPrayerTime = getPrayerTime,
        super(PrayerTimeInitial()) {
    on<PrayerTimeEvent>((event, emit) {});
    on<LoadPrayerTime>(_onLoadPrayerTime);
    on<UpdateNextTime>((event, emit) {
      if (state is PrayerTimeLoaded) {
        emit(PrayerTimeLoaded(
          date: (state as PrayerTimeLoaded).date,
          city: (state as PrayerTimeLoaded).city,
          prayerTime: (state as PrayerTimeLoaded).prayerTime,
          nextTime: _getNextTime((state as PrayerTimeLoaded).prayerTime!),
        ));
      }
    });
  }

  Future<void> _onLoadPrayerTime(
    LoadPrayerTime event,
    Emitter<PrayerTimeState> emit,
  ) async {
    emit(PrayerTimeLoading());
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final cityId = prefs.getString('cityId');
    final cityName = prefs.getString('cityName');

    if (cityName == null || cityId == null) {
      return emit(LocationIsNotExist());
    }
    final bool checkInternetConnection =
        await InternetConnectionChecker().hasConnection;

    if (!checkInternetConnection) {
      return emit(InternetIsNotConnected());
    }
    final date = event.date;

    final DateTime dateTime = DateTime.parse(date);

    final failureOrPrayerTime =
        await _getPrayerTime(GetPrayerTimeParams(city: cityId, date: date));
    failureOrPrayerTime.fold((l) {
      log("ada error ${l.errorMessage}");
    }, (r) {
      emit(PrayerTimeLoaded(
        city: City(id: cityId, name: cityName),
        date: dateTime,
        prayerTime: r,
        nextTime: _getNextTime(r),
      ));
    });
  }

  Map<String, String>? _getNextTime(PrayerTime prayerTime) {
    DateTime now = DateTime.now();
    late List result = [];
    prayerTime.toMap().forEach((key, item) {
      int jam = int.parse(item.split(":")[0]);
      int menit = int.parse(item.split(":")[1]);
      DateTime waktuSholat = DateTime(now.year, now.month, now.day, jam, menit);

      if (now.isBefore(waktuSholat)) {
        result.add({key: item});
      }
    });

    return result.firstOrNull;
  }
}
