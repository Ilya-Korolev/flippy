import 'package:flippy/flippy.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flip_clock/cubit/clock_cubit.dart';
import 'package:flip_clock/widgets/text_card.dart';

import '../constants.dart' as constants;

enum ClockPartType {
  hourFirstDigit,
  hourLastDigit,
  minuteFirstDigit,
  minuteLastDigit,
  secondFirstDigit,
  secondLastDigit,
}

class ClockPart extends StatefulWidget {
  final ClockPartType type;

  const ClockPart({
    required this.type,
    Key? key,
  }) : super(key: key);

  @override
  _ClockPartState createState() => _ClockPartState();
}

class _ClockPartState extends State<ClockPart> {
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
        final currentPartOfTime = _timeToString(state.time);

        if (state is ClockStopped) {
          return FlippyStatic(
            gap: constants.kGap,
            perspective: constants.kPerspective,
            child: TextCard(text: currentPartOfTime),
          );
        }

        final nextPartOfTime = _timeToString(state.time.add(const Duration(seconds: 1)));

        _flippyController.setTo(0);
        _flippyController.moveNext();

        return FlippyView.builder(
          gap: constants.kGap,
          perspective: constants.kPerspective,
          flippyController: _flippyController,
          widgetBuilder: (context, index) =>
              index == 0 ? TextCard(text: currentPartOfTime) : TextCard(text: nextPartOfTime),
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
      case ClockPartType.hourFirstDigit:
        return currentTime.hour ~/ 10 != nextTime.hour ~/ 10;

      case ClockPartType.hourLastDigit:
        return currentTime.hour != nextTime.hour;

      case ClockPartType.minuteFirstDigit:
        return currentTime.minute ~/ 10 != nextTime.minute ~/ 10;

      case ClockPartType.minuteLastDigit:
        return currentTime.minute != nextTime.minute;

      case ClockPartType.secondFirstDigit:
        return currentTime.second ~/ 10 != nextTime.second ~/ 10;

      case ClockPartType.secondLastDigit:
        return currentTime.second != nextTime.second;
    }
  }

  String _timeToString(DateTime time) {
    switch (widget.type) {
      case ClockPartType.hourFirstDigit:
        return (time.hour ~/ 10).toString();

      case ClockPartType.hourLastDigit:
        return (time.hour % 10).toString();

      case ClockPartType.minuteFirstDigit:
        return (time.minute ~/ 10).toString();

      case ClockPartType.minuteLastDigit:
        return (time.minute % 10).toString();

      case ClockPartType.secondFirstDigit:
        return (time.second ~/ 10).toString();

      case ClockPartType.secondLastDigit:
        return (time.second % 10).toString();
    }
  }
}
