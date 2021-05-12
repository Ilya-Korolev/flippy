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
          child: LayoutBuilder(
            builder: (context, constraints) {
              if (constraints.maxWidth < 500.0) {
                return const Center(
                  child: Clock(
                    width: 300.0,
                    height: 75.0,
                    colonSize: 7.5,
                    digitSize: 45.0,
                    digitSpacing: 2.5,
                    digitPerspective: 0.007,
                  ),
                );
              }

              if (constraints.maxWidth < 800.0) {
                return const Center(
                  child: Clock(
                    width: 490.0,
                    height: 120.0,
                    colonSize: 12.5,
                    digitSize: 100.0,
                    digitSpacing: 3.5,
                    digitPerspective: 0.0035,
                  ),
                );
              }

              if (constraints.maxWidth < 1200.0) {
                return const Center(
                  child: Clock(
                    width: 770.0,
                    height: 200.0,
                    colonSize: 17.5,
                    digitSize: 170.0,
                    digitSpacing: 5.5,
                    digitPerspective: 0.002,
                  ),
                );
              }

              return const Center(
                child: Clock(
                  width: 1150.0,
                  height: 320.0,
                  colonSize: 25.0,
                  digitSize: 290.0,
                  digitSpacing: 7.5,
                  digitPerspective: 0.0007,
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
