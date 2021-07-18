import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

class SplitFlap extends MultiChildRenderObjectWidget {
  final Widget current;
  final Widget next;
  final double spacing;
  final double perspective;
  final double animationValue;

  SplitFlap({
    required this.current,
    required this.next,
    this.spacing = 0.0,
    this.perspective = 0.0,
    this.animationValue = 0.0,
    Key? key,
  })  : assert(spacing >= 0.0),
        assert(perspective >= 0.0),
        assert(0.0 <= animationValue && animationValue <= 1.0),
        super(key: key, children: [
          current,
          next,
        ]);

  @override
  RenderObject createRenderObject(BuildContext context) {
    return RenderSplitFlap(
      spacing: spacing,
      perspective: perspective,
      animationValue: animationValue,
    );
  }

  @override
  void updateRenderObject(BuildContext context, RenderSplitFlap renderObject) {
    renderObject
      ..spacing = spacing
      ..perspective = perspective
      ..animationValue = animationValue;
  }
}

class SplitFlapParentData extends ContainerBoxParentData<RenderBox> {}

class RenderSplitFlap extends RenderBox
    with
        ContainerRenderObjectMixin<RenderBox, SplitFlapParentData>,
        RenderBoxContainerDefaultsMixin<RenderBox, SplitFlapParentData> {
  RenderSplitFlap({
    required double spacing,
    required double perspective,
    required double animationValue,
  })  : _spacing = spacing,
        _perspective = perspective,
        _animationValue = animationValue;

  double _spacing;

  double get spacing => _spacing;

  set spacing(double value) {
    if (value == spacing) return;

    _spacing = value;
    markNeedsLayout();
  }

  double _perspective;

  double get perspective => _perspective;

  set perspective(double value) {
    if (value == perspective) return;

    _perspective = value;
    markNeedsPaint();
  }

  double _animationValue;

  double get animationValue => _animationValue;

  set animationValue(double value) {
    if (value == animationValue) return;

    _animationValue = value;
    markNeedsPaint();
  }

  @override
  void setupParentData(covariant RenderObject child) {
    if (child.parentData is! SplitFlapParentData) {
      child.parentData = SplitFlapParentData();
    }
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
  double computeMaxIntrinsicWidth(double height) {
    final topHalfWidth = firstChild!.getMaxIntrinsicWidth(height);
    final bottomHalfWidth = lastChild!.getMaxIntrinsicWidth(height);

    return math.max(topHalfWidth, bottomHalfWidth);
  }

  @override
  double computeMinIntrinsicWidth(double height) {
    final topHalfWidth = firstChild!.getMinIntrinsicWidth(height);
    final bottomHalfWidth = lastChild!.getMinIntrinsicWidth(height);

    return math.max(topHalfWidth, bottomHalfWidth);
  }

  @override
  double computeMaxIntrinsicHeight(double width) {
    final topHalfHeight = firstChild!.getMaxIntrinsicHeight(width);
    final bottomHalfHeight = lastChild!.getMaxIntrinsicHeight(width);

    return math.max(topHalfHeight, bottomHalfHeight) + spacing;
  }

  @override
  double computeMinIntrinsicHeight(double width) {
    final topHalfHeight = firstChild!.getMinIntrinsicHeight(width);
    final bottomHalfHeight = lastChild!.getMinIntrinsicHeight(width);

    return math.max(topHalfHeight, bottomHalfHeight) + spacing;
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    if (constraints.maxHeight < spacing) {
      return;
    }

    final halfSize = Size(size.width, (size.height - spacing) / 2.0);

    final topHalfOffset = offset;
    final bottomHalfOffset = Offset(offset.dx, offset.dy + halfSize.height + spacing);

    final topHalfRect = topHalfOffset & halfSize;
    final bottomHalfRect = bottomHalfOffset & halfSize;

    context.clipRectAndPaint(
      topHalfRect,
      Clip.hardEdge,
      topHalfRect,
      () => context.paintChild(lastChild!, offset),
    );

    context.clipRectAndPaint(
      bottomHalfRect,
      Clip.hardEdge,
      bottomHalfRect,
      () => context.paintChild(firstChild!, Offset(offset.dx, offset.dy + spacing)),
    );

    if (animationValue < 0.5) {
      final transform = _buildTransformMatrix(
        degree: math.pi * animationValue,
        perspective: perspective,
      );

      layer = context.pushTransform(
        needsCompositing,
        offset,
        transform,
        (context, offset) => context.clipRectAndPaint(
          topHalfRect,
          Clip.hardEdge,
          topHalfRect,
          () => context.paintChild(firstChild!, offset),
        ),
        oldLayer: layer as TransformLayer?,
      );
    }

    if (animationValue > 0.5) {
      final transform = _buildTransformMatrix(
        degree: math.pi * (1.0 - animationValue),
        perspective: -perspective,
      );

      layer = context.pushTransform(
        needsCompositing,
        offset,
        transform,
        (context, offset) => context.clipRectAndPaint(
          bottomHalfRect,
          Clip.hardEdge,
          bottomHalfRect,
          () => context.paintChild(lastChild!, Offset(offset.dx, offset.dy + spacing)),
        ),
        oldLayer: layer as TransformLayer?,
      );
    }

    // _paintDebug(
    //   context: context,
    //   topHalfRect: topHalfRect,
    //   bottomHalfRect: bottomHalfRect,
    //   offset: offset,
    //   animationValue: animationValue,
    // );
  }

  void _paintDebug({
    required PaintingContext context,
    required Rect topHalfRect,
    required Rect bottomHalfRect,
    required Offset offset,
    required double animationValue,
  }) {
    context.canvas.save();

    context.canvas.drawRect(
      topHalfRect,
      Paint()
        ..color = Colors.green
        ..style = PaintingStyle.fill,
    );

    context.canvas.drawRect(
      bottomHalfRect,
      Paint()
        ..color = Colors.blue
        ..style = PaintingStyle.fill,
    );

    final transform1 = _buildTransformMatrix(
      degree: math.pi * animationValue,
      perspective: perspective,
    );

    layer = context.pushTransform(
      needsCompositing,
      offset,
      transform1,
      (context, offset) => context.canvas.drawRect(
        topHalfRect,
        Paint()
          ..color = Colors.purple
          ..style = PaintingStyle.fill,
      ),
      oldLayer: layer as TransformLayer?,
    );

    final transform = _buildTransformMatrix(
      degree: math.pi * animationValue,
      perspective: -perspective,
    );

    layer = context.pushTransform(
      needsCompositing,
      offset,
      transform,
      (context, offset) => context.canvas.drawRect(
        bottomHalfRect,
        Paint()
          ..color = Colors.white
          ..style = PaintingStyle.fill,
      ),
      oldLayer: layer as TransformLayer?,
    );

    context.canvas.drawLine(
      Offset(offset.dx, offset.dy + size.height / 2.0),
      Offset(offset.dx + size.width, offset.dy + size.height / 2.0),
      Paint()
        ..color = Colors.red
        ..style = PaintingStyle.fill,
    );

    context.canvas.restore();
  }

  Matrix4 _buildTransformMatrix({required double degree, required double perspective}) {
    final transform = Matrix4.identity()
      ..setEntry(3, 2, perspective)
      ..rotateX(degree);

    final alignment = Alignment.center;
    final alignmentTranslation = alignment.alongSize(this.size);

    final effectiveTransform = Matrix4.translationValues(alignmentTranslation.dx, alignmentTranslation.dy, 0.0)
      ..multiply(transform)
      ..translate(-alignmentTranslation.dx, -alignmentTranslation.dy);

    return effectiveTransform;
  }

  Size _performLayout({required BoxConstraints constraints, required bool dry}) {
    if (constraints.maxHeight < spacing) {
      return const Size(0.0, 0.0);
    }

    final maxHeight = constraints.maxHeight - spacing;
    final childConstraints = constraints.copyWith(
      maxHeight: maxHeight,
      minHeight: math.min(constraints.minHeight, maxHeight),
    );

    final firstChildSize = _layoutChild(firstChild!, constraints: childConstraints, dry: dry);
    final lastChildSize = _layoutChild(lastChild!, constraints: childConstraints, dry: dry);

    final width = math.max(firstChildSize.width, lastChildSize.width);
    final height = math.min(math.max(firstChildSize.height, lastChildSize.height) + spacing, constraints.maxHeight);

    final size = Size(width, height);

    return size;
  }

  Size _layoutChild(RenderBox child, {required BoxConstraints constraints, required bool dry}) {
    if (dry) {
      return child.getDryLayout(constraints);
    }

    child.layout(constraints, parentUsesSize: true);
    return child.size;
  }
}
