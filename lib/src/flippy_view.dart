import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'models/models.dart';
import 'utils/utils.dart';
import 'widgets/widgets.dart';

class FlippyView extends StatefulWidget {
  late final FlippyController flippyController;
  late final Widget Function(BuildContext context, int index) widgetBuilder;
  late final FlippyTransition Function(int index) transitionBuilder;
  final double gap;
  final double perspective;

  FlippyView.builder({
    required this.flippyController,
    required this.widgetBuilder,
    required this.transitionBuilder,
    this.gap = 0.0,
    this.perspective = 0.0,
    Key? key,
  })  : assert(gap >= 0),
        assert(perspective >= 0),
        super(key: key);

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
        final internalController = widget.flippyController as FlippyControllerInternal;

        internalController.update();
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();

    super.dispose();
  }

  Animation<double> _buildAnimation(FlippyTransition transition) {
    _animationController.duration = transition.duration;
    _animationController
      ..reset()
      ..forward();

    final curved = CurvedAnimation(parent: _animationController, curve: transition.curve);
    final directed = transition.direction == FlipDirection.forward ? curved : ReverseAnimation(curved);

    return directed;
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<FlippyController>.value(
      value: widget.flippyController,
      child: Consumer<FlippyController>(
        builder: (context, controller, child) {
          if (controller.status == FlippyViewStatus.ready) {
            return StaticSplit(
              child: widget.widgetBuilder(context, controller.current),
              spacing: widget.gap,
            );
          }

          final transition = widget.transitionBuilder(controller.current);
          final animation = _buildAnimation(transition);

          final current = widget.widgetBuilder(context, controller.current);
          final next = widget.widgetBuilder(context, controller.next);

          return AnimatedBuilder(
            animation: animation,
            builder: (context, child) => SplitFlap(
              current: transition.direction == FlipDirection.forward ? current : next,
              next: transition.direction == FlipDirection.forward ? next : current,
              spacing: widget.gap,
              perspective: widget.perspective,
              animationValue: animation.value,
            ),
          );
        },
      ),
    );
  }
}
