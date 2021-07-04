import 'package:flutter/material.dart';

class DigitCard extends StatelessWidget {
  final String text;

  const DigitCard({
    required this.text,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250.0,
      height: 250.0,
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 150.0,
        ),
      ),
      decoration: const BoxDecoration(
        color: Color(0xFF4D4C4F),
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
      ),
    );
  }
}
