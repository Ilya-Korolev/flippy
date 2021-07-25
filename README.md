# Flippy

A customizable split-flap Flutter widget.

## Getting Started

```dart
  late final FlippySimpleController _controller;

  @override
  void initState() {
    _controller = FlippySimpleController();
    _controller.moveBy(9);

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FlippyView.builder(
          perspective: 0.004,
          spacing: 3.0,
          flippyController: _controller,
          widgetBuilder: (context, index) => Container(
            color: Colors.blueAccent,
            child: Text(index.toString(), style: TextStyle(fontSize: 100.0)),
          ),
          transitionBuilder: (index) => const FlippyTransition(duration: Duration(seconds: 1)),
        ),
      ),
    );
  }
```