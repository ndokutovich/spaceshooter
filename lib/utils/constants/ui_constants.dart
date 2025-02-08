import 'package:flutter/material.dart';
import '../constants/game/ui_config.dart';

@Deprecated(
    'Use UIConfig from game/ui_config.dart instead. This class will be removed in a future update.')
class UIConstants {
  // Window settings
  @Deprecated('Use GameConfig.appTitle instead')
  static const String appTitle = 'Space Shooter';
  @Deprecated('Use GameConfig.minWindowWidth instead')
  static const double minWindowWidth = 800;
  @Deprecated('Use GameConfig.minWindowHeight instead')
  static const double minWindowHeight = 600;

  // UI Text
  @Deprecated('Use UIConfig.textStyles instead')
  static const String splashTextPlatform = 'Flutter Platform';
  @Deprecated('Use UIConfig.textStyles instead')
  static const String splashTextStudio = 'Developer Studio';
  @Deprecated('Use UIConfig.textStyles instead')
  static const String menuPlayText = 'Play';
  @Deprecated('Use UIConfig.textStyles instead')
  static const String menuOptionsText = 'Options';
  @Deprecated('Use UIConfig.textStyles instead')
  static const String menuHighScoresText = 'High Scores';
  @Deprecated('Use UIConfig.textStyles instead')
  static const String menuExitText = 'Exit';
  @Deprecated('Use UIConfig.textStyles instead')
  static const String gameOverText = 'Game Over';
  @Deprecated('Use UIConfig.textStyles instead')
  static const String mainMenuText = 'Main Menu';
  @Deprecated('Use UIConfig.textStyles instead')
  static const String scoreText = 'Score: ';
  @Deprecated('Use UIConfig.textStyles instead')
  static const String levelText = 'Level: ';
  @Deprecated('Use UIConfig.textStyles instead')
  static const String volumeText = 'Game Volume';
  @Deprecated('Use UIConfig.textStyles instead')
  static const String backText = 'Back';
  @Deprecated('Use UIConfig.textStyles instead')
  static const String fireText = 'Fire';
  @Deprecated('Use UIConfig.textStyles instead')
  static const String novaText = 'Nova';
  @Deprecated('Use UIConfig.textStyles instead')
  static const String livesText = 'Lives: ';
  @Deprecated('Use UIConfig.textStyles instead')
  static const String countdownText1 = '1';
  @Deprecated('Use UIConfig.textStyles instead')
  static const String countdownText2 = '2';
  @Deprecated('Use UIConfig.textStyles instead')
  static const String countdownText3 = '3';
  @Deprecated('Use UIConfig.textStyles instead')
  static const String countdownTextGo = 'GO!';
  @Deprecated('Use UIConfig.textStyles instead')
  static const String pauseButtonText = 'Pause';
  @Deprecated('Use UIConfig.textStyles instead')
  static const String pausedText = 'Paused';
  @Deprecated('Use UIConfig.textStyles instead')
  static const String resumeText = 'Resume';

  // UI Dimensions
  @Deprecated('Use UIConfig.textStyles.title instead')
  static const double titleFontSize = 48.0;
  @Deprecated('Use UIConfig.textStyles.subtitle instead')
  static const double menuButtonWidth = 280.0;
  @Deprecated('Use UIConfig.menuButtonHeight instead')
  static const double menuButtonHeight = 60.0;
  @Deprecated('Use UIConfig.menuButtonSpacing instead')
  static const double menuButtonSpacing = 25.0;
  @Deprecated('Use UIConfig.menuButtonRadius instead')
  static const double menuButtonRadius = 30.0;
  @Deprecated('Use UIConfig.actionButtonSize instead')
  static const double actionButtonSize = 40.0;
  @Deprecated('Use UIConfig.actionButtonSpacing instead')
  static const double actionButtonSpacing = 15.0;
  @Deprecated('Use UIConfig.uiPadding instead')
  static const double uiPadding = 20.0;
  @Deprecated('Use UIConfig.uiElementSpacing instead')
  static const double uiElementSpacing = 8.0;
  @Deprecated('Use UIConfig.uiPaddingMultiplier instead')
  static const double uiPaddingMultiplier = 2.0;
  @Deprecated('Use UIConfig.textStyles.countdown instead')
  static const double countdownTextSize = 64.0;

  // High Scores UI
  @Deprecated('Use UIConfig.textStyles.title instead')
  static const double highScoresTitleSize = 28.0;
  @Deprecated('Use UIConfig.textStyles.subtitle instead')
  static const double highScoresSubtitleSize = 24.0;
  @Deprecated('Use UIConfig.uiPadding instead')
  static const double highScoresPadding = 20.0;
  @Deprecated('Use UIConfig.menuButtonRadius instead')
  static const double highScoresBorderRadius = 15.0;
  @Deprecated('Use UIConfig.borderWidth instead')
  static const double highScoresBorderWidth = 2.0;
  @Deprecated('Use UIConfig.uiElementSpacing instead')
  static const double highScoresColumnSpacing = 40.0;
  @Deprecated('Use UIConfig.actionButtonSize instead')
  static const double highScoresBackButtonSize = 40.0;
  @Deprecated('Use UIConfig.textStyles.button instead')
  static const double highScoresBackButtonFontSize = 24.0;

  // Durations
  static const Duration countdownDuration = Duration(seconds: 1);
  static const Duration gameLoopDuration = Duration(milliseconds: 16);
  static const Duration invulnerabilityDuration = Duration(seconds: 2);

  // Colors
  @Deprecated('Use UIConfig.colors.textColor instead')
  static const Color textColor = Colors.white;
  @Deprecated('Use UIConfig.colors.playerColor instead')
  static const Color playerColor = Colors.blue;
  @Deprecated('Use UIConfig.colors.enemyColor instead')
  static const Color enemyColor = Colors.red;
  @Deprecated('Use UIConfig.colors.projectileColor instead')
  static const Color projectileColor = Colors.yellow;
  @Deprecated('Use UIConfig.colors.borderColor instead')
  static const Color borderColor = Colors.grey;

  // Add missing constants
  @Deprecated('Use GameplayConfig.scorePerKill instead')
  static const int scoreIncrement = 100;
}
