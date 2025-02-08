import 'package:flutter/material.dart';

/// Constants for styling and theming
class StyleConstants {
  // Colors
  static const Color primaryColor = Color(0xFF4A90E2);
  static const Color backgroundColor = Color(0xFF1A1A1A);
  static const Color playerColor = Color(0xFF4A90E2);
  static const Color textColor = Colors.white;
  static const Color overlayColor = Color(0x80000000);

  // Font sizes
  static const double titleFontSize = 48;
  static const double subtitleFontSize = 32;
  static const double bodyFontSize = 16;

  // Logo settings
  static const double logoWidthMultiplier = 1.0;
  static const double logoHeightMultiplier = 0.5;
  static const double logoStrokeWidth = 2.0;
  static const double logoEnergyLineWidth = 1.5;
  static const double logoEnergyLineLength = 0.2;
  static const double logoEnergyLineSpacing = 10.0;
  static const double logoOuterBlurRadius = 10.0;
  static const double logoBlurRadius = 5.0;
  static const double logoLetterSpacing = 2.0;
  static const double logoLineHeight = 1.2;
  static const int logoCircuitLines = 6;
  static const double logoWaveBaseHeight = 0.4;
  static const double logoWaveAmplitude = 0.1;

  // Opacity values
  static const double opacityUltraLow = 0.1;
  static const double opacityVeryLow = 0.2;
  static const double opacityLow = 0.3;
  static const double opacityMedium = 0.5;
  static const double opacityHigh = 0.8;
  static const double logoBaseOpacity = 0.6;
  static const double logoMediumOpacity = 0.4;
  static const double logoLowOpacity = 0.2;

  // Private constructor to prevent instantiation
  const StyleConstants._();
}
