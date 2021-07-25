import 'package:flutter/foundation.dart';

import 'controllers.dart';

enum FlippyStatus { idling, movingToNext, movingToPrevious }

abstract class UpdateNotifier with ChangeNotifier {
  void update();
}

abstract class FlippyController with ChangeNotifier {
  int get current;
  int get next;
  int get vector;
  int get target;
  FlippyStatus get status;
}

abstract class FlippySimpleController extends FlippyController {
  factory FlippySimpleController() => FlippySimpleControllerInternal();

  void toNext();
  void toPrevious();

  void moveBy(int vector);

  void setTo(int index);
}

abstract class FlippyLoopedController extends FlippySimpleController {
  factory FlippyLoopedController({required int length}) => FlippyLoopedControllerInternal(length: length);

  int get length;

  void moveForwardTo(int index);
  void moveBackwardTo(int index);
}
