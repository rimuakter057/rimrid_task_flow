import 'package:flutter/material.dart';

/// A small helper that makes it easy to size things relative to the
/// screen, instead of hardcoding pixel values everywhere.
///
/// Example:
///   ResponsiveSizer.width(context, 50)  -> 50% of screen width
///   ResponsiveSizer.height(context, 10) -> 10% of screen height
///   ResponsiveSizer.font(context, 16)   -> a font size that scales
///                                          slightly with screen width
class ResponsiveSizer {
  ResponsiveSizer._();

  // A "standard" mobile screen width used as the baseline for scaling.
  static const double _baseWidth = 375;

  static double width(BuildContext context, double percent) {
    final screenWidth = MediaQuery.of(context).size.width;
    return screenWidth * (percent / 100);
  }

  static double height(BuildContext context, double percent) {
    final screenHeight = MediaQuery.of(context).size.height;
    return screenHeight * (percent / 100);
  }

  /// Scales a font size up/down a little based on how wide the screen is,
  /// so text doesn't look too small on large phones or too big on small ones.
  static double font(BuildContext context, double size) {
    final screenWidth = MediaQuery.of(context).size.width;
    final scale = (screenWidth / _baseWidth).clamp(0.85, 1.15);
    return size * scale;
  }

  /// Returns spacing that scales gently with screen width. Useful for
  /// paddings/margins so small phones don't feel cramped.
  static double spacing(BuildContext context, double size) {
    final screenWidth = MediaQuery.of(context).size.width;
    final scale = (screenWidth / _baseWidth).clamp(0.9, 1.2);
    return size * scale;
  }

  /// True when the screen is wide enough to be considered a tablet.
  static bool isTablet(BuildContext context) {
    return MediaQuery.of(context).size.width >= 600;
  }
}
