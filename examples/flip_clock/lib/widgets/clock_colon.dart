import 'package:flip_clock/models/models.dart';
import 'package:flutter/material.dart';
import 'package:flip_clock/constants.dart';
import 'package:provider/provider.dart';

class ClockColon extends StatelessWidget {
  const ClockColon({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ClockParams>(
      builder: (context, params, _) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const _Dot(),
            SizedBox(height: params.colonSize * 2.0),
            const _Dot(),
          ],
        );
      },
    );
  }
}

class _Dot extends StatelessWidget {
  const _Dot({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ClockParams>(
      builder: (context, params, _) => Container(
        width: params.colonSize,
        height: params.colonSize,
        decoration: BoxDecoration(
          color: kPrimaryColor,
          borderRadius: BorderRadius.all(
            Radius.circular(params.colonSize),
          ),
        ),
      ),
    );
  }
}
