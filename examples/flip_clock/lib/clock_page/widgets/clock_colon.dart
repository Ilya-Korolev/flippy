import 'package:flutter/material.dart';
import 'package:flip_clock/constants.dart';

class ClockColon extends StatelessWidget {
  const ClockColon({
    required this.size,
    Key? key,
  }) : super(key: key);

  final double size;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _Dot(size: size),
        SizedBox(height: size * 2.0),
        _Dot(size: size),
      ],
    );
  }
}

class _Dot extends StatelessWidget {
  const _Dot({
    required this.size,
    Key? key,
  }) : super(key: key);

  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: kPrimaryColor,
        borderRadius: BorderRadius.all(
          Radius.circular(size),
        ),
      ),
    );
  }
}
