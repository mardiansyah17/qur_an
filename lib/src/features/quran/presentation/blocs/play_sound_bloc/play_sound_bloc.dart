import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:just_audio/just_audio.dart';

part 'play_sound_event.dart';
part 'play_sound_state.dart';

class PlaySoundBloc extends Bloc<PlaySoundEvent, PlaySoundState> {
  PlaySoundBloc() : super(PlaySoundInitial()) {
    final AudioPlayer player = AudioPlayer();
    on<PlaySoundEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<StopAyat>(
      (event, emit) {
        player.stop();
        emit(PlaySoundInitial());
      },
    );
    on<PlayAyat>((event, emit) async {
      emit(PlaySoundLoading(id: event.id));
      if (player.playing) {
        player.stop();
      }
      await player.setUrl(event.url);
      player.play();
      player.playerStateStream.listen((event) {
        if (event.processingState == ProcessingState.completed) {
          add(StopAyat());
        }
      });
      emit(PlayingAyat(id: event.id));
    });
  }
}
