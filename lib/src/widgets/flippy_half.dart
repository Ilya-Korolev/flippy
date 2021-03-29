import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../utils/utils.dart';
import '../models/models.dart';

class FlippyHalf extends StatelessWidget {
  final Animation<double> animation;
  final Widget current;
  final Widget next;
  final HalfType type;

  const FlippyHalf({
    required this.animation,
    required this.current,
    required this.next,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        _StaticHalf(
          type: type,
          child: type == HalfType.top ? next : current,
        ),
        _AnimatedHalf(
          animation: animation,
          type: type,
          child: type == HalfType.top ? current : next,
        ),
      ],
    );
  }
}

class _StaticHalf extends StatelessWidget {
  final HalfType type;
  final Widget child;

  const _StaticHalf({required this.type, required this.child});

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

class _AnimatedHalf extends StatelessWidget {
  final Animation<double> _animation;
  final Widget child;
  final HalfType type;

  const _AnimatedHalf({
    required Animation<double> animation,
    required this.child,
    required this.type,
  }) : _animation = animation;

  @override
  Widget build(BuildContext context) {
    final params = context.read<GlobalParameters>();
    final calculation = HalfCalculation(gap: params.gap, perspective: params.perspective, type: type);

    return AnimatedBuilder(
      animation: _animation,
      child: _StaticHalf(type: type, child: child),
      builder: (context, builderChild) {
        calculation.update(_animation.value);

        return Visibility(
          visible: calculation.isVisible,
          child: Transform(
            transform: Matrix4.identity()
              ..translate(0.0, calculation.offset)
              ..setEntry(3, 2, calculation.perspective)
              ..rotateX(calculation.degree),
            alignment: calculation.alignment,
            child: builderChild,
          ),
        );
      },
    );
  }
}
