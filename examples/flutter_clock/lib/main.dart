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
        body: Center(
          // child: FlippyView.oneShot(
          //   start: Container(
          //     child: Text('1', style: TextStyle(fontSize: 200, color: Colors.greenAccent)),
          //     decoration: const BoxDecoration(
          //       color: Colors.blue,
          //       borderRadius: BorderRadius.all(Radius.circular(5.0)),
          //     ),
          //   ),
          //   end: Container(
          //     child: Text('2', style: TextStyle(fontSize: 200, color: Colors.greenAccent)),
          //     decoration: const BoxDecoration(
          //       color: Colors.blue,
          //       borderRadius: BorderRadius.all(Radius.circular(5.0)),
          //     ),
          //   ),
          //   transition: const Transition(curve: Curves.bounceOut, duration: Duration(seconds: 1)),
          // ),
          child: FlippyView.builder(
            perspective: 0.0,
            gap: 0.0,
            count: 20,
            flippyController: FlippyController()..moveTo(20),
            flippyBuilder: (_, index) => Container(
              child: Text('${index % 10}', style: TextStyle(fontSize: 200, color: Colors.greenAccent)),
              decoration: const BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
              ),
            ),
            transitionBuilder: (index) {
              if (index.isEven) {
                return const Transition(
                    curve: Curves.decelerate, duration: Duration(seconds: 1), direction: FlipDirection.backward);
              }

              return const Transition(curve: Curves.bounceOut, duration: Duration(seconds: 1));
            },
          ),
        ),
      ),
    );
  }
}
