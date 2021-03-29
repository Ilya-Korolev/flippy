import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'widgets/widgets.dart';
import 'models/models.dart';

class FlippyOneShot extends StatefulWidget {
  final Widget current;
  final Widget next;
  final Transition transition;
  final double gap;
  final double perspective;

  const FlippyOneShot({
    required this.current,
    required this.next,
    this.transition = const Transition.basic(),
    this.gap = 0.0,
    this.perspective = 0.0,
  });

  @override
  _FlippyOneShotState createState() => _FlippyOneShotState();
}

class _FlippyOneShotState extends State<FlippyOneShot> with TickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: widget.transition.duration,
      vsync: this,
    )..repeat();

    final curved = CurvedAnimation(parent: _controller, curve: widget.transition.curve);
    final directed = widget.transition.direction == FlipDirection.forward ? curved : ReverseAnimation(curved);

    final tween = Tween<double>(
      begin: 0.0,
      end: math.pi,
    ).animate(directed);

    _animation = tween;
  }

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (context) => GlobalParameters(gap: widget.gap, perspective: widget.perspective),
      child: FlippyContainer(
        animation: _animation,
        current: widget.transition.direction == FlipDirection.forward ? widget.current : widget.next,
        next: widget.transition.direction == FlipDirection.forward ? widget.next : widget.current,
      ),
    );
  }
}
