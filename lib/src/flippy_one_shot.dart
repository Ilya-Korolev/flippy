import 'package:flippy/flippy.dart';
import 'package:flutter/material.dart';

import 'models/models.dart';
import 'utils/utils.dart';

class FlippyOneShot extends StatefulWidget {
  late final int count;
  late final Widget Function(BuildContext context, int index) widgetBuilder;
  late final FlippyTransition Function(int index) transitionBuilder;
  final double gap;
  final double perspective;

  FlippyOneShot.builder({
    required this.count,
    required this.widgetBuilder,
    required this.transitionBuilder,
    this.gap = 0.0,
    this.perspective = 0.0,
    Key? key,
  })  : assert(count >= 2),
        assert(gap >= 0),
        assert(perspective >= 0),
        super(key: key);

  FlippyOneShot.single({
    required Widget start,
    required Widget end,
    required FlippyTransition transition,
    this.gap = 0.0,
    this.perspective = 0.0,
    Key? key,
  })  : assert(gap >= 0),
        assert(perspective >= 0),
        super(key: key) {
    count = 2;
    widgetBuilder = (context, index) => index == 0 ? start : end;
    transitionBuilder = (index) => transition;
  }

  @override
  _FlippyOneShotState createState() => _FlippyOneShotState();
}

class _FlippyOneShotState extends State<FlippyOneShot> {
  late final FlippyController _flippyController;

  @override
  void initState() {
    super.initState();

    _flippyController = FlippyController(count: widget.count)..moveTo(widget.count - 1);
  }

  @override
  void dispose() {
    _flippyController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FlippyView.builder(
      gap: widget.gap,
      perspective: widget.perspective,
      flippyController: _flippyController,
      widgetBuilder: widget.widgetBuilder,
      transitionBuilder: widget.transitionBuilder,
    );
  }
}
