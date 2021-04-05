import 'dart:math' as math;

import 'package:flutter/rendering.dart';

import '../models/models.dart';

class HalfCalculation {
  static const _halfPi = math.pi / 2.0;

  final double _gap;
  final double _perspective;
  final HalfType _type;
  final AlignmentGeometry _alignment;

  double _degree = 0.0;
  double _offset = 0.0;
  bool _isVisible = false;

  double get degree => _degree;
  double get offset => _offset;
  double get perspective => _perspective;
  bool get isVisible => _isVisible;
  AlignmentGeometry get alignment => _alignment;

  HalfCalculation({
    required double gap,
    required double perspective,
    required HalfType type,
  })   : assert(gap >= 0.0),
        assert(perspective >= 0.0),
        _gap = gap,
        _perspective = type == HalfType.top ? perspective : -perspective,
        _type = type,
        _alignment = type == HalfType.top ? Alignment.bottomCenter : Alignment.topCenter {
    update(0.0);
  }

  void update(double animationValue) {
    if (_type == HalfType.top) {
      _degree = animationValue;
      _offset = (_gap * degree / math.pi).abs();
    } else {
      _degree = math.pi - animationValue;
      _offset = -(_gap * degree / math.pi).abs();
    }

    _isVisible = -_halfPi < degree && degree < _halfPi;
  }
}
