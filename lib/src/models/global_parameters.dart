import 'package:flutter/widgets.dart';

class GlobalParameters extends ChangeNotifier {
  double _gap;
  double _perspective;

  double get gap => _gap;
  double get perspective => _perspective;

  GlobalParameters({
    required double gap,
    required double perspective,
  })   : _gap = gap,
        _perspective = perspective;

  void update({required double gap, required double perspective}) {
    _gap = gap;
    _perspective = perspective;

    notifyListeners();
  }
}
