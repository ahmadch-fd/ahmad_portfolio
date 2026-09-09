import 'package:flutter/material.dart';

abstract final class AppColors {
  static const Color background = Color(0xFF151412);
  static const Color surface = Color(0xFF201F1D);
  static const Color foreground = Color(0xFFF7F4EF);
  static const Color muted = Color(0xFFAAA49A);
  static const Color primary = Color(0xFFFF7C6B);
  static const Color accent = Color(0xFFB72BE8);
  static const LinearGradient heroTextGradient = LinearGradient(
    colors: [Color(0xFFFF835C), Color(0xFFE35D9D), Color(0xFF9B3CFF)],
  );
  static const Color buttonForeground = Color(0xFF171614);
}
