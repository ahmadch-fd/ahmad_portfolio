import 'package:flutter/material.dart';

abstract final class AppColors {
  // ── Backgrounds ──────────────────────────────────────────────────────────
  static const Color background = Color(0xFF060A18);
  static const Color surface = Color(0xFF0C1228);
  static const Color surfaceElevated = Color(0xFF111827);
  static const Color surfaceCard = Color(0xFF0E1525);
  static const Color glassOverlay = Color(0x1A6B9FC8);

  // ── Text ─────────────────────────────────────────────────────────────────
  static const Color foreground = Color(0xFFF0F4FF);
  static const Color muted = Color(0xFF7B8DB0);
  static const Color subtle = Color(0xFF4B5A78);

  // ── Accents ───────────────────────────────────────────────────────────────
  static const Color primary = Color(0xFFFF6B6B); // coral red
  static const Color accent = Color(0xFF8B5CF6); // violet
  static const Color accentCyan = Color(0xFF06B6D4); // cyan
  static const Color accentGreen = Color(0xFF10B981); // emerald
  static const Color accentAmber = Color(0xFFF59E0B); // amber

  // ── Borders ───────────────────────────────────────────────────────────────
  static const Color glassBorder = Color(0xFF1B2B4A);
  static const Color cardBorder = Color(0xFF162035);

  // ── Gradients ─────────────────────────────────────────────────────────────
  static const LinearGradient heroTextGradient = LinearGradient(
    colors: [Color(0xFFFF835C), Color(0xFFE35D9D), Color(0xFF8B5CF6)],
    stops: [0.0, 0.5, 1.0],
  );

  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFFFF6B6B), Color(0xFF8B5CF6)],
  );

  static const LinearGradient cyanVioletGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF06B6D4), Color(0xFF8B5CF6)],
  );

  static const LinearGradient backgroundGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Color(0xFF060A18), Color(0xFF08101F)],
  );

  // ── Misc ──────────────────────────────────────────────────────────────────
  static const Color buttonForeground = Color(0xFF0A0F1E);
  static const Color availableGreen = Color(0xFF00D68F);
}
