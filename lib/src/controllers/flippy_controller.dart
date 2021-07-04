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

abstract class FlippyCountedController extends FlippyController {
  factory FlippyCountedController() => FlippyCountedControllerInternal();

  void toNext();
  void toPrevious();

  void moveBy(int vector);

  void setTo(int index);
}

abstract class FlippyLoopedController extends FlippyCountedController {
  factory FlippyLoopedController({required int count}) => FlippyLoopedControllerInternal(count: count);

  int get count;

  void moveForwardTo(int index);
  void moveBackwardTo(int index);
}