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
  static const String menuExitText = 'Exit';
  static const String gameOverText = 'Game Over';
  static const String mainMenuText = 'Main Menu';
  static const String scoreText = 'Score: ';
  static const String levelText = 'Level: ';
  static const String volumeText = 'Game Volume';
  static const String backText = 'Back';
  static const String fireText = 'Fire';
  static const String novaText = 'Nova';

  // UI Dimensions
  static const double titleFontSize = 48.0;
  static const double menuButtonWidth = 200.0;
  static const double menuButtonHeight = 50.0;
  static const double menuButtonSpacing = 20.0;
  static const double menuButtonRadius = 25.0;
  static const double actionButtonSize = 40.0;
  static const double actionButtonSpacing = 15.0;
  static const double volumeSliderWidth = 300.0;
  static const double uiPadding = 20.0;

  // Animation Durations
  static const splashAnimationDuration = Duration(seconds: 2);
  static const splashDelayDuration = Duration(seconds: 1);
  static const menuTransitionDuration = Duration(milliseconds: 500);
  static const gameLoopDuration = Duration(milliseconds: 16); // ~60 FPS
  static const invulnerabilityDuration = Duration(seconds: 2);

  // Colors
  static const primaryColor = Colors.deepPurple;
  static const textColor = Colors.white;
  static const playerColor = Colors.blue;
  static const enemyColor = Colors.red;
  static const projectileColor = Colors.yellow;
  static const asteroidColor = Colors.grey;
  static const borderColor = Colors.white;
}
