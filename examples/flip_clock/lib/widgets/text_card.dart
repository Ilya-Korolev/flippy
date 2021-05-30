import 'package:flip_clock/models/clock_params.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../constants.dart';

class TextCard extends StatelessWidget {
  final String text;

  const TextCard({
    required this.text,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ClockParams>(
      builder: (context, params, _) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        alignment: Alignment.center,
        child: Text(
          text,
          style: GoogleFonts.inconsolata(
            fontSize: params.digitSize,
            fontWeight: FontWeight.w300,
            color: kSecondaryColor,
          ),
        ),
        decoration: BoxDecoration(
          color: kPrimaryColor,
          borderRadius: BorderRadius.all(Radius.circular(params.borderRadius)),
        ),
      ),
    );
  }
}
