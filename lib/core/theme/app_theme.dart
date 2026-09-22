import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Tema visual do app
class AppTheme {
  const AppTheme._();


  static const Color neonGreen = Color(0xFF00E6A8);
  static const Color neonAmber = Color(0xFFFFC145);
  static const Color neonBlue = Color(0xFF3AD4FF);
  static const Color neonRed = Color(0xFFFF5C7A);
  static const Color neonPurple = Color(0xFF8B6CFF);

  static const Color statusConnected = neonGreen;
  static const Color statusConnecting = neonAmber;
  static const Color statusDisconnected = Color(0xFF8D89A8);
  static const Color statusError = neonRed;

  static const Color slotUnknown = Color(0xFF8880B0);
  static const Color slotAvailable = neonGreen;
  static const Color slotOccupied = neonAmber;
  static const Color slotSelected = neonBlue;

  static const Color background = Color(0xFF15111F);
  static const Color surface = Color(0xFF221C34);
  static const Color surfaceHigh = Color(0xFF2B2440);

  static ThemeData arcade() {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: neonPurple,
      brightness: Brightness.dark,
      surface: surface,
      error: neonRed,
    );

    final base = ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: background,
    );

    final textTheme = GoogleFonts.fredokaTextTheme(base.textTheme).apply(
      bodyColor: Colors.white,
      displayColor: Colors.white,
    );

    return base.copyWith(
      textTheme: textTheme,
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: false,
        titleTextStyle: textTheme.titleLarge?.copyWith(
          fontWeight: FontWeight.w700,
          letterSpacing: 0.3,
        ),
      ),
      cardTheme: CardThemeData(
        color: surface,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          padding: const EdgeInsets.symmetric(vertical: 18),
          textStyle: textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w700,
            letterSpacing: 0.4,
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: neonBlue,
          textStyle: textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w700),
        ),
      ),
      dividerColor: Colors.white12,
    );
  }
}
