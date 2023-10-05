import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData myTheme() {
  return ThemeData(
    textTheme: GoogleFonts.poppinsTextTheme(
      Typography.blackCupertino,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFFede0d4),
      elevation: 0,
      titleTextStyle: TextStyle(color: Colors.black),
      iconTheme: IconThemeData(color: Colors.black),
    ),
  );
}
