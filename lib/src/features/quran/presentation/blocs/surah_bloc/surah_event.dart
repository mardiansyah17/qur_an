part of 'surah_bloc.dart';

sealed class SurahEvent extends Equatable {
  const SurahEvent();

  @override
  List<Object> get props => [];
}

final class GetSurah extends SurahEvent {}

final class SearchSurah extends SurahEvent {
  final String name;

  const SearchSurah({required this.name});
}
