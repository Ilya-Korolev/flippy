import 'package:flippy/flippy.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../widgets/widgets.dart';

class CounterPage extends StatefulWidget {
  const CounterPage({Key? key}) : super(key: key);

  @override
  _CounterPageState createState() => _CounterPageState();
}

class _CounterPageState extends State<CounterPage> {
  late final FlippyCountedController _flippyController;
  late final NumberFormat _formatter;

  @override
  void initState() {
    _flippyController = FlippyCountedController();
    _formatter = NumberFormat('00');
    super.initState();
  }

  @override
  void dispose() {
    _flippyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Counter')),
      body: Center(
        child: FlippyView.builder(
          flippyController: _flippyController,
          widgetBuilder: (context, index) => DigitCard(text: _formatter.format(index)),
          transitionBuilder: (index) => FlippyTransition(
            duration: Duration(milliseconds: 700),
            curve: Curves.decelerate,
          ),
          spacing: 5.0,
          perspective: 0.002,
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          FloatingActionButton(
            child: const Icon(Icons.add),
            onPressed: () => _flippyController.toNext(),
          ),
          const SizedBox(height: 8),
          FloatingActionButton(
            child: const Icon(Icons.remove),
            onPressed: () => _flippyController.toPrevious(),
          ),
        ],
      ),
    );
  }
}
