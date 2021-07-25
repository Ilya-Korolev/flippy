import 'controllers.dart';

class FlippySimpleControllerInternal extends UpdateNotifier implements FlippySimpleController {
  FlippySimpleControllerInternal();

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

class FlippyLoopedControllerInternal extends FlippySimpleControllerInternal implements FlippyLoopedController {
  FlippyLoopedControllerInternal({required int length})
      : assert(length > 0),
        _length = length,
        super();

  final int _length;
  int get length => _length;

  int get target => (current + vector) % length;

  int get next {
    final next = current + vector.sign;

    if (next >= length) {
      return 0;
    } else if (next < 0) {
      return length - 1;
    } else {
      return next;
    }
  }

  void setTo(int index) {
    assert(0 <= index && index <= length - 1);

    super.setTo(index);
  }

  void moveForwardTo(int index) {
    assert(0 <= index && index <= length - 1);

    if (status != FlippyStatus.idling) {
      return;
    }

    if (index == current) {
      return;
    } else if (index < current) {
      _vector = length + index - current;
    } else if (index > current) {
      _vector = index - current;
    }

    notifyListeners();
  }

  void moveBackwardTo(int index) {
    assert(0 <= index && index <= length - 1);

    if (status != FlippyStatus.idling) {
      return;
    }

    if (index == current) {
      return;
    } else if (index < current) {
      _vector = index - current;
    } else if (index > current) {
      _vector = -length + index - current;
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

        if (current >= length) {
          _current -= length;
        }
        break;

      case FlippyStatus.movingToPrevious:
        --_current;
        ++_vector;

        if (current < 0) {
          _current += _length;
        }
        break;
    }

    notifyListeners();
  }
}
