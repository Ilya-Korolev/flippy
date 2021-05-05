import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class Split extends MultiChildRenderObjectWidget {
  final double spacing;
  final Widget topHalf;
  final Widget bottomHalf;

  Split({
    required this.topHalf,
    required this.bottomHalf,
    this.spacing = 0.0,
    Key? key,
  })  : assert(spacing >= 0.0),
        super(key: key, children: [
          topHalf,
          bottomHalf,
        ]);

  @override
  RenderObject createRenderObject(BuildContext context) {
    return RenderSplit(spacing: spacing);
  }

  @override
  void updateRenderObject(BuildContext context, RenderSplit renderObject) {
    renderObject..spacing = spacing;
  }
}

class SplitParentData extends ContainerBoxParentData<RenderBox> {}

class RenderSplit extends RenderBox
    with
        ContainerRenderObjectMixin<RenderBox, SplitParentData>,
        RenderBoxContainerDefaultsMixin<RenderBox, SplitParentData> {
  double _spacing;

  double get spacing => _spacing;

  set spacing(double value) {
    if (value == spacing) return;

    _spacing = value;
    markNeedsLayout();
  }

  RenderSplit({required double spacing}) : _spacing = spacing;

  @override
  void setupParentData(covariant RenderObject child) {
    if (child.parentData is! SplitParentData) {
      child.parentData = SplitParentData();
    }
  }

  @override
  Size computeDryLayout(BoxConstraints constraints) {
    return _performLayout(constraints: constraints, dry: true);
  }

  @override
  void performLayout() {
    size = _performLayout(constraints: constraints, dry: false);
    _setOffset();
  }

  @override
  double computeMaxIntrinsicWidth(double height) {
    final topHalf = firstChild!;
    final bottomHalf = lastChild!;

    final topHalfWidth = topHalf.getMaxIntrinsicWidth(height);
    final bottomHalfWidth = bottomHalf.getMaxIntrinsicWidth(height);

    return math.max(topHalfWidth, bottomHalfWidth);
  }

  @override
  double computeMaxIntrinsicHeight(double width) {
    final topHalf = firstChild!;
    final bottomHalf = lastChild!;

    final topHalfHeight = topHalf.getMaxIntrinsicHeight(width);
    final bottomHalfHeight = bottomHalf.getMaxIntrinsicHeight(width);

    return topHalfHeight + spacing + bottomHalfHeight;
  }

  @override
  double computeMinIntrinsicWidth(double height) {
    final topHalf = firstChild!;
    final bottomHalf = lastChild!;

    final topHalfWidth = topHalf.getMinIntrinsicWidth(height);
    final bottomHalfWidth = bottomHalf.getMinIntrinsicWidth(height);

    return math.max(topHalfWidth, bottomHalfWidth);
  }

  @override
  double computeMinIntrinsicHeight(double width) {
    final topHalf = firstChild!;
    final bottomHalf = lastChild!;

    final topHalfHeight = topHalf.getMinIntrinsicHeight(width);
    final bottomHalfHeight = bottomHalf.getMinIntrinsicHeight(width);

    return topHalfHeight + spacing + bottomHalfHeight;
  }

  @override
  double? computeDistanceToActualBaseline(TextBaseline baseline) {
    return defaultComputeDistanceToFirstActualBaseline(baseline);
  }

  @override
  bool hitTestChildren(BoxHitTestResult result, {required Offset position}) {
    return defaultHitTestChildren(result, position: position);
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    defaultPaint(context, offset);
  }

  Size _performLayout({required BoxConstraints constraints, required bool dry}) {
    final topHalf = firstChild!;
    final bottomHalf = lastChild!;

    final halfMaxSize = BoxConstraints(
      maxHeight: constraints.maxHeight < spacing ? constraints.maxHeight : constraints.maxHeight - spacing,
      minHeight: constraints.minHeight < spacing ? constraints.minHeight : constraints.minHeight - spacing,
      maxWidth: constraints.maxWidth,
      minWidth: constraints.minWidth,
    );

    final topHalfSize = _layoutChild(topHalf, constraints: halfMaxSize, dry: dry);
    final bottomHalfSize = _layoutChild(bottomHalf, constraints: halfMaxSize, dry: dry);

    final size = Size(
      math.max(topHalfSize.width, bottomHalfSize.width),
      math.min(constraints.maxHeight, topHalfSize.height + spacing + bottomHalfSize.height),
    );

    return size;
  }

  Size _layoutChild(RenderBox child, {required BoxConstraints constraints, required bool dry}) {
    if (dry) {
      return child.getDryLayout(constraints);
    }

    child.layout(constraints, parentUsesSize: true);
    return child.size;
  }

  void _setOffset() {
    final topHalf = firstChild!;
    final bottomHalf = lastChild!;

    final topHalfParentData = topHalf.parentData as SplitParentData;
    topHalfParentData.offset = Offset(
      (size.width - topHalf.size.width) / 2.0,
      0.0,
    );

    final bottomHalfParentData = bottomHalf.parentData as SplitParentData;
    bottomHalfParentData.offset = Offset(
      (size.width - bottomHalf.size.width) / 2.0,
      topHalf.size.height + spacing,
    );
  }
}
