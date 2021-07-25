import 'package:flippy/flippy.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/clock_cubit.dart';
import 'widgets.dart';

enum ClockDigitType {
  hourFirst,
  hourLast,
  minuteFirst,
  minuteLast,
  secondFirst,
  secondLast,
}

class ClockDigit extends StatefulWidget {
  final ClockDigitType type;
  final double spacing;
  final double? fontSize;
  final double borderRadius;
  final double perspective;

  const ClockDigit({
    required this.type,
    this.spacing = 0.0,
    this.fontSize,
    this.borderRadius = 0.0,
    this.perspective = 0.0,
    Key? key,
  }) : super(key: key);

  @override
  _ClockDigitState createState() => _ClockDigitState();
}

class _ClockDigitState extends State<ClockDigit> {
  late final FlippySimpleController _flippyController;

  @override
  void initState() {
    _flippyController = FlippySimpleController();
    super.initState();
  }

  @override
  void dispose() {
    _flippyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ClockCubit, ClockState>(
      listenWhen: (previous, current) => _isDigitChanged(current.time),
      listener: (context, state) {
        _flippyController.setTo(0);
        _flippyController.toNext();
      },
      buildWhen: (previous, current) => _isDigitChanged(current.time),
      builder: (context, state) {
        final currentDigit = _getDigit(state.time).toString();

        if (state is ClockStopped) {
          return Split(
            spacing: widget.spacing,
            child: DigitCard(
              text: currentDigit,
              fontSize: widget.fontSize,
              borderRadius: widget.borderRadius,
            ),
          );
        }

        final nextDigit = _getDigit(state.time.add(const Duration(seconds: 1))).toString();

        return FlippyView.builder(
          spacing: widget.spacing,
          perspective: widget.perspective,
          flippyController: _flippyController,
          widgetBuilder: (context, index) => DigitCard(
            text: index == 0 ? currentDigit : nextDigit,
            fontSize: widget.fontSize,
            borderRadius: widget.borderRadius,
          ),
          transitionBuilder: (index) => const FlippyTransition(
            curve: Curves.decelerate,
            duration: Duration(milliseconds: 700),
          ),
        );
      },
    );
  }

  bool _isDigitChanged(DateTime currentTime) {
    final nextTime = currentTime.add(const Duration(seconds: 1));

    return _getDigit(currentTime) != _getDigit(nextTime);
  }

  int _getDigit(DateTime time) {
    switch (widget.type) {
      case ClockDigitType.hourFirst:
        return time.hour ~/ 10;

      case ClockDigitType.hourLast:
        return time.hour % 10;

      case ClockDigitType.minuteFirst:
        return time.minute ~/ 10;

      case ClockDigitType.minuteLast:
        return time.minute % 10;

      case ClockDigitType.secondFirst:
        return time.second ~/ 10;

      case ClockDigitType.secondLast:
        return time.second % 10;
    }
  }
}
