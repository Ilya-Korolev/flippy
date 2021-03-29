import 'dart:math' as math;

import 'package:flutter/rendering.dart';

import '../models/models.dart';

class HalfCalculation {
  static const _halfPi = math.pi / 2.0;

  final double _gap;
  final double _perspective;
  final HalfType _type;
  final AlignmentGeometry _alignment;

  double _animationValue = 0.0;
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
  })   : _gap = gap,
        _perspective = type == HalfType.top ? perspective : -perspective,
        _type = type,
        _alignment = type == HalfType.top ? Alignment.bottomCenter : Alignment.topCenter;

  void update(double animationValue) {
    _animationValue = animationValue;

    if (_type == HalfType.top) {
      _degree = _animationValue;
      _offset = _gap * degree / math.pi;
    } else {
      _degree = math.pi - _animationValue;
      _offset = -_gap * degree / math.pi;
    }

    _isVisible = degree < _halfPi;
  }
}
