import 'package:flutter/services.dart';

class OptionsConstants {
  // Tab names
  static const String controlsTabText = 'Controls';
  static const String miscTabText = 'Misc';

  // Control categories
  static const String movementControlsText = 'Movement';
  static const String actionControlsText = 'Actions';
  static const String systemControlsText = 'System';

  // Control labels
  static const String moveUpText = 'Move Up';
  static const String moveDownText = 'Move Down';
  static const String moveLeftText = 'Move Left';
  static const String moveRightText = 'Move Right';
  static const String fireText = 'Fire';
  static const String novaText = 'Nova Blast';
  static const String pauseText = 'Pause';

  // Default key bindings
  static const defaultKeyBindings = {
    'moveUp': [LogicalKeyboardKey.keyW, LogicalKeyboardKey.arrowUp],
    'moveDown': [LogicalKeyboardKey.keyS, LogicalKeyboardKey.arrowDown],
    'moveLeft': [LogicalKeyboardKey.keyA, LogicalKeyboardKey.arrowLeft],
    'moveRight': [LogicalKeyboardKey.keyD, LogicalKeyboardKey.arrowRight],
    'fire': [LogicalKeyboardKey.keyF],
    'nova': [LogicalKeyboardKey.space],
    'pause': [LogicalKeyboardKey.escape],
  };

  // UI Constants
  static const double tabHeight = 40.0;
  static const double controlGroupSpacing = 16.0;
  static const double controlItemSpacing = 12.0;
  static const double bindingButtonWidth = 280.0;
  static const double bindingButtonHeight = 36.0;
  static const double bindingButtonSpacing = 6.0;
  static const double categoryTitleSize = 18.0;
  static const double bindingTextSize = 14.0;
  static const double tabIndicatorWeight = 2.0;
  static const double tabIndicatorPadding = 8.0;
  static const double actionLabelWidth = 120.0;
  static const double keyBindWidth = 140.0;
}
