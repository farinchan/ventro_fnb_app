import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ventro_fnb_app/core/styles/typography/app_typography.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      scaffoldBackgroundColor: const Color(0xFFF3F3F3),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFFF0000),
          foregroundColor: const Color(0xFFFFFFFF),
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
          textStyle: AppTypography.titleMedium,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
        ),
      ),
      fontFamily: GoogleFonts.poppins().fontFamily,
      colorScheme: const ColorScheme.light(
        primary: Color(0xFFFF0000),
        onPrimary: Color(0xFFFFFFFF),
        background: Color(0xFFF3F3F3),
        onBackground: Color(0xFF000000),
        secondary: Color(0xFF00A859),
        tertiary: Color(0xFFFF0000),
      ),
      textTheme: _textTheme,
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      fontFamily: GoogleFonts.poppins().fontFamily,
      colorScheme: const ColorScheme.dark(
        primary: Color(0xFFFF0000),
        onPrimary: Color(0xFFFFFFFF),
        secondary: Color(0xFF00A859),
        tertiary: Color(0xFFFF0000),
      ),
      textTheme: _textTheme,
    );
  }

  static TextTheme get _textTheme {
    return TextTheme(
    displayLarge: AppTypography.displayLarge,
    displayMedium: AppTypography.displayMedium,
    displaySmall: AppTypography.displaySmall,
    headlineLarge: AppTypography.headlineLarge,
    headlineMedium: AppTypography.headlineMedium,
    headlineSmall: AppTypography.headlineSmall,
    titleLarge: AppTypography.titleLarge,
    titleMedium: AppTypography.titleMedium,
    titleSmall: AppTypography.titleSmall,
    bodyLarge: AppTypography.bodyLarge,
    bodyMedium: AppTypography.bodyMedium,
    bodySmall: AppTypography.bodySmall,
    labelLarge: AppTypography.labelLarge,
    labelMedium: AppTypography.labelMedium,
    labelSmall: AppTypography.labelSmall,
  );
  }
}