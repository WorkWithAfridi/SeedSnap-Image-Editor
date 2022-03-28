import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:seedsnap_image_editor/constants/colors.dart';

TextStyle defaultTS = GoogleFonts.getFont(
  'Ubuntu Condensed',
  textStyle: TextStyle(
    fontSize: 16,
    color: primary
  ),
);
TextStyle titleTS = GoogleFonts.getFont(
  'Fredoka One',
  textStyle: TextStyle(
    fontSize: 20,
    color: primary
  ),
);

final TextStyle creatorTextStyle = GoogleFonts.getFont(
  'Indie Flower',
  textStyle: const TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 15,
      height: .5,
      color: Colors.pink),
);
