import 'package:flippy/flippy.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Clock Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        body: FlippyView.builder(
          perspective: 0.002,
          gap: 7.5,
          flippyController: FlippyController(count: 20)..moveTo(18),
          widgetBuilder: (_, index) => Container(
            child: Text('${index % 10}', style: TextStyle(fontSize: 200, color: Colors.greenAccent)),
            decoration: const BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.all(Radius.circular(5.0)),
            ),
          ),
          transitionBuilder: (index) {
            // if (index.isEven) {
            //   return const Transition(
            //       curve: Curves.decelerate, duration: Duration(seconds: 1), direction: FlipDirection.backward);
            // }

            return const Transition(curve: Curves.fastOutSlowIn, duration: Duration(seconds: 1));
          },
        ),
      ),
    );
  }
}
