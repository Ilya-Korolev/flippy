import 'package:flip_clock/models/models.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'widgets.dart';

class Clock extends StatefulWidget {
  final double height;
  final double width;
  final double colonSize;
  final double digitSize;
  final double digitSpacing;
  final double digitPerspective;
  final double borderRadius;

  const Clock({
    required this.height,
    required this.width,
    required this.colonSize,
    required this.digitSize,
    required this.digitSpacing,
    required this.digitPerspective,
    required this.borderRadius,
    Key? key,
  }) : super(key: key);

  @override
  _ClockState createState() => _ClockState();
}

class _ClockState extends State<Clock> {
  late final ClockParams _clockParams;

  @override
  void initState() {
    _clockParams = ClockParams(
      height: widget.height,
      width: widget.width,
      colonSize: widget.colonSize,
      digitSize: widget.digitSize,
      digitSpacing: widget.digitSpacing,
      digitPerspective: widget.digitPerspective,
      borderRadius: widget.borderRadius,
    );

    super.initState();
  }

  @override
  void didUpdateWidget(covariant Clock oldWidget) {
    _clockParams
      ..height = widget.height
      ..width = widget.width
      ..colonSize = widget.colonSize
      ..digitSize = widget.digitSize
      ..digitSpacing = widget.digitSpacing
      ..digitPerspective = widget.digitPerspective
      ..borderRadius = widget.borderRadius;

    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    _clockParams.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: _clockParams,
      child: SizedBox(
        height: widget.height,
        width: widget.width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            ClockDigit(type: ClockDigitType.hourFirst),
            Spacer(flex: 3),
            ClockDigit(type: ClockDigitType.hourLast),
            Spacer(flex: 2),
            ClockColon(),
            Spacer(flex: 2),
            ClockDigit(type: ClockDigitType.minuteFirst),
            Spacer(flex: 3),
            ClockDigit(type: ClockDigitType.minuteLast),
            Spacer(flex: 2),
            ClockColon(),
            Spacer(flex: 2),
            ClockDigit(type: ClockDigitType.secondFirst),
            Spacer(flex: 3),
            ClockDigit(type: ClockDigitType.secondLast),
          ],
        ),
      ),
    );
  }
}
