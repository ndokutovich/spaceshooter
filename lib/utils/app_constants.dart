import 'package:flutter/material.dart';

class AppConstants {
  // Window settings
  static const String appTitle = 'Space Shooter';
  static const double minWindowWidth = 800;
  static const double minWindowHeight = 600;

  // UI Text
  static const String splashTextPlatform = 'Flutter Platform';
  static const String splashTextStudio = 'Developer Studio';
  static const String menuPlayText = 'Play';
  static const String menuOptionsText = 'Options';
  static const String menuHighScoresText = 'High Scores';
  static const String menuExitText = 'Exit';
  static const String gameOverText = 'Game Over';
  static const String mainMenuText = 'Main Menu';
  static const String scoreText = 'Score: ';
  static const String levelText = 'Level: ';
  static const String volumeText = 'Game Volume';
  static const String backText = 'Back';
  static const String fireText = 'Fire';
  static const String novaText = 'Nova';
  static const String livesText = 'Lives: ';
  static const String pausedText = 'PAUSED';
  static const String resumeText = 'Resume';
  static const String pauseButtonText =
      '❚❚'; // Double vertical bar pause symbol
  static const String countdownText3 = '3';
  static const String countdownText2 = '2';
  static const String countdownText1 = '1';
  static const String countdownTextGo = 'GO!';

  // UI Dimensions
  static const double titleFontSize = 48.0;
  static const double menuButtonWidth = 280.0;
  static const double menuButtonHeight = 50.0;
  static const double menuButtonSpacing = 25.0;
  static const double menuButtonRadius = 30.0;
  static const double actionButtonSize = 40.0;
  static const double actionButtonSpacing = 15.0;
  static const double volumeSliderWidth = 300.0;
  static const double uiPadding = 20.0;
  static const double uiElementSpacing = 8.0;
  static const double countdownTextSize = 72.0;
  static const Duration countdownDuration = Duration(seconds: 1);
  static const Duration countdownTotalDuration = Duration(seconds: 3);

  // Animation Durations
  static const splashAnimationDuration = Duration(seconds: 2);
  static const splashDelayDuration = Duration(seconds: 1);
  static const menuTransitionDuration = Duration(milliseconds: 500);
  static const gameLoopDuration = Duration(milliseconds: 16); // ~60 FPS
  static const invulnerabilityDuration = Duration(seconds: 2);

  // Colors
  static const primaryColor = Color(0xFF4A90E2); // Bright blue
  static const textColor = Colors.white;
  static const playerColor = Color(0xFF4A90E2); // Bright blue
  static const enemyColor = Color(0xFFE24A4A); // Bright red
  static const projectileColor = Color(0xFFFFD700); // Gold
  static const asteroidColor = Color(0xFF808080); // Gray
  static const borderColor = Colors.white;
  static const backgroundColor = Colors.black;
  static const overlayColor = Colors.black54;

  // Logo Constants
  static const double logoWidthMultiplier = 1.75;
  static const double logoHeightMultiplier = 0.5;
  static const double logoLetterSpacing = 6.0;
  static const double logoLineHeight = 1.1;
  static const double logoBlurRadius = 10.0;
  static const double logoOuterBlurRadius = 15.0;
  static const double logoStrokeWidth = 1.5;
  static const double logoEnergyLineWidth = 2.0;
  static const double logoBaseOpacity = 0.8;
  static const double logoMediumOpacity = 0.6;
  static const double logoLowOpacity = 0.4;
  static const double logoWaveBaseHeight = 0.2;
  static const double logoWaveAmplitude = 0.15;
  static const int logoCircuitLines = 12;
  static const double logoEnergyLineSpacing = 8.0;
  static const double logoEnergyLineLength = 0.2; // Multiplier of width

  // High Scores Constants
  static const double highScoresTitleSize = 28.0;
  static const double highScoresSubtitleSize = 24.0;
  static const double highScoresPadding = 20.0;
  static const double highScoresBorderRadius = 15.0;
  static const double highScoresBorderWidth = 2.0;
  static const double highScoresColumnSpacing = 40.0;
  static const double highScoresBackButtonSize = 40.0;
  static const double highScoresBackButtonFontSize = 24.0;

  // Additional UI Constants
  static const int scoreIncrement = 100;
  static const double uiPaddingMultiplier = 5.0;
  static const double opacityHigh = 0.8;
  static const double opacityMedium = 0.6;
  static const double opacityLow = 0.4;
  static const double opacityVeryLow = 0.3;
  static const double opacityUltraLow = 0.1;

  static const double playerSize = 40.0;
}
