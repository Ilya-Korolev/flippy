import 'package:flutter/material.dart';
import 'package:flip_clock/constants.dart';

class ClockColon extends StatelessWidget {
  final double size;

  const ClockColon({required this.size, Key? key}) : super(key: key);

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
  final double size;

  const _Dot({required this.size, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: const BoxDecoration(
        color: kPrimaryColor,
        borderRadius: kBorderRadius,
      ),
    );
  }
}
