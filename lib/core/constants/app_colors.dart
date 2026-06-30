import 'package:flutter/material.dart';

/// AURA Brand Color Palette
class AppColors {
  AppColors._();

  // Primary
  static const Color primary = Color(0xFF2563EB);
  static const Color primaryLight = Color(0xFF3B82F6);
  static const Color primaryDark = Color(0xFF1D4ED8);
  static const Color primaryContainer = Color(0xFFDBEAFE);

  // Secondary
  static const Color secondary = Color(0xFF7C3AED);
  static const Color secondaryLight = Color(0xFF8B5CF6);
  static const Color secondaryDark = Color(0xFF6D28D9);
  static const Color secondaryContainer = Color(0xFFEDE9FE);

  // Accent
  static const Color accent = Color(0xFFF59E0B);
  static const Color accentLight = Color(0xFFFBBF24);
  static const Color accentDark = Color(0xFFD97706);
  static const Color accentContainer = Color(0xFFFEF3C7);

  // Backgrounds - Light
  static const Color backgroundLight = Color(0xFFFFFFFF);
  static const Color surfaceLight = Color(0xFFF8FAFC);
  static const Color cardLight = Color(0xFFFFFFFF);

  // Backgrounds - Dark
  static const Color backgroundDark = Color(0xFF0F172A);
  static const Color surfaceDark = Color(0xFF1E293B);
  static const Color cardDark = Color(0xFF1E293B);

  // Text - Light
  static const Color textPrimaryLight = Color(0xFF111827);
  static const Color textSecondaryLight = Color(0xFF6B7280);
  static const Color textHintLight = Color(0xFF9CA3AF);

  // Text - Dark
  static const Color textPrimaryDark = Color(0xFFF9FAFB);
  static const Color textSecondaryDark = Color(0xFF9CA3AF);
  static const Color textHintDark = Color(0xFF6B7280);

  // Status
  static const Color success = Color(0xFF22C55E);
  static const Color successLight = Color(0xFFDCFCE7);
  static const Color error = Color(0xFFEF4444);
  static const Color errorLight = Color(0xFFFEE2E2);
  static const Color warning = Color(0xFFF59E0B);
  static const Color warningLight = Color(0xFFFEF3C7);
  static const Color info = Color(0xFF3B82F6);
  static const Color infoLight = Color(0xFFDBEAFE);

  // Borders
  static const Color borderLight = Color(0xFFE5E7EB);
  static const Color borderDark = Color(0xFF374151);

  // Dividers
  static const Color dividerLight = Color(0xFFF3F4F6);
  static const Color dividerDark = Color(0xFF1F2937);

  // Subject Colors
  static const Color frenchColor = Color(0xFF2563EB);
  static const Color mathColor = Color(0xFF7C3AED);
  static const Color philosophyColor = Color(0xFF0891B2);
  static const Color histgeoColor = Color(0xFF059669);
  static const Color svtColor = Color(0xFF16A34A);
  static const Color physicsColor = Color(0xFFEA580C);
  static const Color englishColor = Color(0xFFDC2626);
  static const Color spanishColor = Color(0xFFCA8A04);
  static const Color germanColor = Color(0xFF7C2D12);
  static const Color economyColor = Color(0xFF0369A1);
  static const Color accountingColor = Color(0xFF4338CA);
  static const Color computerColor = Color(0xFF0F766E);

  // Gradient
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [primary, secondary],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient accentGradient = LinearGradient(
    colors: [accent, Color(0xFFEF4444)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient successGradient = LinearGradient(
    colors: [success, Color(0xFF16A34A)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // Shadows
  static List<BoxShadow> cardShadow = [
    BoxShadow(
      color: Colors.black.withOpacity(0.06),
      blurRadius: 16,
      offset: const Offset(0, 4),
      spreadRadius: 0,
    ),
  ];

  static List<BoxShadow> elevatedShadow = [
    BoxShadow(
      color: primary.withOpacity(0.15),
      blurRadius: 24,
      offset: const Offset(0, 8),
      spreadRadius: 0,
    ),
  ];
}
