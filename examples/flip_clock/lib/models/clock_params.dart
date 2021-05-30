import 'package:flutter/cupertino.dart';

class ClockParams extends ChangeNotifier {
  ClockParams({
    required double width,
    required double height,
    required double colonSize,
    required double digitSize,
    required double digitSpacing,
    required double digitPerspective,
    required double borderRadius,
  })  : _width = width,
        _height = height,
        _colonSize = colonSize,
        _digitSize = digitSize,
        _digitSpacing = digitSpacing,
        _digitPerspective = digitPerspective,
        _borderRadius = borderRadius;

  double _width;
  double get width => _width;
  set width(double value) {
    if (width == value) {
      return;
    }

    _width = value;

    notifyListeners();
  }

  double _height;
  double get height => _height;
  set height(double value) {
    if (height == value) {
      return;
    }

    _height = value;

    notifyListeners();
  }

  double _colonSize;
  double get colonSize => _colonSize;
  set colonSize(double value) {
    if (colonSize == value) {
      return;
    }

    _colonSize = value;

    notifyListeners();
  }

  double _digitSize;
  double get digitSize => _digitSize;
  set digitSize(double value) {
    if (digitSize == value) {
      return;
    }

    _digitSize = value;

    notifyListeners();
  }

  double _digitSpacing;
  double get digitSpacing => _digitSpacing;
  set digitSpacing(double value) {
    if (digitSpacing == value) {
      return;
    }

    _digitSpacing = value;

    notifyListeners();
  }

  double _digitPerspective;
  double get digitPerspective => _digitPerspective;
  set digitPerspective(double value) {
    if (digitPerspective == value) {
      return;
    }

    _digitPerspective = value;

    notifyListeners();
  }

  double _borderRadius;
  double get borderRadius => _borderRadius;
  set borderRadius(double value) {
    if (borderRadius == value) {
      return;
    }

    _borderRadius = value;

    notifyListeners();
  }
}
