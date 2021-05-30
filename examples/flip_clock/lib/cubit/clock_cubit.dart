import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flip_clock/utils/utils.dart';

part 'clock_state.dart';

class ClockCubit extends Cubit<ClockState> {
  Clockwork _clockwork;
  StreamSubscription<DateTime>? _clockSubscription;

  ClockCubit({required Clockwork clockwork})
      : _clockwork = clockwork,
        super(ClockStopped(DateTime.now()));

  void _tick(DateTime time) => emit(ClockRunInProgress(time));

  void wind(DateTime initial) {
    _clockSubscription?.cancel();
    _clockSubscription = _clockwork.wind(initial).listen((time) {
      _tick(time);
    });
  }

  void stop() {
    _clockSubscription?.cancel();
    emit(ClockStopped(state.time));
  }

  @override
  Future<void> close() {
    _clockSubscription?.cancel();
    return super.close();
  }
}
