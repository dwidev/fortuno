import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'colors.dart';

export 'colors.dart';
export 'default_size.dart';

ThemeData get lightTheme {
  final textTheme = GoogleFonts.poppinsTextTheme();
  return ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: softyellowColor,
      brightness: Brightness.light,
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: softyellowColor,
      titleTextStyle: GoogleFonts.poppinsTextTheme().titleLarge?.copyWith(
        color: whiteColor,
      ),
    ),
    textTheme: textTheme,
    iconTheme: const IconThemeData(color: blackColor, size: 15),
    inputDecorationTheme: InputDecorationTheme(
      border: InputBorder.none,
      hintStyle: textTheme.bodySmall?.copyWith(fontSize: 13),
    ),
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(padding: WidgetStatePropertyAll(EdgeInsets.zero)),
    ),
  );
}
