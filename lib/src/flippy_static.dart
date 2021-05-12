import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'models/models.dart';
import 'widgets/widgets.dart';

class FlippyStatic extends StatefulWidget {
  final Widget child;
  final double gap;

  const FlippyStatic({
    required this.child,
    this.gap = 0.0,
    Key? key,
  })  : assert(gap >= 0),
        super(key: key);

  @override
  _FlippyStaticState createState() => _FlippyStaticState();
}

class _FlippyStaticState extends State<FlippyStatic> {
  late final GlobalParameters _globalParameters;

  @override
  void initState() {
    super.initState();

    _globalParameters = GlobalParameters(gap: widget.gap, perspective: 0.0);
  }

  @override
  void didUpdateWidget(covariant FlippyStatic oldWidget) {
    _globalParameters.update(
      gap: widget.gap,
      perspective: 0.0,
    );

    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    _globalParameters.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<GlobalParameters>.value(
      value: _globalParameters,
      child: StaticContainer(child: widget.child),
    );
  }
}
