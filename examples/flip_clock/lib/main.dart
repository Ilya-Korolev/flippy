import 'package:flutter/material.dart';

import 'clock_page/clock_page.dart';
import 'constants.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flip Clock Demo',
      theme: ThemeData(scaffoldBackgroundColor: kBackgroundColor),
      home: const ClockView(),
    );
  }
}
