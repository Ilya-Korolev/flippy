import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'clockwork.dart';
import 'constants.dart';
import 'cubit/clock_cubit.dart';
import 'widgets/widgets.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flip Clock Demo',
      theme: ThemeData(scaffoldBackgroundColor: kBackgroundColor),
      home: Scaffold(
        body: BlocProvider<ClockCubit>(
          create: (context) => ClockCubit(clockwork: Clockwork())..wind(DateTime.now()),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                ClockDigit(type: ClockDigitType.hourFirst),
                SizedBox(width: 25.0),
                ClockDigit(type: ClockDigitType.hourLast),
                SizedBox(width: 17.5),
                Colon(),
                SizedBox(width: 17.5),
                ClockDigit(type: ClockDigitType.minuteFirst),
                SizedBox(width: 25.0),
                ClockDigit(type: ClockDigitType.minuteLast),
                SizedBox(width: 17.5),
                Colon(),
                SizedBox(width: 17.5),
                ClockDigit(type: ClockDigitType.secondFirst),
                SizedBox(width: 25.0),
                ClockDigit(type: ClockDigitType.secondLast),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
