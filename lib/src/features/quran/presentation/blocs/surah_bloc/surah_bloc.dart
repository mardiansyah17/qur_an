import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:qur_an/src/core/usecase/usecase.dart';
import 'package:qur_an/src/features/quran/domain/entities/surah.dart';
import 'package:qur_an/src/features/quran/domain/usecases/get_all_surah.dart';

part 'surah_event.dart';
part 'surah_state.dart';

class SurahBloc extends Bloc<SurahEvent, SurahState> {
  final GetAllSurah getAllSurah;
  SurahBloc({required this.getAllSurah}) : super(SurahInitial()) {
    on<SurahEvent>((event, emit) {
      // emit(SurahLoading());
    });

    on<GetSurah>(_onLoadSurah);
    on<SearchSurah>(_onSearchSurah);
  }

  void _onSearchSurah(
    SearchSurah event,
    Emitter<SurahState> emit,
  ) async {
    final currentState = state;
    if (currentState is SurahLoaded) {
      emit(SurahLoading());
      log('mantap');
      final List<Surah> filteredSurah = event.name.isEmpty
          ? currentState.surah!
          : currentState.surah!
              .where((element) =>
                  element.name.toLowerCase().contains(event.name.toLowerCase()))
              .toList();
      log('Filtered Surah count: ${filteredSurah.length}');
      emit(SurahLoaded(
          surah: currentState.surah, surahFilterByName: filteredSurah));
    }
  }

  void _onLoadSurah(
    GetSurah event,
    Emitter<SurahState> emit,
  ) async {
    emit(SurahLoading());
    final surah = await getAllSurah(NoParams());
    surah.fold((l) {
      print("ada error ${l.errorMessage}");
    }, (r) {
      emit(SurahLoaded(surah: r));
    });
  }
}
