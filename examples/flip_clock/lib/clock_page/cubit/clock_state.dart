part of 'clock_cubit.dart';

abstract class ClockState extends Equatable {
  final DateTime time;

  ClockState(this.time);

  @override
  List<Object?> get props => [time];
}

class ClockStopped extends ClockState {
  ClockStopped(DateTime time) : super(time);
}

class ClockRunInProgress extends ClockState {
  ClockRunInProgress(DateTime time) : super(time);
}
