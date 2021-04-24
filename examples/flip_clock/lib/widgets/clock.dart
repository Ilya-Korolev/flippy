import 'package:flutter/material.dart';

import 'widgets.dart';

class Clock extends StatelessWidget {
  const Clock({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: const [
        ClockDigit(type: ClockDigitType.hourFirst),
        SizedBox(width: 25.0),
        ClockDigit(type: ClockDigitType.hourLast),
        SizedBox(width: 17.5),
        ClockColon(),
        SizedBox(width: 17.5),
        ClockDigit(type: ClockDigitType.minuteFirst),
        SizedBox(width: 25.0),
        ClockDigit(type: ClockDigitType.minuteLast),
        SizedBox(width: 17.5),
        ClockColon(),
        SizedBox(width: 17.5),
        ClockDigit(type: ClockDigitType.secondFirst),
        SizedBox(width: 25.0),
        ClockDigit(type: ClockDigitType.secondLast),
      ],
    );
  }
}
