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
          child: FlippyOneShot(
            perspective: 0.002,
            gap: 5.0,
            transition: const Transition(
              curve: Curves.bounceOut,
              duration: Duration(seconds: 2),
            ),
            current: Container(
              child: const Text('1', style: TextStyle(fontSize: 200, color: Colors.greenAccent)),
              decoration: const BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
              ),
            ),
            next: Container(
              child: const Text('2', style: TextStyle(fontSize: 200, color: Colors.greenAccent)),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
