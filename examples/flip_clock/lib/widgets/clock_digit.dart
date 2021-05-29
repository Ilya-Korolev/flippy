import 'package:flippy/flippy.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flip_clock/cubit/clock_cubit.dart';
import 'package:flip_clock/widgets/text_card.dart';

enum ClockDigitType {
  hourFirst,
  hourLast,
  minuteFirst,
  minuteLast,
  secondFirst,
  secondLast,
}

class ClockDigit extends StatefulWidget {
  final double size;
  final ClockDigitType type;
  final double spacing;
  final double perspective;
  final double borderRadius;

  const ClockDigit({
    required this.size,
    required this.type,
    this.spacing = 0.0,
    this.perspective = 0.0,
    this.borderRadius = 0.0,
    Key? key,
  }) : super(key: key);

  @override
  _ClockDigitState createState() => _ClockDigitState();
}

class _ClockDigitState extends State<ClockDigit> {
  late final FlippyController _flippyController;

  @override
  void initState() {
    _flippyController = FlippyController(count: 2);
    super.initState();
  }

  @override
  void dispose() {
    _flippyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ClockCubit, ClockState>(
      buildWhen: _buildWhen,
      builder: (context, state) {
        final currentDigit = _getDigit(state.time);

        if (state is ClockStopped) {
          return FlippyStatic(
            gap: widget.spacing,
            child: TextCard(
              text: currentDigit,
              textSize: widget.size,
              borderRadius: widget.borderRadius,
            ),
          );
        }

        final nextDigit = _getDigit(state.time.add(const Duration(seconds: 1)));

        _flippyController.setTo(0);
        _flippyController.moveNext();

        return FlippyView.builder(
          gap: widget.spacing,
          perspective: widget.perspective,
          flippyController: _flippyController,
          widgetBuilder: (context, index) {
            return index == 0
                ? TextCard(
                    text: currentDigit,
                    textSize: widget.size,
                    borderRadius: widget.borderRadius,
                  )
                : TextCard(
                    text: nextDigit,
                    textSize: widget.size,
                    borderRadius: widget.borderRadius,
                  );
          },
          transitionBuilder: (index) => const FlippyTransition(
            curve: Curves.decelerate,
            duration: Duration(seconds: 1),
          ),
        );
      },
    );
  }

  bool _buildWhen(ClockState previous, ClockState current) {
    final currentTime = current.time;
    final nextTime = current.time.add(Duration(seconds: 1));

    switch (widget.type) {
      case ClockDigitType.hourFirst:
        return currentTime.hour ~/ 10 != nextTime.hour ~/ 10;

      case ClockDigitType.hourLast:
        return currentTime.hour != nextTime.hour;

      case ClockDigitType.minuteFirst:
        return currentTime.minute ~/ 10 != nextTime.minute ~/ 10;

      case ClockDigitType.minuteLast:
        return currentTime.minute != nextTime.minute;

      case ClockDigitType.secondFirst:
        return currentTime.second ~/ 10 != nextTime.second ~/ 10;

      case ClockDigitType.secondLast:
        return currentTime.second != nextTime.second;
    }
  }

  String _getDigit(DateTime time) {
    switch (widget.type) {
      case ClockDigitType.hourFirst:
        return (time.hour ~/ 10).toString();

      case ClockDigitType.hourLast:
        return (time.hour % 10).toString();

      case ClockDigitType.minuteFirst:
        return (time.minute ~/ 10).toString();

      case ClockDigitType.minuteLast:
        return (time.minute % 10).toString();

      case ClockDigitType.secondFirst:
        return (time.second ~/ 10).toString();

      case ClockDigitType.secondLast:
        return (time.second % 10).toString();
    }
  }
}
