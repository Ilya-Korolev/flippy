import 'package:equatable/equatable.dart';

class ClockTime extends Equatable {
  final int firstDigitOfHour;
  final int lastDigitOfHour;
  final int firstDigitOfMinute;
  final int lastDigitOfMinute;
  final int firstDigitOfSecond;
  final int lastDigitOfSecond;

  ClockTime({
    required this.firstDigitOfHour,
    required this.lastDigitOfHour,
    required this.firstDigitOfMinute,
    required this.lastDigitOfMinute,
    required this.firstDigitOfSecond,
    required this.lastDigitOfSecond,
  });

  factory ClockTime.fromDateTime(DateTime dateTime) {
    final hour = dateTime.hour;
    final minute = dateTime.minute;
    final second = dateTime.second;

    return ClockTime(
      firstDigitOfHour: hour ~/ 10,
      lastDigitOfHour: hour % 10,
      firstDigitOfMinute: minute ~/ 10,
      lastDigitOfMinute: minute % 10,
      firstDigitOfSecond: second ~/ 10,
      lastDigitOfSecond: second % 10,
    );
  }

  factory ClockTime.now() => ClockTime.fromDateTime(DateTime.now());

  ClockTime next() {
    final int lastDigitOfSecond;
    final int firstDigitOfSecond;
    final int lastDigitOfMinute;
    final int firstDigitOfMinute;
    final int lastDigitOfHour;
    final int firstDigitOfHour;

    return ClockTime(
      firstDigitOfHour: this.firstDigitOfHour,
      lastDigitOfHour: this.lastDigitOfHour,
      firstDigitOfMinute: this.firstDigitOfMinute,
      lastDigitOfMinute: this.lastDigitOfMinute,
      firstDigitOfSecond: this.firstDigitOfSecond,
      lastDigitOfSecond: this.lastDigitOfSecond,
    );
  }

  @override
  List<Object?> get props => [
        firstDigitOfHour,
        lastDigitOfHour,
        firstDigitOfMinute,
        lastDigitOfMinute,
        firstDigitOfSecond,
        lastDigitOfSecond,
      ];
}
