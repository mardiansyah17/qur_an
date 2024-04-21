import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Themes {
  static ThemeData themeData = ThemeData(
      useMaterial3: true,
      fontFamily: GoogleFonts.poppins().fontFamily,
      appBarTheme: AppBarTheme(
          color: Colors.transparent,
          titleTextStyle: GoogleFonts.poppins()
              .copyWith(color: Colors.white, fontSize: 20)),
      textTheme: const TextTheme(
          bodyMedium: TextStyle(
        color: Colors.white,
      )));
}
