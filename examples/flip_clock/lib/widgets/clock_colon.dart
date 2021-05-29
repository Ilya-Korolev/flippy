import 'package:flutter/material.dart';
import 'package:flip_clock/constants.dart';

class ClockColon extends StatelessWidget {
  final double size;
  final double borderRadius;

  const ClockColon({
    required this.size,
    this.borderRadius = 0.0,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _Dot(
          size: size,
          borderRadius: borderRadius,
        ),
        SizedBox(height: size * 2.0),
        _Dot(
          size: size,
          borderRadius: borderRadius,
        ),
      ],
    );
  }
}

class _Dot extends StatelessWidget {
  final double size;
  final double borderRadius;

  const _Dot({
    required this.size,
    this.borderRadius = 0.0,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: kPrimaryColor,
        borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
      ),
    );
  }
}
