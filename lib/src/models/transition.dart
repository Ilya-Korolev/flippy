import 'package:flutter/material.dart';

import 'models.dart';

class Transition {
  final FlipDirection direction;
  final Curve curve;
  final Duration duration;

  const Transition({
    this.direction = FlipDirection.forward,
    this.curve = Curves.linear,
    this.duration = const Duration(seconds: 1),
  });

  const Transition.basic() : this();
}
