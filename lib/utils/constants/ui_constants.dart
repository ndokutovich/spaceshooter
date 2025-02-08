import 'package:flutter/material.dart';

class UIConstants {
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
  static const String countdownText1 = '1';
  static const String countdownText2 = '2';
  static const String countdownText3 = '3';
  static const String countdownTextGo = 'GO!';
  static const String pauseButtonText = 'Pause';
  static const String pausedText = 'Paused';
  static const String resumeText = 'Resume';

  // UI Dimensions
  static const double titleFontSize = 48.0;
  static const double menuButtonWidth = 280.0;
  static const double menuButtonHeight = 60.0;
  static const double menuButtonSpacing = 25.0;
  static const double menuButtonRadius = 30.0;
  static const double actionButtonSize = 70.0;
  static const double actionButtonSpacing = 15.0;
  static const double novaCounterSize = 30.0;
  static const double novaCounterDisplaySize = 40.0;
  static const double menuButtonWidthRatio = 0.35;
  static const double menuButtonHeightRatio = 0.08;
  static const double menuButtonSpacingRatio = 0.02;
  static const double overlayOpacity = 0.54;
  static const double volumeSliderWidth = 300.0;
  static const double uiPadding = 20.0;
  static const double uiElementSpacing = 8.0;
  static const double uiPaddingMultiplier = 5.0;
  static const double countdownTextSize = 64.0;

  // High Scores UI
  static const double highScoresTitleSize = 28.0;
  static const double highScoresSubtitleSize = 24.0;
  static const double highScoresPadding = 20.0;
  static const double highScoresBorderRadius = 15.0;
  static const double highScoresBorderWidth = 2.0;
  static const double highScoresColumnSpacing = 40.0;
  static const double highScoresBackButtonSize = 40.0;
  static const double highScoresBackButtonFontSize = 24.0;

  // Durations
  static const Duration countdownDuration = Duration(seconds: 1);
  static const Duration gameLoopDuration = Duration(milliseconds: 16);
  static const Duration invulnerabilityDuration = Duration(seconds: 2);

  // Colors
  static const Color textColor = Colors.white;
  static const Color playerColor = Colors.blue;
  static const Color enemyColor = Colors.red;
  static const Color projectileColor = Colors.yellow;
  static const Color borderColor = Colors.grey;

  // Add missing constants
  static const int scoreIncrement = 100;

  // Text Sizes
  static const double subtitleFontSize = 24.0;
  static const double bodyFontSize = 16.0;
  static const double scoreTextSize = 20.0;
  static const double livesTextSize = 20.0;
}
