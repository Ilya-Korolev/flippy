import 'package:flippy/src/widgets/widgets.dart';
import 'package:flutter/material.dart';

class FlippyStatic extends StatelessWidget {
  final Widget child;
  final double spacing;

  const FlippyStatic({
    required this.child,
    this.spacing = 0.0,
    Key? key,
  })  : assert(spacing >= 0),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Split(child: child, spacing: spacing);
  }
}
