import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flippy/flippy.dart';

void main() {
  testWidgets('FlippyView.builder shows transitions between some widgets one by one', (WidgetTester tester) async {
    final children = [
      Container(height: 100, width: 100, child: Text('0')),
      Container(height: 100, width: 100, child: Text('1')),
      Container(height: 100, width: 100, child: Text('2')),
      Container(height: 100, width: 100, child: Text('3')),
      Container(height: 100, width: 100, child: Text('4')),
    ];

    await tester.pumpWidget(
      Directionality(
        textDirection: TextDirection.ltr,
        child: FlippyView.builder(
          perspective: 0.002,
          spacing: 7.5,
          flippyController: FlippySimpleController()..moveBy(children.length - 1),
          widgetBuilder: (_, index) => children[index],
          transitionBuilder: (index) => const FlippyTransition(duration: Duration(milliseconds: 1000)),
        ),
      ),
    );

    for (var i = 0; i < children.length; ++i) {
      if (i != 0) {
        await tester.pump(Duration(milliseconds: 1001));
      }

      expect(find.text('$i'), findsWidgets);
    }
  });

  testWidgets('FlippyView.builder shows transitions between some widgets one by one', (WidgetTester tester) async {
    final children = [
      Container(height: 100, width: 100, child: Text('0')),
      Container(height: 100, width: 100, child: Text('1')),
      Container(height: 100, width: 100, child: Text('2')),
    ];

    await tester.pumpWidget(
      Directionality(
        textDirection: TextDirection.ltr,
        child: FlippyView.builder(
          perspective: 0.002,
          spacing: 7.5,
          flippyController: FlippyLoopedController(length: children.length)..moveForwardTo(children.length - 1),
          widgetBuilder: (_, index) => children[index],
          transitionBuilder: (index) => const FlippyTransition(duration: Duration(milliseconds: 1000)),
        ),
      ),
    );

    for (var i = 0; i < children.length; ++i) {
      if (i != 0) {
        await tester.pump(Duration(milliseconds: 1001));
      }

      expect(find.text('$i'), findsWidgets);
    }
  });
}
