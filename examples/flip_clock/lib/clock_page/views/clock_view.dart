import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../utils/utils.dart';
import '../cubit/clock_cubit.dart';
import '../widgets/widgets.dart';

class ClockView extends StatelessWidget {
  const ClockView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider<ClockCubit>(
        create: (context) => ClockCubit(clockwork: Clockwork())..wind(DateTime.now()),
        child: Center(
          child: LayoutBuilder(
            builder: (context, constraints) {
              if (constraints.maxWidth < 500.0) {
                return const Clock(
                  width: 300.0,
                  height: 75.0,
                  colonSize: 7.5,
                  fontSize: 45.0,
                  cardSpacing: 2.5,
                  perspective: 0.007,
                  borderRadius: 2.5,
                );
              }

              if (constraints.maxWidth < 800.0) {
                return const Clock(
                  width: 490.0,
                  height: 120.0,
                  colonSize: 12.5,
                  fontSize: 100.0,
                  cardSpacing: 3.5,
                  perspective: 0.0035,
                  borderRadius: 3.5,
                );
              }

              if (constraints.maxWidth < 1200.0) {
                return const Clock(
                  width: 770.0,
                  height: 200.0,
                  colonSize: 17.5,
                  fontSize: 170.0,
                  cardSpacing: 5.5,
                  perspective: 0.002,
                  borderRadius: 5.0,
                );
              }

              return const Clock(
                width: 1150.0,
                height: 320.0,
                colonSize: 25.0,
                fontSize: 290.0,
                cardSpacing: 7.5,
                perspective: 0.0007,
                borderRadius: 7.5,
              );
            },
          ),
        ),
      ),
    );
  }
}
