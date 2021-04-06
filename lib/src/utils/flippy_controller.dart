import 'package:flutter/foundation.dart';

enum FlippyViewStatus { ready, inProgress }

abstract class FlippyController with ChangeNotifier {
  factory FlippyController({required int count}) => FlippyControllerInternal(count: count);

  int get count;
  int get current;
  int get next;
  int get target;
  FlippyViewStatus get status;

  void moveNext();
  void moveNextN(int n);
  void moveTo(int index);
  void setTo(int index);
}

class FlippyControllerInternal with ChangeNotifier implements FlippyController {
  final int _count;
  int _current = 0;
  int _target = 0;

  FlippyControllerInternal({required int count})
      : assert(count > 0),
        _count = count;

  int get count => _count;
  int get current => _current;
  int get next => _current + 1 < _count ? _current + 1 : 0;
  int get target => _target;

  FlippyViewStatus get status => _current == _target ? FlippyViewStatus.ready : FlippyViewStatus.inProgress;

  void moveNext() {
    if (status != FlippyViewStatus.ready) {
      return;
    }

    _target = current + 1;
  }

  void moveNextN(int n) {
    assert(n > 0);

    if (status != FlippyViewStatus.ready) {
      return;
    }

    _target = current + n;
  }

  void moveTo(int index) {
    assert(0 <= index && index <= count - 1);

    if (status != FlippyViewStatus.ready) {
      return;
    }

    if (index == current) {
      return;
    }

    _target = index - current;

    if (_target < 0) {
      _target += count;
    }
  }

  void setTo(int index) {
    assert(0 <= index && index <= count - 1);

    _current = index;
    _target = index;
  }

  void update() {
    ++_current;

    if (_current >= _count) {
      _current -= _count;
      if (_target >= _count) _target -= _count;
    }

    notifyListeners();
  }
}
