import 'dart:math' as math;

import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

class Split extends SingleChildRenderObjectWidget {
  final Widget child;
  final double spacing;

  const Split({
    required this.child,
    this.spacing = 0.0,
    Key? key,
  });

  @override
  RenderObject createRenderObject(BuildContext context) {
    return RenderSplit(spacing: spacing);
  }

  @override
  void updateRenderObject(BuildContext context, RenderSplit renderObject) {
    renderObject..spacing = spacing;
  }
}

class RenderSplit extends RenderShiftedBox {
  RenderSplit({
    double spacing = 0.0,
  })  : _spacing = spacing,
        super(null);

  double _spacing;

  double get spacing => _spacing;
  set spacing(double value) {
    if (value == _spacing) {
      return;
    }

    _spacing = value;
    markNeedsPaint();
  }

  @override
  Size computeDryLayout(BoxConstraints constraints) {
    return _performLayout(constraints: constraints, dry: true);
  }

  @override
  void performLayout() {
    size = _performLayout(constraints: constraints, dry: false);
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    if (child == null || constraints.maxHeight < spacing) {
      return;
    }

    final halfWidth = child!.size.width;
    final halfHeight = child!.size.height / 2.0;

    final firstHalfRect = Rect.fromLTWH(
      offset.dx,
      offset.dy,
      halfWidth,
      halfHeight,
    );

    final secondHalfRect = Rect.fromLTWH(
      offset.dx,
      offset.dy + halfHeight + spacing,
      halfWidth,
      halfHeight,
    );

    context.clipRectAndPaint(
      firstHalfRect,
      Clip.hardEdge,
      firstHalfRect,
      () => context.paintChild(child!, offset),
    );

    context.clipRectAndPaint(
      secondHalfRect,
      Clip.hardEdge,
      secondHalfRect,
      () => context.paintChild(child!, Offset(offset.dx, offset.dy + spacing)),
    );
  }

  Size _performLayout({required BoxConstraints constraints, required bool dry}) {
    if (child == null || constraints.maxHeight < spacing) {
      return const Size(0.0, 0.0);
    }

    final maxHeight = constraints.maxHeight - spacing;
    final childConstraints = constraints.copyWith(
      maxHeight: maxHeight,
      minHeight: math.min(constraints.minHeight, maxHeight),
    );

    final childSize = _performChildLayout(constraints: childConstraints, dry: dry);

    final size = Size(
      childSize.width,
      childSize.height + spacing,
    );

    return size;
  }

  Size _performChildLayout({required BoxConstraints constraints, required bool dry}) {
    if (dry) {
      return child!.getDryLayout(constraints);
    }

    child!.layout(constraints, parentUsesSize: true);
    return child!.size;
  }
}
