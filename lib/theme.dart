import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static ThemeData lightTheme(BuildContext context) {
    return ThemeData(
      scaffoldBackgroundColor: Colors.white,
      textTheme: GoogleFonts.lexendDecaTextTheme(),
      visualDensity: VisualDensity.adaptivePlatformDensity,
    );
  }
}
