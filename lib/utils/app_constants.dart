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

  // UI Dimensions
  static const double titleFontSize = 48.0;
  static const double menuButtonWidth = 280.0;
  static const double menuButtonHeight = 60.0;
  static const double menuButtonSpacing = 25.0;
  static const double menuButtonRadius = 30.0;
  static const double actionButtonSize = 40.0;
  static const double actionButtonSpacing = 15.0;
  static const double volumeSliderWidth = 300.0;
  static const double uiPadding = 20.0;
  static const double uiElementSpacing = 8.0;

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
}
