import 'package:flippy/flippy.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../cubit/clock_cubit.dart';
import '../models/models.dart';
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

  const ClockDigit({
    required this.type,
    Key? key,
  }) : super(key: key);

  @override
  _ClockDigitState createState() => _ClockDigitState();
}

class _ClockDigitState extends State<ClockDigit> {
  late final FlippyCountedController _flippyController;

  @override
  void initState() {
    _flippyController = FlippyCountedController();
    super.initState();
  }

  @override
  void dispose() {
    _flippyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ClockParams>(
      builder: (context, params, _) => BlocBuilder<ClockCubit, ClockState>(
        buildWhen: (previous, current) {
          final currentTime = current.time;
          final nextTime = current.time.add(const Duration(seconds: 1));

          return _getDigit(currentTime) != _getDigit(nextTime);
        },
        builder: (context, state) {
          final currentDigit = _getDigit(state.time).toString();

          if (state is ClockStopped) {
            return Split(
              spacing: params.digitSpacing,
              child: DigitCard(text: currentDigit),
            );
          }

          final nextDigit = _getDigit(state.time.add(const Duration(seconds: 1))).toString();

          _flippyController.setTo(0);
          _flippyController.toNext();

          return FlippyView.builder(
            spacing: params.digitSpacing,
            perspective: params.digitPerspective,
            flippyController: _flippyController,
            widgetBuilder: (context, index) => DigitCard(text: index == 0 ? currentDigit : nextDigit),
            transitionBuilder: (index) => const FlippyTransition(
              curve: Curves.decelerate,
              duration: Duration(seconds: 1),
            ),
          );
        },
      ),
    );
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
