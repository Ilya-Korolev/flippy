import 'package:flutter/material.dart';

import 'widgets/widgets.dart';

class FlippyStatic extends StatelessWidget {
  final Widget child;
  final double gap;

  const FlippyStatic({
    required this.child,
    this.gap = 0.0,
    Key? key,
  })  : assert(gap >= 0),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return StaticSplit(child: child, spacing: gap);
  }
}
