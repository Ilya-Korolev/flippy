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
          child: const Center(
            child: Clock(),
          ),
        ),
      ),
    );
  }
}
