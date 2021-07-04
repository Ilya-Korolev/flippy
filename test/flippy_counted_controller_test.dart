import 'package:flippy/flippy.dart';
import 'package:flippy/src/controllers/controllers.dart';
import 'package:flutter_test/flutter_test.dart';

import 'models/models.dart';
import 'utils/utils.dart';

void main() {
  group('FlippyCountedController', () {
    group('initial state', () {
      const expected = FlippyControllerState(current: 0, vector: 0, next: 0, target: 0, status: FlippyStatus.idling);
      test('state should start at $expected', () {
        final controller = FlippyCountedController();

        final actual = FlippyControllerUtils.getState(controller);
        expect(actual, expected);
      });
    });

    group('toNext', () {
      const expected = {
        1: FlippyControllerState(current: 0, vector: 1, next: 1, target: 1, status: FlippyStatus.movingToNext),
        2: FlippyControllerState(current: -5, vector: 1, next: -4, target: -4, status: FlippyStatus.movingToNext),
        3: FlippyControllerState(current: 0, vector: 1, next: 1, target: 1, status: FlippyStatus.movingToNext),
        4: FlippyControllerState(current: 1, vector: 0, next: 1, target: 1, status: FlippyStatus.idling),
        5: FlippyControllerState(current: 1, vector: 1, next: 2, target: 2, status: FlippyStatus.movingToNext),
        6: FlippyControllerState(current: 1, vector: 0, next: 1, target: 1, status: FlippyStatus.idling),
      };

      test('state should be equal to ${expected[1]}', () {
        final controller = FlippyCountedController();

        controller.toNext();

        final actual = FlippyControllerUtils.getState(controller);
        expect(actual, expected[1]);
      });

      test('state should be equal to ${expected[2]}', () {
        final controller = FlippyCountedController();

        controller.setTo(-5);
        controller.toNext();

        final actual = FlippyControllerUtils.getState(controller);
        expect(actual, expected[2]);
      });

      test('state should be equal to ${expected[3]}', () {
        final controller = FlippyCountedController();

        controller.toNext();
        controller.toNext();

        final actual = FlippyControllerUtils.getState(controller);
        expect(actual, expected[3]);
      });

      test('state should be equal to ${expected[4]}', () {
        final controller = FlippyCountedController();
        final updater = controller as UpdateNotifier;

        controller.toNext();
        updater.update();

        final actual = FlippyControllerUtils.getState(controller);
        expect(actual, expected[4]);
      });

      test('state should be equal to ${expected[5]}', () {
        final controller = FlippyCountedController();
        final updater = controller as UpdateNotifier;

        controller.toNext();
        updater.update();
        controller.toNext();

        final actual = FlippyControllerUtils.getState(controller);
        expect(actual, expected[5]);
      });

      test('state should be equal to ${expected[6]}', () {
        final controller = FlippyCountedController();
        final updater = controller as UpdateNotifier;

        controller.toNext();
        updater.update();
        updater.update();

        final actual = FlippyControllerUtils.getState(controller);
        expect(actual, expected[6]);
      });
    });

    group('toPrevious', () {
      const expected = {
        1: FlippyControllerState(current: 0, vector: -1, next: -1, target: -1, status: FlippyStatus.movingToPrevious),
        2: FlippyControllerState(current: -5, vector: -1, next: -6, target: -6, status: FlippyStatus.movingToPrevious),
        3: FlippyControllerState(current: 0, vector: -1, next: -1, target: -1, status: FlippyStatus.movingToPrevious),
        4: FlippyControllerState(current: -1, vector: 0, next: -1, target: -1, status: FlippyStatus.idling),
        5: FlippyControllerState(current: -1, vector: -1, next: -2, target: -2, status: FlippyStatus.movingToPrevious),
        6: FlippyControllerState(current: -1, vector: 0, next: -1, target: -1, status: FlippyStatus.idling),
      };

      test('state should be equal to ${expected[1]}', () {
        final controller = FlippyCountedController();

        controller.toPrevious();

        final actual = FlippyControllerUtils.getState(controller);
        expect(actual, expected[1]);
      });

      test('state should be equal to ${expected[2]}', () {
        final controller = FlippyCountedController();

        controller.setTo(-5);
        controller.toPrevious();

        final actual = FlippyControllerUtils.getState(controller);
        expect(actual, expected[2]);
      });

      test('state should be equal to ${expected[3]}', () {
        final controller = FlippyCountedController();

        controller.toPrevious();
        controller.toPrevious();

        final actual = FlippyControllerUtils.getState(controller);
        expect(actual, expected[3]);
      });

      test('state should be equal to ${expected[4]}', () {
        final controller = FlippyCountedController();
        final updater = controller as UpdateNotifier;

        controller.toPrevious();
        updater.update();

        final actual = FlippyControllerUtils.getState(controller);
        expect(actual, expected[4]);
      });

      test('state should be equal to ${expected[5]}', () {
        final controller = FlippyCountedController();
        final updater = controller as UpdateNotifier;

        controller.toPrevious();
        updater.update();
        controller.toPrevious();

        final actual = FlippyControllerUtils.getState(controller);
        expect(actual, expected[5]);
      });

      test('state should be equal to ${expected[6]}', () {
        final controller = FlippyCountedController();
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
        3: FlippyControllerState(current: 0, vector: -1, next: -1, target: -1, status: FlippyStatus.movingToPrevious),
        4: FlippyControllerState(current: -5, vector: 3, next: -4, target: -2, status: FlippyStatus.movingToNext),
        5: FlippyControllerState(current: -5, vector: -3, next: -6, target: -8, status: FlippyStatus.movingToPrevious),
        6: FlippyControllerState(current: 0, vector: 5, next: 1, target: 5, status: FlippyStatus.movingToNext),
        7: FlippyControllerState(current: 0, vector: -5, next: -1, target: -5, status: FlippyStatus.movingToPrevious),
        8: FlippyControllerState(current: 0, vector: 5, next: 1, target: 5, status: FlippyStatus.movingToNext),
        9: FlippyControllerState(current: 0, vector: -5, next: -1, target: -5, status: FlippyStatus.movingToPrevious),
        10: FlippyControllerState(current: 1, vector: 0, next: 1, target: 1, status: FlippyStatus.idling),
        11: FlippyControllerState(current: -1, vector: 0, next: -1, target: -1, status: FlippyStatus.idling),
        12: FlippyControllerState(current: 1, vector: 4, next: 2, target: 5, status: FlippyStatus.movingToNext),
        13: FlippyControllerState(current: -1, vector: -4, next: -2, target: -5, status: FlippyStatus.movingToPrevious),
        14: FlippyControllerState(current: 1, vector: 4, next: 2, target: 5, status: FlippyStatus.movingToNext),
        15: FlippyControllerState(current: -1, vector: -4, next: -2, target: -5, status: FlippyStatus.movingToPrevious),
        16: FlippyControllerState(current: 1, vector: 4, next: 2, target: 5, status: FlippyStatus.movingToNext),
        17: FlippyControllerState(current: -1, vector: -4, next: -2, target: -5, status: FlippyStatus.movingToPrevious),
        18: FlippyControllerState(current: 2, vector: 2, next: 3, target: 4, status: FlippyStatus.movingToNext),
        19: FlippyControllerState(current: -2, vector: -2, next: -3, target: -4, status: FlippyStatus.movingToPrevious),
        20: FlippyControllerState(current: 3, vector: 0, next: 3, target: 3, status: FlippyStatus.idling),
        21: FlippyControllerState(current: -3, vector: 0, next: -3, target: -3, status: FlippyStatus.idling),
        22: FlippyControllerState(current: 3, vector: 0, next: 3, target: 3, status: FlippyStatus.idling),
        23: FlippyControllerState(current: -3, vector: 0, next: -3, target: -3, status: FlippyStatus.idling),
      };

      test('state should be equal to ${expected[1]}', () {
        final controller = FlippyCountedController();

        controller.moveBy(1);

        final actual = FlippyControllerUtils.getState(controller);
        expect(actual, expected[1]);
      });

      test('state should be equal to ${expected[2]}', () {
        final controller = FlippyCountedController();

        controller.moveBy(0);

        final actual = FlippyControllerUtils.getState(controller);
        expect(actual, expected[2]);
      });

      test('state should be equal to ${expected[3]}', () {
        final controller = FlippyCountedController();

        controller.moveBy(-1);

        final actual = FlippyControllerUtils.getState(controller);
        expect(actual, expected[3]);
      });

      test('state should be equal to ${expected[4]}', () {
        final controller = FlippyCountedController();

        controller.setTo(-5);
        controller.moveBy(3);

        final actual = FlippyControllerUtils.getState(controller);
        expect(actual, expected[4]);
      });

      test('state should be equal to ${expected[5]}', () {
        final controller = FlippyCountedController();

        controller.setTo(-5);
        controller.moveBy(-3);

        final actual = FlippyControllerUtils.getState(controller);
        expect(actual, expected[5]);
      });

      test('state should be equal to ${expected[6]}', () {
        final controller = FlippyCountedController();

        controller.moveBy(5);

        final actual = FlippyControllerUtils.getState(controller);
        expect(actual, expected[6]);
      });

      test('state should be equal to ${expected[7]}', () {
        final controller = FlippyCountedController();

        controller.moveBy(-5);

        final actual = FlippyControllerUtils.getState(controller);
        expect(actual, expected[7]);
      });

      test('state should be equal to ${expected[8]}', () {
        final controller = FlippyCountedController();

        controller.moveBy(5);
        controller.moveBy(10);

        final actual = FlippyControllerUtils.getState(controller);
        expect(actual, expected[8]);
      });

      test('state should be equal to ${expected[9]}', () {
        final controller = FlippyCountedController();

        controller.moveBy(-5);
        controller.moveBy(-10);

        final actual = FlippyControllerUtils.getState(controller);
        expect(actual, expected[9]);
      });

      test('state should be equal to ${expected[10]}', () {
        final controller = FlippyCountedController();
        final updater = controller as UpdateNotifier;

        controller.moveBy(1);
        updater.update();

        final actual = FlippyControllerUtils.getState(controller);
        expect(actual, expected[10]);
      });

      test('state should be equal to ${expected[11]}', () {
        final controller = FlippyCountedController();
        final updater = controller as UpdateNotifier;

        controller.moveBy(-1);
        updater.update();

        final actual = FlippyControllerUtils.getState(controller);
        expect(actual, expected[11]);
      });

      test('state should be equal to ${expected[12]}', () {
        final controller = FlippyCountedController();
        final updater = controller as UpdateNotifier;

        controller.moveBy(1);
        updater.update();
        controller.moveBy(4);

        final actual = FlippyControllerUtils.getState(controller);
        expect(actual, expected[12]);
      });

      test('state should be equal to ${expected[13]}', () {
        final controller = FlippyCountedController();
        final updater = controller as UpdateNotifier;

        controller.moveBy(-1);
        updater.update();
        controller.moveBy(-4);

        final actual = FlippyControllerUtils.getState(controller);
        expect(actual, expected[13]);
      });

      test('state should be equal to ${expected[14]}', () {
        final controller = FlippyCountedController();
        final updater = controller as UpdateNotifier;

        controller.moveBy(5);
        updater.update();

        final actual = FlippyControllerUtils.getState(controller);
        expect(actual, expected[14]);
      });

      test('state should be equal to ${expected[15]}', () {
        final controller = FlippyCountedController();
        final updater = controller as UpdateNotifier;

        controller.moveBy(-5);
        updater.update();

        final actual = FlippyControllerUtils.getState(controller);
        expect(actual, expected[15]);
      });

      test('state should be equal to ${expected[16]}', () {
        final controller = FlippyCountedController();
        final updater = controller as UpdateNotifier;

        controller.moveBy(5);
        updater.update();
        controller.moveBy(10);

        final actual = FlippyControllerUtils.getState(controller);
        expect(actual, expected[16]);
      });

      test('state should be equal to ${expected[17]}', () {
        final controller = FlippyCountedController();
        final updater = controller as UpdateNotifier;

        controller.moveBy(-5);
        updater.update();
        controller.moveBy(-10);

        final actual = FlippyControllerUtils.getState(controller);
        expect(actual, expected[17]);
      });

      test('state should be equal to ${expected[18]}', () {
        final controller = FlippyCountedController();
        final updater = controller as UpdateNotifier;

        controller.moveBy(4);
        updater.update();
        updater.update();

        final actual = FlippyControllerUtils.getState(controller);
        expect(actual, expected[18]);
      });

      test('state should be equal to ${expected[19]}', () {
        final controller = FlippyCountedController();
        final updater = controller as UpdateNotifier;

        controller.moveBy(-4);
        updater.update();
        updater.update();

        final actual = FlippyControllerUtils.getState(controller);
        expect(actual, expected[19]);
      });

      test('state should be equal to ${expected[20]}', () {
        final controller = FlippyCountedController();
        final updater = controller as UpdateNotifier;

        controller.moveBy(3);
        updater.update();
        updater.update();
        updater.update();

        final actual = FlippyControllerUtils.getState(controller);
        expect(actual, expected[20]);
      });

      test('state should be equal to ${expected[21]}', () {
        final controller = FlippyCountedController();
        final updater = controller as UpdateNotifier;

        controller.moveBy(-3);
        updater.update();
        updater.update();
        updater.update();

        final actual = FlippyControllerUtils.getState(controller);
        expect(actual, expected[21]);
      });

      test('state should be equal to ${expected[22]}', () {
        final controller = FlippyCountedController();
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
        final controller = FlippyCountedController();
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
        4: FlippyControllerState(current: -6, vector: 0, next: -6, target: -6, status: FlippyStatus.idling),
        5: FlippyControllerState(current: -10, vector: 0, next: -10, target: -10, status: FlippyStatus.idling),
      };

      test('state should be equal to ${expected[1]}', () {
        final controller = FlippyCountedController();

        controller.setTo(0);
        final actual = FlippyControllerUtils.getState(controller);
        expect(actual, expected[1]);
      });

      test('state should be equal to ${expected[2]}', () {
        final controller = FlippyCountedController();

        controller.setTo(8);

        final actual = FlippyControllerUtils.getState(controller);
        expect(actual, expected[2]);
      });

      test('state should be equal to ${expected[3]}', () {
        final controller = FlippyCountedController();
        final updater = controller as UpdateNotifier;

        controller.setTo(5);
        updater.update();

        final actual = FlippyControllerUtils.getState(controller);
        expect(actual, expected[3]);
      });

      test('state should be equal to ${expected[4]}', () {
        final controller = FlippyCountedController();

        controller.setTo(-6);

        final actual = FlippyControllerUtils.getState(controller);
        expect(actual, expected[4]);
      });

      test('state should be equal to ${expected[5]}', () {
        final controller = FlippyCountedController();
        final updater = controller as UpdateNotifier;

        controller.setTo(-10);
        updater.update();

        final actual = FlippyControllerUtils.getState(controller);
        expect(actual, expected[5]);
      });
    });
  });
}
