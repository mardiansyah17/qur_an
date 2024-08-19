part of 'ayat_bloc.dart';

sealed class AyatEvent extends Equatable {
  const AyatEvent();

  @override
  List<Object> get props => [];
}

final class ResetAyat extends AyatEvent {}

final class GetAyatBySurah extends AyatEvent {
  final String surat;
  final int? lastAyat;

  const GetAyatBySurah({required this.surat, this.lastAyat});
}
