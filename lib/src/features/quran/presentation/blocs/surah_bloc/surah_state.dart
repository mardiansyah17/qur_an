part of 'surah_bloc.dart';

sealed class SurahState extends Equatable {
  const SurahState();

  @override
  List<Object> get props => [];
}

final class SurahInitial extends SurahState {}

final class SurahLoading extends SurahState {}

final class SurahLoaded extends SurahState {
  final List<Surah>? surah;
  final List<Surah>? surahFilterByName;

  const SurahLoaded({this.surah, this.surahFilterByName});
}
