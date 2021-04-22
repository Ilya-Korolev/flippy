import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'models/models.dart';
import 'widgets/widgets.dart';

class FlippyStatic extends StatelessWidget {
  final Widget child;
  final double gap;
  final double perspective;

  const FlippyStatic({
    required this.child,
    this.gap = 0.0,
    this.perspective = 0.0,
    Key? key,
  })  : assert(gap >= 0),
        assert(perspective >= 0),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Provider<GlobalParameters>(
      create: (context) => GlobalParameters(gap: gap, perspective: perspective),
      child: StaticContainer(child: child),
    );
  }
}
