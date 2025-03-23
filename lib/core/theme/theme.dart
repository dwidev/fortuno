import 'package:flutter/material.dart';
import 'package:fortuno/core/core.dart';
import 'package:google_fonts/google_fonts.dart';

import 'colors.dart';

export 'colors.dart';
export 'default_size.dart';

ThemeData get lightTheme {
  final textTheme = GoogleFonts.poppinsTextTheme();

  return ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: darkLightColor,
    colorScheme: ColorScheme.fromSeed(
      seedColor: primaryColor,
      brightness: Brightness.light,
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: whiteColor,
      titleTextStyle: textTheme.titleLarge?.copyWith(color: primaryColor),
    ),
    textTheme: textTheme,
    iconTheme: IconThemeData(color: darkColor, size: 15),
    inputDecorationTheme: InputDecorationTheme(
      border: InputBorder.none,
      hintStyle: textTheme.bodySmall?.copyWith(fontSize: 13),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        padding: EdgeInsets.symmetric(horizontal: kDefaultFontSize),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(kDefaultRadius * 0.5),
        ),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: lightGrey6,
        elevation: 0,
        foregroundColor: darkColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(kDefaultRadius),
        ),
      ),
    ),
  );
}

const defaultGradient = LinearGradient(
  colors: [mutedLemonColor, sageGreenColor],
);

const defaultShadow = [
  BoxShadow(color: lightGrey7, blurRadius: 20, offset: Offset(0, 25)),
];
