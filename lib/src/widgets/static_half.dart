import 'package:flutter/material.dart';

import '../models/models.dart';

class StaticHalf extends StatelessWidget {
  final HalfType type;
  final Widget child;

  const StaticHalf({required this.type, required this.child});

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: Align(
        alignment: type == HalfType.top ? Alignment.topCenter : Alignment.bottomCenter,
        heightFactor: 0.5,
        child: child,
      ),
    );
  }
}
