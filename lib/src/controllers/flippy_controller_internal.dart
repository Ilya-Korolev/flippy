import 'dart:math';

import 'controllers.dart';

class FlippyCountedControllerInternal extends UpdateNotifier implements FlippyCountedController {
  FlippyCountedControllerInternal();

  int _current = 0;
  int _vector = 0;

  int get current => _current;
  int get vector => _vector;
  int get target => current + vector;
  int get next => current + vector.sign;

  FlippyStatus get status {
    switch (vector.sign) {
      case 1:
        return FlippyStatus.movingToNext;
      case -1:
        return FlippyStatus.movingToPrevious;
      default:
        return FlippyStatus.idling;
    }
  }

  void toNext() => moveBy(1);

  void toPrevious() => moveBy(-1);

  void moveBy(int vector) {
    if (vector == 0 || status != FlippyStatus.idling) {
      return;
    }

    _vector = vector;

    notifyListeners();
  }

  void setTo(int index) {
    if (index == current) {
      return;
    }

    _current = index;
    _vector = 0;

    notifyListeners();
  }

  void update() {
    switch (status) {
      case FlippyStatus.idling:
        return;
      case FlippyStatus.movingToNext:
        ++_current;
        --_vector;
        break;
      case FlippyStatus.movingToPrevious:
        --_current;
        ++_vector;
        break;
    }

    notifyListeners();
  }
}

class FlippyLoopedControllerInternal extends FlippyCountedControllerInternal implements FlippyLoopedController {
  FlippyLoopedControllerInternal({required int count})
      : assert(count > 0),
        _count = count,
        super();

  final int _count;
  int get count => _count;

  int get target => (current + vector) % count;

  int get next {
    final next = current + vector.sign;

    if (next >= count) {
      return 0;
    } else if (next < 0) {
      return count - 1;
    } else {
      return next;
    }
  }

  void setTo(int index) {
    assert(0 <= index && index <= count - 1);

    super.setTo(index);
  }

  void moveForwardTo(int index) {
    assert(0 <= index && index <= count - 1);

    if (status != FlippyStatus.idling) {
      return;
    }

    if (index == current) {
      return;
    } else if (index < current) {
      _vector = count + index - current;
    } else if (index > current) {
      _vector = index - current;
    }

    notifyListeners();
  }

  void moveBackwardTo(int index) {
    assert(0 <= index && index <= count - 1);

    if (status != FlippyStatus.idling) {
      return;
    }

    if (index == current) {
      return;
    } else if (index < current) {
      _vector = index - current;
    } else if (index > current) {
      _vector = -count + index - current;
    }

    notifyListeners();
  }

  void update() {
    switch (status) {
      case FlippyStatus.idling:
        return;

      case FlippyStatus.movingToNext:
        ++_current;
        --_vector;

        if (current >= count) {
          _current -= count;
        }
        break;

      case FlippyStatus.movingToPrevious:
        --_current;
        ++_vector;

        if (current < 0) {
          _current += _count;
        }
        break;
    }

    notifyListeners();
  }
}
