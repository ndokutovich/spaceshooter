import 'package:flutter/material.dart';
import '../constants/game/ui_config.dart';

@Deprecated(
    'Use UIConfig from game/ui_config.dart instead. This class will be removed in a future update.')
class StyleConstants {
  // Colors
  @Deprecated('Use UIConfig.colors.primaryColor instead')
  static const Color primaryColor = Color(0xFF4A90E2); // Bright blue
  @Deprecated('Use UIConfig.colors.textColor instead')
  static const Color textColor = Colors.white;
  @Deprecated('Use UIConfig.colors.playerColor instead')
  static const Color playerColor = Color(0xFF4A90E2); // Bright blue
  @Deprecated('Use UIConfig.colors.enemyColor instead')
  static const Color enemyColor = Color(0xFFE24A4A); // Bright red
  @Deprecated('Use UIConfig.colors.projectileColor instead')
  static const Color projectileColor = Color(0xFFFFD700); // Gold
  @Deprecated('Use UIConfig.colors.asteroidColor instead')
  static const Color asteroidColor = Color(0xFF808080); // Gray
  @Deprecated('Use UIConfig.colors.borderColor instead')
  static const Color borderColor = Colors.white;
  @Deprecated('Use UIConfig.colors.backgroundColor instead')
  static const Color backgroundColor = Colors.black;
  @Deprecated('Use UIConfig.colors.overlayColor instead')
  static const Color overlayColor = Colors.black54;

  // Opacity Levels
  @Deprecated('Use UIConfig.opacity.high instead')
  static const double opacityHigh = 0.8;
  @Deprecated('Use UIConfig.opacity.medium instead')
  static const double opacityMedium = 0.6;
  @Deprecated('Use UIConfig.opacity.low instead')
  static const double opacityLow = 0.4;
  @Deprecated('Use UIConfig.opacity.veryLow instead')
  static const double opacityVeryLow = 0.3;
  @Deprecated('Use UIConfig.opacity.ultraLow instead')
  static const double opacityUltraLow = 0.1;

  // Logo Style
  @Deprecated('Use LogoConfig.widthMultiplier instead')
  static const double logoWidthMultiplier = 1.75;
  @Deprecated('Use LogoConfig.heightMultiplier instead')
  static const double logoHeightMultiplier = 0.5;
  @Deprecated('Use LogoConfig.letterSpacing instead')
  static const double logoLetterSpacing = 6.0;
  @Deprecated('Use LogoConfig.lineHeight instead')
  static const double logoLineHeight = 1.1;
  @Deprecated('Use LogoConfig.blurRadius instead')
  static const double logoBlurRadius = 10.0;
  @Deprecated('Use LogoConfig.outerBlurRadius instead')
  static const double logoOuterBlurRadius = 15.0;
  @Deprecated('Use LogoConfig.strokeWidth instead')
  static const double logoStrokeWidth = 1.5;
  @Deprecated('Use LogoConfig.energyLineWidth instead')
  static const double logoEnergyLineWidth = 2.0;
  @Deprecated('Use LogoConfig.baseOpacity instead')
  static const double logoBaseOpacity = 0.8;
  @Deprecated('Use LogoConfig.mediumOpacity instead')
  static const double logoMediumOpacity = 0.6;
  @Deprecated('Use LogoConfig.lowOpacity instead')
  static const double logoLowOpacity = 0.4;
  @Deprecated('Use LogoConfig.waveBaseHeight instead')
  static const double logoWaveBaseHeight = 0.2;
  @Deprecated('Use LogoConfig.waveAmplitude instead')
  static const double logoWaveAmplitude = 0.15;
  @Deprecated('Use LogoConfig.circuitLines instead')
  static const int logoCircuitLines = 12;
  @Deprecated('Use LogoConfig.energyLineSpacing instead')
  static const double logoEnergyLineSpacing = 8.0;
  @Deprecated('Use LogoConfig.energyLineLength instead')
  static const double logoEnergyLineLength = 0.2;

  // Text Styles
  @Deprecated('Use UIConfig.textStyles.title instead')
  static const double titleFontSize = 48.0;
  @Deprecated('Use UIConfig.textStyles.subtitle instead')
  static const double subtitleFontSize = 24.0;
  @Deprecated('Use UIConfig.textStyles.body instead')
  static const double bodyFontSize = 16.0;
  @Deprecated('Use UIConfig.textStyles.button instead')
  static const double buttonFontSize = 18.0;
}
