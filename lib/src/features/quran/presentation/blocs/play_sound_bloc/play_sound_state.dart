part of 'play_sound_bloc.dart';

sealed class PlaySoundState extends Equatable {
  const PlaySoundState();

  @override
  List<Object> get props => [];
}

final class PlaySoundInitial extends PlaySoundState {}

final class PlaySoundLoading extends PlaySoundState {
  final String id;

  const PlaySoundLoading({required this.id});
}

final class PlayingAyat extends PlaySoundState {
  final String id;

  const PlayingAyat({required this.id});
}

final class AyatStoped extends PlaySoundState {
  // final String id;
  // const AyatStoped({required this.id});
}
