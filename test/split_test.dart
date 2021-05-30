import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flippy/flippy.dart';

void main() {
  testWidgets("Split shows a child widget", (WidgetTester tester) async {
    await tester.pumpWidget(
      Directionality(
        textDirection: TextDirection.ltr,
        child: Split(
          spacing: 7.5,
          child: Container(height: 100, width: 100, child: Text('0')),
        ),
      ),
    );

    final text = find.text('0');
    expect(text, findsWidgets);

    await tester.pump(Duration(milliseconds: 1001));

    expect(text, findsWidgets);
  });
}
