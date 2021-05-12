import 'package:flutter/material.dart';

import 'widgets.dart';

class Clock extends StatelessWidget {
  final double height;
  final double width;
  final double colonSize;
  final double digitSize;
  final double digitSpacing;
  final double digitPerspective;

  const Clock({
    required this.height,
    required this.width,
    required this.colonSize,
    required this.digitSize,
    this.digitSpacing = 0.0,
    this.digitPerspective = 0.0,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          ClockDigit(
            size: digitSize,
            spacing: digitSpacing,
            perspective: digitPerspective,
            type: ClockDigitType.hourFirst,
          ),
          Spacer(flex: 3),
          ClockDigit(
            size: digitSize,
            spacing: digitSpacing,
            perspective: digitPerspective,
            type: ClockDigitType.hourLast,
          ),
          Spacer(flex: 2),
          ClockColon(size: colonSize),
          Spacer(flex: 2),
          ClockDigit(
            size: digitSize,
            spacing: digitSpacing,
            perspective: digitPerspective,
            type: ClockDigitType.minuteFirst,
          ),
          Spacer(flex: 3),
          ClockDigit(
            size: digitSize,
            spacing: digitSpacing,
            perspective: digitPerspective,
            type: ClockDigitType.minuteLast,
          ),
          Spacer(flex: 2),
          ClockColon(size: colonSize),
          Spacer(flex: 2),
          ClockDigit(
            size: digitSize,
            spacing: digitSpacing,
            perspective: digitPerspective,
            type: ClockDigitType.secondFirst,
          ),
          Spacer(flex: 3),
          ClockDigit(
            size: digitSize,
            spacing: digitSpacing,
            perspective: digitPerspective,
            type: ClockDigitType.secondLast,
          ),
        ],
      ),
    );
  }
}
