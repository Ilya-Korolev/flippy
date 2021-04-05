import 'dart:math' as math;

import 'package:flippy/src/models/models.dart';
import 'package:flippy/src/utils/half_calculation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Assertion errors;', () {
    test("A negative 'gap' should throw an assertion error", () {
      expect(() => HalfCalculation(gap: -1.0, perspective: -0.0, type: HalfType.top), throwsAssertionError);
    });

    test("A negative 'perspective' should throw an assertion error", () {
      expect(() => HalfCalculation(gap: 0.0, perspective: -0.01, type: HalfType.top), throwsAssertionError);
    });
  });

  group('Top half calculation testing;', () {
    test("'perspective' should be non-negative", () {
      var calc = HalfCalculation(gap: 0.0, perspective: 0.0, type: HalfType.top);

      calc.update(0.0);
      expect(calc.perspective, isNonNegative);
      calc.update(2.3);
      expect(calc.perspective, isNonNegative);
      calc.update(-3.5);
      expect(calc.perspective, isNonNegative);

      calc = HalfCalculation(gap: 12134.1, perspective: 10.0, type: HalfType.top);

      calc.update(0.0);
      expect(calc.perspective, isNonNegative);
      calc.update(2.3);
      expect(calc.perspective, isNonNegative);
      calc.update(-3.5);
      expect(calc.perspective, isNonNegative);
    });

    test("'alignment' should be 'bottomCenter'", () {
      var calc = HalfCalculation(gap: 0.0, perspective: 0.0, type: HalfType.top);

      calc.update(0.0);
      expect(calc.alignment, Alignment.bottomCenter);
      calc.update(6.1);
      expect(calc.alignment, Alignment.bottomCenter);
      calc.update(-0.5);
      expect(calc.alignment, Alignment.bottomCenter);

      calc = HalfCalculation(gap: 1.3, perspective: 0.002, type: HalfType.top);

      calc.update(0.0);
      expect(calc.alignment, Alignment.bottomCenter);
      calc.update(1.0);
      expect(calc.alignment, Alignment.bottomCenter);
      calc.update(-23.9);
      expect(calc.alignment, Alignment.bottomCenter);
    });

    group("'degree' testing;", () {
      const testData = [
        [0.0, 0.0],
        [math.pi / 3.0, math.pi / 3.0],
        [math.pi / 2.0, math.pi / 2.0],
        [math.pi, math.pi],
      ];

      for (var data in testData) {
        final updateValue = data[0];
        final expected = data[1];

        test("calculation updated with $updateValue; 'degree' should be equal $expected", () {
          final calc = HalfCalculation(gap: 10.3, perspective: 0.42, type: HalfType.top);

          calc.update(updateValue);
          expect(calc.degree, expected);
        });
      }
    });

    group("'offset' testing;", () {
      const testData = [
        [0.0, 0.0, 0.0],
        [2.3, 0.0, 0.0],
        [-1.5, 0.0, 0.0],
        [0.0, 5.5, 0.0],
        [math.pi, 4.8, 4.8],
        [-math.pi / 2.0, 9.5, 4.75],
      ];

      for (var data in testData) {
        final updateValue = data[0];
        final gap = data[1];
        final expected = data[2];

        test("calculation updated with $updateValue; 'offset' should be equal $expected (at 'gap' = $gap)", () {
          final calc = HalfCalculation(gap: gap, perspective: 0.42, type: HalfType.top);

          calc.update(updateValue);
          expect(calc.offset, expected);
        });
      }
    });

    group("'isVisible' testing;", () {
      const testData = [
        [-math.pi, false],
        [-math.pi / 2.0, false],
        [-math.pi / 3.0, true],
        [-math.pi / 4.0, true],
        [0.0, true],
        [math.pi / 4.0, true],
        [math.pi / 3.0, true],
        [math.pi / 2.0, false],
        [math.pi, false],
      ];

      for (var data in testData) {
        final updateValue = data[0] as double;
        final expected = data[1] as bool;

        test("calculation updated with $updateValue; 'isVisible' should be equal $expected", () {
          final calc = HalfCalculation(gap: 1.1, perspective: 0.12, type: HalfType.top);

          calc.update(updateValue);
          expect(calc.isVisible, expected);
        });
      }
    });
  });

  group('Bottom half calculation testing;', () {
    test("'perspective' should be non-positive", () {
      var calc = HalfCalculation(gap: 0.0, perspective: 0.0, type: HalfType.bottom);

      calc.update(0.0);
      expect(calc.perspective, isNonPositive);
      calc.update(2.3);
      expect(calc.perspective, isNonPositive);
      calc.update(-3.5);
      expect(calc.perspective, isNonPositive);

      calc = HalfCalculation(gap: 12134.1, perspective: 10.0, type: HalfType.bottom);

      calc.update(0.0);
      expect(calc.perspective, isNonPositive);
      calc.update(2.3);
      expect(calc.perspective, isNonPositive);
      calc.update(-3.5);
      expect(calc.perspective, isNonPositive);
    });

    test("'alignment' should be 'topCenter'", () {
      var calc = HalfCalculation(gap: 0.0, perspective: 0.0, type: HalfType.bottom);

      calc.update(0.0);
      expect(calc.alignment, Alignment.topCenter);
      calc.update(6.1);
      expect(calc.alignment, Alignment.topCenter);
      calc.update(-0.5);
      expect(calc.alignment, Alignment.topCenter);

      calc = HalfCalculation(gap: 1.3, perspective: 0.002, type: HalfType.bottom);

      calc.update(0.0);
      expect(calc.alignment, Alignment.topCenter);
      calc.update(1.0);
      expect(calc.alignment, Alignment.topCenter);
      calc.update(-23.9);
      expect(calc.alignment, Alignment.topCenter);
    });

    group("'degree' testing;", () {
      const testData = [
        [0.0, math.pi],
        [math.pi / 4.0, 3.0 * math.pi / 4.0],
        [math.pi / 2.0, math.pi / 2.0],
        [math.pi, 0.0],
      ];

      for (var data in testData) {
        final updateValue = data[0];
        final expected = data[1];

        test("calculation updated with $updateValue; 'degree' should be equal $expected", () {
          final calc = HalfCalculation(gap: 10.3, perspective: 0.42, type: HalfType.bottom);

          calc.update(updateValue);
          expect(calc.degree, expected);
        });
      }
    });

    group("'offset' testing;", () {
      const testData = [
        [0.0, 0.0, 0.0],
        [2.3, 0.0, 0.0],
        [-1.5, 0.0, 0.0],
        [0.0, 5.0, -5.0],
        [math.pi, 4.8, 0.0],
        [math.pi / 2.0, 9.5, -4.75],
      ];

      for (var data in testData) {
        final updateValue = data[0];
        final gap = data[1];
        final expected = data[2];

        test("calculation updated with $updateValue; 'offset' should be equal $expected (at 'gap' = $gap)", () {
          final calc = HalfCalculation(gap: gap, perspective: 0.42, type: HalfType.bottom);

          calc.update(updateValue);
          expect(calc.offset, expected);
        });
      }
    });

    group("'isVisible' testing;", () {
      const testData = [
        [0.0, false],
        [math.pi / 2.0, false],
        [2.0 * math.pi / 3.0, true],
        [3.0 * math.pi / 4.0, true],
        [math.pi, true],
        [5.0 * math.pi / 4.0, true],
        [4.0 * math.pi / 3.0, true],
        [3.0 * math.pi / 2.0, false],
        [2.0 * math.pi, false],
      ];

      for (var data in testData) {
        final updateValue = data[0] as double;
        final expected = data[1] as bool;

        test("calculation updated with $updateValue; 'isVisible' should be equal $expected", () {
          final calc = HalfCalculation(gap: 1.1, perspective: 0.12, type: HalfType.bottom);

          calc.update(updateValue);
          expect(calc.isVisible, expected);
        });
      }
    });
  });
}
