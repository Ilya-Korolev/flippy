import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants.dart';

class TextCard extends StatelessWidget {
  final double textSize;
  final String text;

  const TextCard({
    required this.textSize,
    required this.text,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      alignment: Alignment.center,
      child: Text(
        text,
        style: GoogleFonts.inconsolata(
          fontSize: textSize,
          fontWeight: FontWeight.w300,
          color: kSecondaryColor,
        ),
      ),
      decoration: const BoxDecoration(
        color: kPrimaryColor,
        borderRadius: kBorderRadius,
      ),
    );
  }
}
