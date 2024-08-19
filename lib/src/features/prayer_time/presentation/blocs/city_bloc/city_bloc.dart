import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:qur_an/src/core/usecase/usecase.dart';
import 'package:qur_an/src/features/prayer_time/domain/entities/city.dart';
import 'package:qur_an/src/features/prayer_time/domain/usecases/get_cities.dart';

part 'city_event.dart';
part 'city_state.dart';

class CityBloc extends Bloc<CityEvent, CityState> {
  final GetCities _getCities;
  List<City> _cities = [];
  CityBloc({required GetCities getCities})
      : _getCities = getCities,
        super(CityInitial()) {
    on<CityEvent>((event, emit) {
      emit(CityLoading());
    });
    on<LoadedCities>(_onLoadCities);
    on<SearchCityByQuery>(_onSearchCityByQuery);
  }

  void _onSearchCityByQuery(
    SearchCityByQuery event,
    Emitter<CityState> emit,
  ) {
    final filteredCities = _cities
        .where((element) =>
            element.name.toLowerCase().contains(event.query.toLowerCase()))
        .toList();
    emit(CityLoaded(filteredCities));
  }

  Future<void> _onLoadCities(
    LoadedCities event,
    Emitter<CityState> emit,
  ) async {
    final cities = await _getCities(NoParams());
    cities.fold((l) {
      log("ada error ${l.errorMessage}");
    }, (r) {
      _cities.addAll(r);
      emit(CityLoaded(r));
    });
  }
}
