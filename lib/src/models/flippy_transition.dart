import 'package:flutter/material.dart';

import 'models.dart';

class FlippyTransition {
  final FlipDirection direction;
  final Curve curve;
  final Duration duration;

  const FlippyTransition({
    this.direction = FlipDirection.forward,
    this.curve = Curves.linear,
    this.duration = const Duration(seconds: 1),
  });

  FlippyTransition reversed() {
    final direction = this.direction == FlipDirection.forward ? FlipDirection.backward : FlipDirection.forward;

    return FlippyTransition(
      direction: direction,
      curve: this.curve,
      duration: this.duration,
    );
  }

  const FlippyTransition.basic() : this();
}
