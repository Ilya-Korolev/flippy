import 'package:flip_clock/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DigitCard extends StatelessWidget {
  final String text;
  final double? fontSize;
  final double borderRadius;

  const DigitCard({
    required this.text,
    this.fontSize,
    this.borderRadius = 0.0,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(9.0),
      alignment: Alignment.center,
      child: Text(
        text,
        style: GoogleFonts.inconsolata(
          fontSize: fontSize,
          fontWeight: FontWeight.w300,
          color: kSecondaryColor,
          height: 1.027,
        ),
      ),
      decoration: BoxDecoration(
        color: kPrimaryColor,
        borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
      ),
    );
  }
}
