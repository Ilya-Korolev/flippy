import 'package:flippy/flippy.dart';
import 'package:flippy/src/controllers/controllers.dart';
import 'package:flutter_test/flutter_test.dart';

import 'models/models.dart';
import 'utils/utils.dart';

void main() {
  group('FlippyLoopedController', () {
    group('initial state', () {
      const expected = FlippyControllerState(current: 0, vector: 0, next: 0, target: 0, status: FlippyStatus.idling);
      test('state should start at $expected', () {
        final controller = FlippyLoopedController(count: 5);

        final actual = FlippyControllerUtils.getState(controller);
        expect(actual, expected);
      });
    });

    group('toNext', () {
      const expected = {
        1: FlippyControllerState(current: 0, vector: 1, next: 1, target: 1, status: FlippyStatus.movingToNext),
        2: FlippyControllerState(current: 4, vector: 1, next: 0, target: 0, status: FlippyStatus.movingToNext),
        3: FlippyControllerState(current: 0, vector: 1, next: 1, target: 1, status: FlippyStatus.movingToNext),
        4: FlippyControllerState(current: 1, vector: 0, next: 1, target: 1, status: FlippyStatus.idling),
        5: FlippyControllerState(current: 1, vector: 1, next: 2, target: 2, status: FlippyStatus.movingToNext),
        6: FlippyControllerState(current: 1, vector: 1, next: 0, target: 0, status: FlippyStatus.movingToNext),
        7: FlippyControllerState(current: 0, vector: 0, next: 0, target: 0, status: FlippyStatus.idling),
        8: FlippyControllerState(current: 1, vector: 0, next: 1, target: 1, status: FlippyStatus.idling),
      };

      test('state should be equal to ${expected[1]}', () {
        final controller = FlippyLoopedController(count: 5);

        controller.toNext();

        final actual = FlippyControllerUtils.getState(controller);
        expect(actual, expected[1]);
      });

      test('state should be equal to ${expected[2]}', () {
        final controller = FlippyLoopedController(count: 5);

        controller.setTo(4);
        controller.toNext();

        final actual = FlippyControllerUtils.getState(controller);
        expect(actual, expected[2]);
      });

      test('state should be equal to ${expected[3]}', () {
        final controller = FlippyLoopedController(count: 5);

        controller.toNext();
        controller.toNext();

        final actual = FlippyControllerUtils.getState(controller);
        expect(actual, expected[3]);
      });

      test('state should be equal to ${expected[4]}', () {
        final controller = FlippyLoopedController(count: 5);
        final updater = controller as UpdateNotifier;

        controller.toNext();
        updater.update();

        final actual = FlippyControllerUtils.getState(controller);
        expect(actual, expected[4]);
      });

      test('state should be equal to ${expected[5]}', () {
        final controller = FlippyLoopedController(count: 5);
        final updater = controller as UpdateNotifier;

        controller.toNext();
        updater.update();
        controller.toNext();

        final actual = FlippyControllerUtils.getState(controller);
        expect(actual, expected[5]);
      });

      test('state should be equal to ${expected[6]}', () {
        final controller = FlippyLoopedController(count: 2);
        final updater = controller as UpdateNotifier;

        controller.toNext();
        updater.update();
        controller.toNext();

        final actual = FlippyControllerUtils.getState(controller);
        expect(actual, expected[6]);
      });

      test('state should be equal to ${expected[7]}', () {
        final controller = FlippyLoopedController(count: 2);
        final updater = controller as UpdateNotifier;

        controller.toNext();
        updater.update();
        controller.toNext();
        updater.update();

        final actual = FlippyControllerUtils.getState(controller);
        expect(actual, expected[7]);
      });

      test('state should be equal to ${expected[8]}', () {
        final controller = FlippyLoopedController(count: 5);
        final updater = controller as UpdateNotifier;

        controller.toNext();
        updater.update();
        updater.update();

        final actual = FlippyControllerUtils.getState(controller);
        expect(actual, expected[8]);
      });
    });

    group('toPrevious', () {
      const expected = {
        1: FlippyControllerState(current: 0, vector: -1, next: 4, target: 4, status: FlippyStatus.movingToPrevious),
        2: FlippyControllerState(current: 3, vector: -1, next: 2, target: 2, status: FlippyStatus.movingToPrevious),
        3: FlippyControllerState(current: 0, vector: -1, next: 7, target: 7, status: FlippyStatus.movingToPrevious),
        4: FlippyControllerState(current: 2, vector: 0, next: 2, target: 2, status: FlippyStatus.idling),
        5: FlippyControllerState(current: 4, vector: -1, next: 3, target: 3, status: FlippyStatus.movingToPrevious),
        6: FlippyControllerState(current: 6, vector: 0, next: 6, target: 6, status: FlippyStatus.idling),
      };

      test('state should be equal to ${expected[1]}', () {
        final controller = FlippyLoopedController(count: 5);

        controller.toPrevious();

        final actual = FlippyControllerUtils.getState(controller);
        expect(actual, expected[1]);
      });

      test('state should be equal to ${expected[2]}', () {
        final controller = FlippyLoopedController(count: 5);

        controller.setTo(3);
        controller.toPrevious();

        final actual = FlippyControllerUtils.getState(controller);
        expect(actual, expected[2]);
      });

      test('state should be equal to ${expected[3]}', () {
        final controller = FlippyLoopedController(count: 8);

        controller.toPrevious();
        controller.toPrevious();

        final actual = FlippyControllerUtils.getState(controller);
        expect(actual, expected[3]);
      });

      test('state should be equal to ${expected[4]}', () {
        final controller = FlippyLoopedController(count: 3);
        final updater = controller as UpdateNotifier;

        controller.toPrevious();
        updater.update();

        final actual = FlippyControllerUtils.getState(controller);
        expect(actual, expected[4]);
      });

      test('state should be equal to ${expected[5]}', () {
        final controller = FlippyLoopedController(count: 5);
        final updater = controller as UpdateNotifier;

        controller.toPrevious();
        updater.update();
        controller.toPrevious();

        final actual = FlippyControllerUtils.getState(controller);
        expect(actual, expected[5]);
      });

      test('state should be equal to ${expected[6]}', () {
        final controller = FlippyLoopedController(count: 7);
        final updater = controller as UpdateNotifier;

        controller.toPrevious();
        updater.update();
        updater.update();

        final actual = FlippyControllerUtils.getState(controller);
        expect(actual, expected[6]);
      });
    });

    group('moveBy', () {
      const expected = {
        1: FlippyControllerState(current: 0, vector: 1, next: 1, target: 1, status: FlippyStatus.movingToNext),
        2: FlippyControllerState(current: 0, vector: 0, next: 0, target: 0, status: FlippyStatus.idling),
        3: FlippyControllerState(current: 0, vector: -1, next: 2, target: 2, status: FlippyStatus.movingToPrevious),
        4: FlippyControllerState(current: 5, vector: 3, next: 6, target: 1, status: FlippyStatus.movingToNext),
        5: FlippyControllerState(current: 2, vector: -3, next: 1, target: 4, status: FlippyStatus.movingToPrevious),
        6: FlippyControllerState(current: 0, vector: 5, next: 1, target: 0, status: FlippyStatus.movingToNext),
        7: FlippyControllerState(current: 0, vector: -5, next: 4, target: 0, status: FlippyStatus.movingToPrevious),
        8: FlippyControllerState(current: 0, vector: 5, next: 1, target: 5, status: FlippyStatus.movingToNext),
        9: FlippyControllerState(current: 0, vector: -5, next: 5, target: 1, status: FlippyStatus.movingToPrevious),
        10: FlippyControllerState(current: 1, vector: 0, next: 1, target: 1, status: FlippyStatus.idling),
        11: FlippyControllerState(current: 3, vector: 0, next: 3, target: 3, status: FlippyStatus.idling),
        12: FlippyControllerState(current: 1, vector: 4, next: 2, target: 1, status: FlippyStatus.movingToNext),
        13: FlippyControllerState(current: 2, vector: -4, next: 1, target: 1, status: FlippyStatus.movingToPrevious),
        14: FlippyControllerState(current: 1, vector: 4, next: 2, target: 0, status: FlippyStatus.movingToNext),
        15: FlippyControllerState(current: 3, vector: -4, next: 2, target: 3, status: FlippyStatus.movingToPrevious),
        16: FlippyControllerState(current: 1, vector: 4, next: 2, target: 5, status: FlippyStatus.movingToNext),
        17: FlippyControllerState(current: 5, vector: -4, next: 4, target: 1, status: FlippyStatus.movingToPrevious),
        18: FlippyControllerState(current: 2, vector: 2, next: 3, target: 4, status: FlippyStatus.movingToNext),
        19: FlippyControllerState(current: 3, vector: -2, next: 2, target: 1, status: FlippyStatus.movingToPrevious),
        20: FlippyControllerState(current: 3, vector: 0, next: 3, target: 3, status: FlippyStatus.idling),
        21: FlippyControllerState(current: 2, vector: 0, next: 2, target: 2, status: FlippyStatus.idling),
        22: FlippyControllerState(current: 3, vector: 0, next: 3, target: 3, status: FlippyStatus.idling),
        23: FlippyControllerState(current: 4, vector: 0, next: 4, target: 4, status: FlippyStatus.idling),
      };

      test('state should be equal to ${expected[1]}', () {
        final controller = FlippyLoopedController(count: 5);

        controller.moveBy(1);

        final actual = FlippyControllerUtils.getState(controller);
        expect(actual, expected[1]);
      });

      test('state should be equal to ${expected[2]}', () {
        final controller = FlippyLoopedController(count: 5);

        controller.moveBy(0);

        final actual = FlippyControllerUtils.getState(controller);
        expect(actual, expected[2]);
      });

      test('state should be equal to ${expected[3]}', () {
        final controller = FlippyLoopedController(count: 3);

        controller.moveBy(-1);

        final actual = FlippyControllerUtils.getState(controller);
        expect(actual, expected[3]);
      });

      test('state should be equal to ${expected[4]}', () {
        final controller = FlippyLoopedController(count: 7);

        controller.setTo(5);
        controller.moveBy(3);

        final actual = FlippyControllerUtils.getState(controller);
        expect(actual, expected[4]);
      });

      test('state should be equal to ${expected[5]}', () {
        final controller = FlippyLoopedController(count: 5);

        controller.setTo(2);
        controller.moveBy(-3);

        final actual = FlippyControllerUtils.getState(controller);
        expect(actual, expected[5]);
      });

      test('state should be equal to ${expected[6]}', () {
        final controller = FlippyLoopedController(count: 5);

        controller.moveBy(5);

        final actual = FlippyControllerUtils.getState(controller);
        expect(actual, expected[6]);
      });

      test('state should be equal to ${expected[7]}', () {
        final controller = FlippyLoopedController(count: 5);

        controller.moveBy(-5);

        final actual = FlippyControllerUtils.getState(controller);
        expect(actual, expected[7]);
      });

      test('state should be equal to ${expected[8]}', () {
        final controller = FlippyLoopedController(count: 6);

        controller.moveBy(5);
        controller.moveBy(10);

        final actual = FlippyControllerUtils.getState(controller);
        expect(actual, expected[8]);
      });

      test('state should be equal to ${expected[9]}', () {
        final controller = FlippyLoopedController(count: 6);

        controller.moveBy(-5);
        controller.moveBy(-10);

        final actual = FlippyControllerUtils.getState(controller);
        expect(actual, expected[9]);
      });

      test('state should be equal to ${expected[10]}', () {
        final controller = FlippyLoopedController(count: 5);
        final updater = controller as UpdateNotifier;

        controller.moveBy(1);
        updater.update();

        final actual = FlippyControllerUtils.getState(controller);
        expect(actual, expected[10]);
      });

      test('state should be equal to ${expected[11]}', () {
        final controller = FlippyLoopedController(count: 4);
        final updater = controller as UpdateNotifier;

        controller.moveBy(-1);
        updater.update();

        final actual = FlippyControllerUtils.getState(controller);
        expect(actual, expected[11]);
      });

      test('state should be equal to ${expected[12]}', () {
        final controller = FlippyLoopedController(count: 4);
        final updater = controller as UpdateNotifier;

        controller.moveBy(1);
        updater.update();
        controller.moveBy(4);

        final actual = FlippyControllerUtils.getState(controller);
        expect(actual, expected[12]);
      });

      test('state should be equal to ${expected[13]}', () {
        final controller = FlippyLoopedController(count: 3);
        final updater = controller as UpdateNotifier;

        controller.moveBy(-1);
        updater.update();
        controller.moveBy(-4);

        final actual = FlippyControllerUtils.getState(controller);
        expect(actual, expected[13]);
      });

      test('state should be equal to ${expected[14]}', () {
        final controller = FlippyLoopedController(count: 5);
        final updater = controller as UpdateNotifier;

        controller.moveBy(5);
        updater.update();

        final actual = FlippyControllerUtils.getState(controller);
        expect(actual, expected[14]);
      });

      test('state should be equal to ${expected[15]}', () {
        final controller = FlippyLoopedController(count: 4);
        final updater = controller as UpdateNotifier;

        controller.moveBy(-5);
        updater.update();

        final actual = FlippyControllerUtils.getState(controller);
        expect(actual, expected[15]);
      });

      test('state should be equal to ${expected[16]}', () {
        final controller = FlippyLoopedController(count: 7);
        final updater = controller as UpdateNotifier;

        controller.moveBy(5);
        updater.update();
        controller.moveBy(10);

        final actual = FlippyControllerUtils.getState(controller);
        expect(actual, expected[16]);
      });

      test('state should be equal to ${expected[17]}', () {
        final controller = FlippyLoopedController(count: 6);
        final updater = controller as UpdateNotifier;

        controller.moveBy(-5);
        updater.update();
        controller.moveBy(-10);

        final actual = FlippyControllerUtils.getState(controller);
        expect(actual, expected[17]);
      });

      test('state should be equal to ${expected[18]}', () {
        final controller = FlippyLoopedController(count: 5);
        final updater = controller as UpdateNotifier;

        controller.moveBy(4);
        updater.update();
        updater.update();

        final actual = FlippyControllerUtils.getState(controller);
        expect(actual, expected[18]);
      });

      test('state should be equal to ${expected[19]}', () {
        final controller = FlippyLoopedController(count: 5);
        final updater = controller as UpdateNotifier;

        controller.moveBy(-4);
        updater.update();
        updater.update();

        final actual = FlippyControllerUtils.getState(controller);
        expect(actual, expected[19]);
      });

      test('state should be equal to ${expected[20]}', () {
        final controller = FlippyLoopedController(count: 5);
        final updater = controller as UpdateNotifier;

        controller.moveBy(3);
        updater.update();
        updater.update();
        updater.update();

        final actual = FlippyControllerUtils.getState(controller);
        expect(actual, expected[20]);
      });

      test('state should be equal to ${expected[21]}', () {
        final controller = FlippyLoopedController(count: 5);
        final updater = controller as UpdateNotifier;

        controller.moveBy(-3);
        updater.update();
        updater.update();
        updater.update();

        final actual = FlippyControllerUtils.getState(controller);
        expect(actual, expected[21]);
      });

      test('state should be equal to ${expected[22]}', () {
        final controller = FlippyLoopedController(count: 5);
        final updater = controller as UpdateNotifier;

        controller.moveBy(3);
        updater.update();
        updater.update();
        updater.update();
        updater.update();

        final actual = FlippyControllerUtils.getState(controller);
        expect(actual, expected[22]);
      });

      test('state should be equal to ${expected[23]}', () {
        final controller = FlippyLoopedController(count: 7);
        final updater = controller as UpdateNotifier;

        controller.moveBy(-3);
        updater.update();
        updater.update();
        updater.update();
        updater.update();

        final actual = FlippyControllerUtils.getState(controller);
        expect(actual, expected[23]);
      });
    });

    group('setTo', () {
      const expected = {
        1: FlippyControllerState(current: 0, vector: 0, next: 0, target: 0, status: FlippyStatus.idling),
        2: FlippyControllerState(current: 8, vector: 0, next: 8, target: 8, status: FlippyStatus.idling),
        3: FlippyControllerState(current: 5, vector: 0, next: 5, target: 5, status: FlippyStatus.idling),
      };

      test('state should be equal to ${expected[1]}', () {
        final controller = FlippyLoopedController(count: 5);

        controller.setTo(0);

        final actual = FlippyControllerUtils.getState(controller);
        expect(actual, expected[1]);
      });

      test('state should be equal to ${expected[2]}', () {
        final controller = FlippyLoopedController(count: 10);

        controller.setTo(8);

        final actual = FlippyControllerUtils.getState(controller);
        expect(actual, expected[2]);
      });

      test('state should be equal to ${expected[3]}', () {
        final controller = FlippyLoopedController(count: 6);
        final updater = controller as UpdateNotifier;

        controller.setTo(5);
        updater.update();

        final actual = FlippyControllerUtils.getState(controller);
        expect(actual, expected[3]);
      });
    });

    group('moveForwardTo', () {
      const expected = {
        1: FlippyControllerState(current: 0, vector: 0, next: 0, target: 0, status: FlippyStatus.idling),
        2: FlippyControllerState(current: 0, vector: 4, next: 1, target: 4, status: FlippyStatus.movingToNext),
        3: FlippyControllerState(current: 5, vector: 5, next: 0, target: 4, status: FlippyStatus.movingToNext),
        4: FlippyControllerState(current: 0, vector: 3, next: 1, target: 3, status: FlippyStatus.movingToNext),
        5: FlippyControllerState(current: 1, vector: 3, next: 2, target: 4, status: FlippyStatus.movingToNext),
        6: FlippyControllerState(current: 2, vector: 0, next: 2, target: 2, status: FlippyStatus.idling),
        7: FlippyControllerState(current: 0, vector: 0, next: 0, target: 0, status: FlippyStatus.idling),
      };

      test('state should be equal to ${expected[1]}', () {
        final controller = FlippyLoopedController(count: 5);

        controller.moveForwardTo(0);

        final actual = FlippyControllerUtils.getState(controller);
        expect(actual, expected[1]);
      });

      test('state should be equal to ${expected[2]}', () {
        final controller = FlippyLoopedController(count: 6);

        controller.moveForwardTo(4);

        final actual = FlippyControllerUtils.getState(controller);
        expect(actual, expected[2]);
      });

      test('state should be equal to ${expected[3]}', () {
        final controller = FlippyLoopedController(count: 6);

        controller.setTo(5);
        controller.moveForwardTo(4);

        final actual = FlippyControllerUtils.getState(controller);
        expect(actual, expected[3]);
      });

      test('state should be equal to ${expected[4]}', () {
        final controller = FlippyLoopedController(count: 6);

        controller.moveForwardTo(3);
        controller.moveForwardTo(2);

        final actual = FlippyControllerUtils.getState(controller);
        expect(actual, expected[4]);
      });

      test('state should be equal to ${expected[5]}', () {
        final controller = FlippyLoopedController(count: 6);
        final updater = controller as UpdateNotifier;

        controller.moveForwardTo(4);
        updater.update();

        final actual = FlippyControllerUtils.getState(controller);
        expect(actual, expected[5]);
      });

      test('state should be equal to ${expected[6]}', () {
        final controller = FlippyLoopedController(count: 6);
        final updater = controller as UpdateNotifier;

        controller.moveForwardTo(2);
        updater.update();
        updater.update();

        final actual = FlippyControllerUtils.getState(controller);
        expect(actual, expected[6]);
      });

      test('state should be equal to ${expected[7]}', () {
        final controller = FlippyLoopedController(count: 2);
        final updater = controller as UpdateNotifier;

        controller.moveForwardTo(1);
        updater.update();
        controller.moveForwardTo(0);
        updater.update();

        final actual = FlippyControllerUtils.getState(controller);
        expect(actual, expected[7]);
      });
    });

    group('moveBackwardTo', () {
      const expected = {
        1: FlippyControllerState(current: 0, vector: 0, next: 0, target: 0, status: FlippyStatus.idling),
        2: FlippyControllerState(current: 0, vector: -2, next: 5, target: 4, status: FlippyStatus.movingToPrevious),
        3: FlippyControllerState(current: 5, vector: -2, next: 4, target: 3, status: FlippyStatus.movingToPrevious),
        4: FlippyControllerState(current: 0, vector: -3, next: 5, target: 3, status: FlippyStatus.movingToPrevious),
        5: FlippyControllerState(current: 5, vector: -1, next: 4, target: 4, status: FlippyStatus.movingToPrevious),
        6: FlippyControllerState(current: 4, vector: 0, next: 4, target: 4, status: FlippyStatus.idling),
        7: FlippyControllerState(current: 0, vector: 0, next: 0, target: 0, status: FlippyStatus.idling),
      };

      test('state should be equal to ${expected[1]}', () {
        final controller = FlippyLoopedController(count: 5);

        controller.moveBackwardTo(0);

        final actual = FlippyControllerUtils.getState(controller);
        expect(actual, expected[1]);
      });

      test('state should be equal to ${expected[2]}', () {
        final controller = FlippyLoopedController(count: 6);

        controller.moveBackwardTo(4);

        final actual = FlippyControllerUtils.getState(controller);
        expect(actual, expected[2]);
      });

      test('state should be equal to ${expected[3]}', () {
        final controller = FlippyLoopedController(count: 6);

        controller.setTo(5);
        controller.moveBackwardTo(3);

        final actual = FlippyControllerUtils.getState(controller);
        expect(actual, expected[3]);
      });

      test('state should be equal to ${expected[4]}', () {
        final controller = FlippyLoopedController(count: 6);

        controller.moveBackwardTo(3);
        controller.moveBackwardTo(2);

        final actual = FlippyControllerUtils.getState(controller);
        expect(actual, expected[4]);
      });

      test('state should be equal to ${expected[5]}', () {
        final controller = FlippyLoopedController(count: 6);
        final updater = controller as UpdateNotifier;

        controller.moveBackwardTo(4);
        updater.update();

        final actual = FlippyControllerUtils.getState(controller);
        expect(actual, expected[5]);
      });

      test('state should be equal to ${expected[6]}', () {
        final controller = FlippyLoopedController(count: 6);
        final updater = controller as UpdateNotifier;

        controller.moveBackwardTo(4);
        updater.update();
        updater.update();

        final actual = FlippyControllerUtils.getState(controller);
        expect(actual, expected[6]);
      });

      test('state should be equal to ${expected[7]}', () {
        final controller = FlippyLoopedController(count: 2);
        final updater = controller as UpdateNotifier;

        controller.moveBackwardTo(1);
        updater.update();
        controller.moveBackwardTo(0);
        updater.update();

        final actual = FlippyControllerUtils.getState(controller);
        expect(actual, expected[7]);
      });
    });

    group('asserts', () {
      test('constructor should throw an error', () {
        expect(() => FlippyLoopedController(count: -102), throwsAssertionError);
        expect(() => FlippyLoopedController(count: -1), throwsAssertionError);
      });

      test('setTo should throw an error', () {
        final controller = FlippyLoopedController(count: 7);

        expect(() => controller.setTo(-10), throwsAssertionError);
        expect(() => controller.setTo(-1), throwsAssertionError);
        expect(() => controller.setTo(7), throwsAssertionError);
        expect(() => controller.setTo(23), throwsAssertionError);
      });

      test('moveForwardTo should throw an error', () {
        final controller = FlippyLoopedController(count: 9);

        expect(() => controller.moveForwardTo(-12), throwsAssertionError);
        expect(() => controller.moveForwardTo(-1), throwsAssertionError);
        expect(() => controller.moveForwardTo(9), throwsAssertionError);
        expect(() => controller.moveForwardTo(20), throwsAssertionError);
      });

      test('moveBackwardTo should throw an error', () {
        final controller = FlippyLoopedController(count: 12);

        expect(() => controller.moveBackwardTo(-14), throwsAssertionError);
        expect(() => controller.moveBackwardTo(-1), throwsAssertionError);
        expect(() => controller.moveBackwardTo(12), throwsAssertionError);
        expect(() => controller.moveBackwardTo(30), throwsAssertionError);
      });
    });
  });
}
