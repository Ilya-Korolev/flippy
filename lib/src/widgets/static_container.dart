import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'widgets.dart';
import '../models/models.dart';

class StaticContainer extends StatelessWidget {
  final Widget child;

  const StaticContainer({
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final params = context.read<GlobalParameters>();

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        StaticHalf(
          child: child,
          type: HalfType.top,
        ),
        SizedBox(height: params.gap),
        StaticHalf(
          child: child,
          type: HalfType.bottom,
        ),
      ],
    );
  }
}
