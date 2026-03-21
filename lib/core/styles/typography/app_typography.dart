import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTypography {
  static const Color _defaultColor = Color(0xFF000000);

  static final TextStyle _base = GoogleFonts.poppins(color: _defaultColor, height: 1.3, letterSpacing: 0.1);

  static TextStyle _style({
    required double fontSize,
    required FontWeight fontWeight,
    double? height,
    double? letterSpacing,
  }) {
    return _base.copyWith(fontSize: fontSize, fontWeight: fontWeight, height: height, letterSpacing: letterSpacing);
  }

  static final TextStyle displayLarge = _style(
    fontSize: 57,
    fontWeight: FontWeight.w600,
    height: 1.12,
    letterSpacing: -0.25,
  );

  static final TextStyle displayMedium = _style(fontSize: 45, fontWeight: FontWeight.w600, height: 1.16);

  static final TextStyle displaySmall = _style(fontSize: 36, fontWeight: FontWeight.w600, height: 1.22);

  static final TextStyle headlineLarge = _style(fontSize: 32, fontWeight: FontWeight.w600, height: 1.24);

  static final TextStyle headlineMedium = _style(fontSize: 28, fontWeight: FontWeight.w600, height: 1.28);

  static final TextStyle headlineSmall = _style(fontSize: 24, fontWeight: FontWeight.w600, height: 1.32);

  static final TextStyle titleLarge = _style(fontSize: 22, fontWeight: FontWeight.w600, height: 1.28);

  static final TextStyle titleMedium = _style(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    height: 1.5,
    letterSpacing: 0.15,
  );

  static final TextStyle titleSmall = _style(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    height: 1.43,
    letterSpacing: 0.1,
  );

  static final TextStyle bodyLarge = _style(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    height: 1.5,
    letterSpacing: 0.15,
  );

  static final TextStyle bodyMedium = _style(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    height: 1.43,
    letterSpacing: 0.25,
  );

  static final TextStyle bodySmall = _style(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    height: 1.33,
    letterSpacing: 0.4,
  );

  static final TextStyle labelLarge = _style(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    height: 1.43,
    letterSpacing: 0.1,
  );

  static final TextStyle labelMedium = _style(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    height: 1.33,
    letterSpacing: 0.5,
  );

  static final TextStyle labelSmall = _style(
    fontSize: 11,
    fontWeight: FontWeight.w500,
    height: 1.45,
    letterSpacing: 0.5,
  );


}
