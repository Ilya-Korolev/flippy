import 'package:flippy/flippy.dart';

import '../models/models.dart';

class FlippyControllerUtils {
  static FlippyControllerState getState(FlippyCountedController controller) {
    return FlippyControllerState(
      current: controller.current,
      vector: controller.vector,
      next: controller.next,
      target: controller.target,
      status: controller.status,
    );
  }
}
