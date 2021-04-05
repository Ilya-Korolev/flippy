import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'models/models.dart';
import 'widgets/widgets.dart';

enum FlippyViewStatus { ready, inProgress }

class FlippyView extends StatefulWidget {
  late final FlippyController flippyController;
  late final Widget Function(BuildContext context, int index) widgetBuilder;
  late final Transition Function(int index) transitionBuilder;
  final int count;
  final double gap;
  final double perspective;

  FlippyView.builder({
    required this.flippyController,
    required this.widgetBuilder,
    required this.transitionBuilder,
    required this.count,
    this.gap = 0.0,
    this.perspective = 0.0,
    Key? key,
  })  : assert(count > 0),
        assert(gap >= 0),
        assert(perspective >= 0),
        super(key: key) {
    flippyController._count = count;
  }

  FlippyView.oneShot({
    required Widget start,
    required Widget end,
    required Transition transition,
    this.gap = 0.0,
    this.perspective = 0.0,
    Key? key,
  })  : assert(gap >= 0),
        assert(perspective >= 0),
        count = 2,
        super(key: key) {
    flippyController = FlippyController()
      .._count = count
      ..moveNext();

    widgetBuilder = (context, index) => index == 0 ? start : end;
    transitionBuilder = (index) => transition;
  }

  @override
  _FlippyViewState createState() => _FlippyViewState();
}

class _FlippyViewState extends State<FlippyView> with TickerProviderStateMixin {
  late final AnimationController _animationController;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(vsync: this);

    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        widget.flippyController._update();
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();

    super.dispose();
  }

  Animation<double> _buildAnimation(Transition transition) {
    _animationController.duration = transition.duration;
    _animationController
      ..reset()
      ..forward();

    final curved = CurvedAnimation(parent: _animationController, curve: transition.curve);
    final directed = transition.direction == FlipDirection.forward ? curved : ReverseAnimation(curved);

    final tween = Tween<double>(
      begin: 0.0,
      end: math.pi,
    ).animate(directed);

    return tween;
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<GlobalParameters>(
          create: (context) => GlobalParameters(gap: widget.gap, perspective: widget.perspective),
        ),
        ChangeNotifierProvider<FlippyController>.value(
          value: widget.flippyController,
        ),
      ],
      child: Consumer<FlippyController>(
        builder: (context, controller, child) {
          if (controller.status == FlippyViewStatus.ready) {
            return StaticContainer(child: widget.widgetBuilder(context, controller.current));
          }

          final transition = widget.transitionBuilder(controller.current);
          final animation = _buildAnimation(transition);

          final current = widget.widgetBuilder(context, controller.current);
          final next = widget.widgetBuilder(context, controller.next);

          return FlippyContainer(
            current: transition.direction == FlipDirection.forward ? current : next,
            next: transition.direction == FlipDirection.forward ? next : current,
            animation: animation,
          );
        },
      ),
    );
  }
}

class FlippyController with ChangeNotifier {
  int _count = 0;
  int _current = 0;
  int _target = 0;

  int get count => _count;
  int get current => _current;
  int get next => _current + 1 < _count ? _current + 1 : 0;
  int get target => _target;

  FlippyViewStatus get status => _current == _target ? FlippyViewStatus.ready : FlippyViewStatus.inProgress;

  void moveNext() {
    if (status != FlippyViewStatus.ready) {
      return;
    }

    _target = current + 1;
  }

  void moveNextN(int n) {
    assert(n > 0);

    if (status != FlippyViewStatus.ready) {
      return;
    }

    _target = current + n;
  }

  void moveTo(int index) {
    assert(index >= 0);

    if (status != FlippyViewStatus.ready) {
      return;
    }

    if (index == current) {
      return;
    }

    _target = index - current;

    if (_target < 0) {
      _target += count;
    }
  }

  void _update() {
    ++_current;

    if (_current >= _count) {
      _current -= _count;
      if (_target >= _count) _target -= _count;
    }

    notifyListeners();
  }
}
