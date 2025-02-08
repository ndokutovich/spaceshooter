import 'package:flutter/material.dart';

/// Constants for UI elements and text
class UIConstants {
  // App title
  static const String appTitle = 'Space Shooter';

  // Menu text
  static const String menuPlayText = 'Play';
  static const String menuOptionsText = 'Options';
  static const String menuHighScoresText = 'High Scores';
  static const String menuExitText = 'Exit';
  static const String backText = 'Back';
  static const String volumeText = 'Volume';

  // Splash screen text
  static const String splashTextPlatform = 'Flutter Game';
  static const String splashTextStudio = 'Space Studio';

  // Window settings
  static const double minWindowWidth = 1067;
  static const double minWindowHeight = 600;

  // UI element sizes
  static const double menuButtonWidth = 300;
  static const double menuButtonHeight = 60;
  static const double menuButtonRadius = 30;
  static const double uiPadding = 16;
  static const double uiElementSpacing = 8;

  // High scores screen
  static const double highScoresTitleSize = 32;
  static const double highScoresSubtitleSize = 24;
  static const double highScoresPadding = 16;
  static const double highScoresBorderRadius = 16;
  static const double highScoresBorderWidth = 2;
  static const double highScoresColumnSpacing = 32;

  // Menu spacing
  static const double menuButtonSpacing = 16;

  // Private constructor to prevent instantiation
  const UIConstants._();
}
