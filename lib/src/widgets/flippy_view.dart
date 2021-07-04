import 'package:flippy/src/controllers/controllers.dart';
import 'package:flippy/src/models/models.dart';
import 'package:flippy/src/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FlippyView extends StatefulWidget {
  late final FlippyController flippyController;
  late final Widget Function(BuildContext context, int index) widgetBuilder;
  late final FlippyTransition Function(int index) transitionBuilder;
  final bool autoReverse;
  final double spacing;
  final double perspective;

  FlippyView.builder({
    required this.flippyController,
    required this.widgetBuilder,
    required this.transitionBuilder,
    this.autoReverse = true,
    this.spacing = 0.0,
    this.perspective = 0.0,
    Key? key,
  })  : assert(spacing >= 0),
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
        final internalController = widget.flippyController as UpdateNotifier;

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
          if (controller.status == FlippyStatus.idling) {
            return Split(
              child: widget.widgetBuilder(context, controller.current),
              spacing: widget.spacing,
            );
          }

          final transition = widget.autoReverse && controller.status == FlippyStatus.movingToPrevious
              ? widget.transitionBuilder(controller.current).reversed()
              : widget.transitionBuilder(controller.current);

          final animation = _buildAnimation(transition);

          final current = widget.widgetBuilder(context, controller.current);
          final next = widget.widgetBuilder(context, controller.next);

          return AnimatedBuilder(
            animation: animation,
            builder: (context, child) => SplitFlap(
              current: transition.direction == FlipDirection.forward ? current : next,
              next: transition.direction == FlipDirection.forward ? next : current,
              spacing: widget.spacing,
              perspective: widget.perspective,
              animationValue: animation.value,
            ),
          );
        },
      ),
    );
  }
}
