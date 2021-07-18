import 'package:flutter/material.dart';

import 'widgets.dart';

class Clock extends StatelessWidget {
  final double height;
  final double width;
  final double colonSize;
  final double fontSize;
  final double cardSpacing;
  final double perspective;
  final double borderRadius;

  const Clock({
    required this.height,
    required this.width,
    required this.colonSize,
    required this.fontSize,
    required this.cardSpacing,
    required this.perspective,
    required this.borderRadius,
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
            type: ClockDigitType.hourFirst,
            fontSize: fontSize,
            perspective: perspective,
            spacing: cardSpacing,
            borderRadius: borderRadius,
          ),
          Spacer(flex: 3),
          ClockDigit(
            type: ClockDigitType.hourLast,
            fontSize: fontSize,
            perspective: perspective,
            spacing: cardSpacing,
            borderRadius: borderRadius,
          ),
          Spacer(flex: 2),
          ClockColon(size: colonSize),
          Spacer(flex: 2),
          ClockDigit(
            type: ClockDigitType.minuteFirst,
            fontSize: fontSize,
            perspective: perspective,
            spacing: cardSpacing,
            borderRadius: borderRadius,
          ),
          Spacer(flex: 3),
          ClockDigit(
            type: ClockDigitType.minuteLast,
            fontSize: fontSize,
            perspective: perspective,
            spacing: cardSpacing,
            borderRadius: borderRadius,
          ),
          Spacer(flex: 2),
          ClockColon(size: colonSize),
          Spacer(flex: 2),
          ClockDigit(
            type: ClockDigitType.secondFirst,
            fontSize: fontSize,
            perspective: perspective,
            spacing: cardSpacing,
            borderRadius: borderRadius,
          ),
          Spacer(flex: 3),
          ClockDigit(
            type: ClockDigitType.secondLast,
            fontSize: fontSize,
            perspective: perspective,
            spacing: cardSpacing,
            borderRadius: borderRadius,
          ),
        ],
      ),
    );
  }
}
