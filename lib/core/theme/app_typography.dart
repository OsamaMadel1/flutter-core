import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// 🔤 Typography System
/// تأكد من إضافة google_fonts في pubspec.yaml
abstract class AppTypography {
  // ─── Font Families ────────────────────────────────────────
  static String get displayFont => GoogleFonts.syne().fontFamily!;
  static String get bodyFont    => GoogleFonts.dmSans().fontFamily!;

  // ─── Light Text Theme ────────────────────────────────────
  static TextTheme lightTextTheme = TextTheme(
    // Display
    displayLarge: GoogleFonts.syne(
      fontSize: 57, fontWeight: FontWeight.w800, letterSpacing: -1.5,
      color: const Color(0xFF0F172A),
    ),
    displayMedium: GoogleFonts.syne(
      fontSize: 45, fontWeight: FontWeight.w700, letterSpacing: -1.0,
      color: const Color(0xFF0F172A),
    ),
    displaySmall: GoogleFonts.syne(
      fontSize: 36, fontWeight: FontWeight.w700, letterSpacing: -0.5,
      color: const Color(0xFF0F172A),
    ),

    // Headline
    headlineLarge: GoogleFonts.syne(
      fontSize: 32, fontWeight: FontWeight.w700,
      color: const Color(0xFF0F172A),
    ),
    headlineMedium: GoogleFonts.syne(
      fontSize: 28, fontWeight: FontWeight.w600,
      color: const Color(0xFF0F172A),
    ),
    headlineSmall: GoogleFonts.syne(
      fontSize: 24, fontWeight: FontWeight.w600,
      color: const Color(0xFF0F172A),
    ),

    // Title
    titleLarge: GoogleFonts.syne(
      fontSize: 22, fontWeight: FontWeight.w600,
      color: const Color(0xFF0F172A),
    ),
    titleMedium: GoogleFonts.dmSans(
      fontSize: 16, fontWeight: FontWeight.w500, letterSpacing: 0.15,
      color: const Color(0xFF0F172A),
    ),
    titleSmall: GoogleFonts.dmSans(
      fontSize: 14, fontWeight: FontWeight.w500, letterSpacing: 0.1,
      color: const Color(0xFF0F172A),
    ),

    // Body
    bodyLarge: GoogleFonts.dmSans(
      fontSize: 16, fontWeight: FontWeight.w400, letterSpacing: 0.5,
      color: const Color(0xFF334155),
    ),
    bodyMedium: GoogleFonts.dmSans(
      fontSize: 14, fontWeight: FontWeight.w400, letterSpacing: 0.25,
      color: const Color(0xFF334155),
    ),
    bodySmall: GoogleFonts.dmSans(
      fontSize: 12, fontWeight: FontWeight.w400, letterSpacing: 0.4,
      color: const Color(0xFF64748B),
    ),

    // Label
    labelLarge: GoogleFonts.dmSans(
      fontSize: 14, fontWeight: FontWeight.w500, letterSpacing: 0.1,
      color: const Color(0xFF0F172A),
    ),
    labelMedium: GoogleFonts.dmSans(
      fontSize: 12, fontWeight: FontWeight.w500, letterSpacing: 0.5,
      color: const Color(0xFF64748B),
    ),
    labelSmall: GoogleFonts.dmSans(
      fontSize: 11, fontWeight: FontWeight.w500, letterSpacing: 0.5,
      color: const Color(0xFF94A3B8),
    ),
  );

  // ─── Dark Text Theme ─────────────────────────────────────
  static TextTheme darkTextTheme = TextTheme(
    displayLarge: GoogleFonts.syne(
      fontSize: 57, fontWeight: FontWeight.w800, letterSpacing: -1.5,
      color: const Color(0xFFE8F0FE),
    ),
    displayMedium: GoogleFonts.syne(
      fontSize: 45, fontWeight: FontWeight.w700, letterSpacing: -1.0,
      color: const Color(0xFFE8F0FE),
    ),
    displaySmall: GoogleFonts.syne(
      fontSize: 36, fontWeight: FontWeight.w700, letterSpacing: -0.5,
      color: const Color(0xFFE8F0FE),
    ),
    headlineLarge: GoogleFonts.syne(
      fontSize: 32, fontWeight: FontWeight.w700,
      color: const Color(0xFFE8F0FE),
    ),
    headlineMedium: GoogleFonts.syne(
      fontSize: 28, fontWeight: FontWeight.w600,
      color: const Color(0xFFE8F0FE),
    ),
    headlineSmall: GoogleFonts.syne(
      fontSize: 24, fontWeight: FontWeight.w600,
      color: const Color(0xFFE8F0FE),
    ),
    titleLarge: GoogleFonts.syne(
      fontSize: 22, fontWeight: FontWeight.w600,
      color: const Color(0xFFE8F0FE),
    ),
    titleMedium: GoogleFonts.dmSans(
      fontSize: 16, fontWeight: FontWeight.w500, letterSpacing: 0.15,
      color: const Color(0xFFE8F0FE),
    ),
    titleSmall: GoogleFonts.dmSans(
      fontSize: 14, fontWeight: FontWeight.w500, letterSpacing: 0.1,
      color: const Color(0xFFE8F0FE),
    ),
    bodyLarge: GoogleFonts.dmSans(
      fontSize: 16, fontWeight: FontWeight.w400, letterSpacing: 0.5,
      color: const Color(0xFFA8BBD4),
    ),
    bodyMedium: GoogleFonts.dmSans(
      fontSize: 14, fontWeight: FontWeight.w400, letterSpacing: 0.25,
      color: const Color(0xFFA8BBD4),
    ),
    bodySmall: GoogleFonts.dmSans(
      fontSize: 12, fontWeight: FontWeight.w400, letterSpacing: 0.4,
      color: const Color(0xFF6888A8),
    ),
    labelLarge: GoogleFonts.dmSans(
      fontSize: 14, fontWeight: FontWeight.w500, letterSpacing: 0.1,
      color: const Color(0xFFE8F0FE),
    ),
    labelMedium: GoogleFonts.dmSans(
      fontSize: 12, fontWeight: FontWeight.w500, letterSpacing: 0.5,
      color: const Color(0xFF6888A8),
    ),
    labelSmall: GoogleFonts.dmSans(
      fontSize: 11, fontWeight: FontWeight.w500, letterSpacing: 0.5,
      color: const Color(0xFF3D5470),
    ),
  );
}
