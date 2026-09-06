import 'package:flutter/material.dart';

/// All colors used across the TaskFlow app live here.
/// Keeping colors in one place makes it easy to re-theme the app later.
class AppColors {
  AppColors._(); // Prevents creating an instance of this class.

  // Primary brand color (purple) and its shades.
  static const Color primary = Color(0xFF6C5CE7);
  static const Color primaryDark = Color(0xFF5641E5);
  static const Color primaryLight = Color(0xFFEDE9FE);

  // Background & surface colors.
  static const Color background = Color(0xFFF7F7FC);
  static const Color surface = Colors.white;
  static const Color border = Color(0xFFE7E7F1);

  // Text colors.
  static const Color textPrimary = Color(0xFF1E1B2E);
  static const Color textSecondary = Color(0xFF6E6C82);
  static const Color textHint = Color(0xFFA5A3B8);

  // Status colors used for badges, priorities, progress etc.
  static const Color success = Color(0xFF22B07D);
  static const Color successBg = Color(0xFFE3F8EF);

  static const Color warning = Color(0xFFF5A623);
  static const Color warningBg = Color(0xFFFEF3E0);

  static const Color error = Color(0xFFEE5B5B);
  static const Color errorBg = Color(0xFFFDEAEA);

  static const Color info = Color(0xFF3B82F6);
  static const Color infoBg = Color(0xFFE7F0FE);

  // A soft shadow color used for cards.
  static const Color shadow = Color(0x1A6C5CE7);

  // A small palette used to give team member avatars different colors.
  static const List<Color> avatarColors = [
    Color(0xFF6C5CE7),
    Color(0xFF22B07D),
    Color(0xFFF5A623),
    Color(0xFF3B82F6),
    Color(0xFFEE5B5B),
    Color(0xFF00B8D9),
  ];
}
