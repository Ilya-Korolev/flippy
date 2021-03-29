import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'widgets.dart';
import '../models/models.dart';

class FlippyContainer extends StatelessWidget {
  final Widget current;
  final Widget next;
  final Animation<double> animation;

  const FlippyContainer({
    required this.current,
    required this.next,
    required this.animation,
  });

  @override
  Widget build(BuildContext context) {
    final params = context.read<GlobalParameters>();

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        FlippyHalf(
          animation: animation,
          current: current,
          next: next,
          type: HalfType.top,
        ),
        SizedBox(height: params.gap),
        FlippyHalf(
          animation: animation,
          current: current,
          next: next,
          type: HalfType.bottom,
        ),
      ],
    );
  }
}
