import 'package:flutter/material.dart';
import 'package:flip_clock/constants.dart';

class Colon extends StatelessWidget {
  const Colon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: const [
        _Dot(),
        SizedBox(height: 35.0),
        _Dot(),
      ],
    );
  }
}

class _Dot extends StatelessWidget {
  const _Dot({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 20.0,
      height: 20.0,
      decoration: const BoxDecoration(
        color: kPrimaryColor,
        borderRadius: kBorderRadius,
      ),
    );
  }
}
