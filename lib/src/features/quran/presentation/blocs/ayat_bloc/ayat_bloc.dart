import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:qur_an/src/features/quran/domain/entities/ayat.dart';
import 'package:qur_an/src/features/quran/domain/usecases/get_list_ayat_by_surah.dart';

part 'ayat_event.dart';
part 'ayat_state.dart';

class AyatBloc extends Bloc<AyatEvent, AyatState> {
  final GetListAyatBySurah getAllAyatBySurah;
  AyatBloc({required this.getAllAyatBySurah}) : super(AyatInitial()) {
    on<AyatEvent>((event, emit) {});
    on<ResetAyat>((event, emit) {
      emit(AyatInitial());
    });
    on<GetAyatBySurah>((event, emit) async {
      final currentState = state;

      if (currentState is AyatLoaded && event.lastAyat != null) {
        emit(AyatLoadingPagination());

        final response = await getAllAyatBySurah(ParamGetAyatBySurah(
            surat: event.surat, lastAyat: event.lastAyat! + 1));

        response.fold((l) => log(l.errorMessage), (r) {
          emit(AyatLoaded(
            ayat: r,
          ));
        });
        return;
      }
      if (state is AyatInitial) {
        emit(AyatLoading());
        final response = await getAllAyatBySurah(
            ParamGetAyatBySurah(surat: event.surat, lastAyat: 1));

        response.fold((l) => log(l.errorMessage), (r) {
          emit(AyatLoaded(ayat: r));
        });
        return;
      }
    });
  }
}
