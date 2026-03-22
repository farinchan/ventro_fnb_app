import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ventro_fnb_app/core/styles/typography/app_typography.dart';

class AppTheme {
  static ThemeData get lightTheme {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: const Color(0xFFE63946), // Premium Crimson Red
      primary: const Color(0xFFE63946),
      secondary: const Color(0xFFF4A261),
      tertiary: const Color(0xFF2A9D8F),
      surface: const Color(0xFFF8F9FA),
      brightness: Brightness.light,
    );

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      scaffoldBackgroundColor: colorScheme.surface,
      colorScheme: colorScheme,
      fontFamily: GoogleFonts.poppins().fontFamily,
      textTheme: _textTheme,
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: colorScheme.primary,
          foregroundColor: colorScheme.onPrimary,
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
          textStyle: AppTypography.titleMedium.copyWith(fontWeight: FontWeight.w600),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        ),
      ),
      cardTheme: CardThemeData(
        elevation: 4,
        shadowColor: Colors.black.withValues(alpha: 0.04),
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
      dividerTheme: DividerThemeData(
        color: colorScheme.outlineVariant.withValues(alpha: 0.3),
        space: 1,
      ),
    );
  }

  static ThemeData get darkTheme {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: const Color(0xFFE63946),
      primary: const Color(0xFFE63946),
      secondary: const Color(0xFFF4A261),
      tertiary: const Color(0xFF2A9D8F),
      brightness: Brightness.dark,
    );

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: colorScheme,
      fontFamily: GoogleFonts.poppins().fontFamily,
      scaffoldBackgroundColor: const Color(0xFF121212),
      textTheme: _textTheme,
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: colorScheme.primary,
          foregroundColor: colorScheme.onPrimary,
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
          textStyle: AppTypography.titleMedium.copyWith(fontWeight: FontWeight.w600),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        ),
      ),
      cardTheme: CardThemeData(
        elevation: 4,
        shadowColor: Colors.black.withValues(alpha: 0.3),
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
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