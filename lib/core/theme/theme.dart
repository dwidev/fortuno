import 'package:google_fonts/google_fonts.dart';

import '../core.dart';

export 'colors.dart';
export 'default_size.dart';

ThemeData get lightTheme {
  final textTheme = GoogleFonts.poppinsTextTheme().copyWith(
    displayLarge: GoogleFonts.poppins(
      fontSize: 32,
      fontWeight: FontWeight.bold,
    ),
    displayMedium: GoogleFonts.poppins(
      fontSize: 28,
      fontWeight: FontWeight.bold,
    ),
    displaySmall: GoogleFonts.poppins(
      fontSize: 24,
      fontWeight: FontWeight.bold,
    ),
    headlineMedium: GoogleFonts.poppins(
      fontSize: 20,
      fontWeight: FontWeight.w600,
    ),
    titleLarge: GoogleFonts.poppins(
      fontSize: 18 * 0.9,
      fontWeight: FontWeight.w600,
    ),
    bodyLarge: GoogleFonts.poppins(fontSize: 16 * 0.9),
    bodyMedium: GoogleFonts.poppins(fontSize: 14 * 0.9),
    bodySmall: GoogleFonts.poppins(fontSize: 12 * 0.9),
    labelLarge: GoogleFonts.poppins(
      fontSize: 14 * 0.9,
      fontWeight: FontWeight.w500,
    ),
    labelMedium: GoogleFonts.poppins(
      fontSize: 12 * 0.9,
      fontWeight: FontWeight.w500,
    ),
  );

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
          borderRadius: BorderRadius.circular(kDefaultRadius * 0.5),
        ),
      ),
    ),
  );
}

const defaultGradient = LinearGradient(colors: [primaryColor, secondaryColor]);

final defaultShadow = [
  BoxShadow(
    color: shadowColor.withAlpha((225 * 0.5).toInt()),
    blurRadius: 20,
    offset: Offset(0, 25),
  ),
];
