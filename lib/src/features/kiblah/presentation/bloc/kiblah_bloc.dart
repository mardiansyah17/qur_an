import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'kiblah_event.dart';
part 'kiblah_state.dart';

class KiblahBloc extends Bloc<KiblahEvent, KiblahState> {
  KiblahBloc() : super(KiblahInitial()) {
    on<KiblahEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
