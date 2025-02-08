import 'package:flutter/material.dart';
import 'base_config.dart';

/// Configuration for color scheme
class ColorSchemeConfig extends BaseGameConfig
    with JsonSerializable, Validatable {
  final Color primaryColor;
  final Color playerColor;
  final Color enemyColor;
  final Color projectileColor;
  final Color asteroidColor;
  final Color borderColor;
  final Color backgroundColor;
  final Color overlayColor;
  final Color textColor;

  const ColorSchemeConfig({
    this.primaryColor = const Color(0xFF4A90E2),
    this.playerColor = const Color(0xFF4A90E2),
    this.enemyColor = const Color(0xFFE24A4A),
    this.projectileColor = const Color(0xFFFFD700),
    this.asteroidColor = const Color(0xFF808080),
    this.borderColor = Colors.white,
    this.backgroundColor = Colors.black,
    this.overlayColor = Colors.black54,
    this.textColor = Colors.white,
  });

  @override
  List<String> get validationErrors => [];

  @override
  Map<String, dynamic> toJson() => {
        'primaryColor': primaryColor.value,
        'playerColor': playerColor.value,
        'enemyColor': enemyColor.value,
        'projectileColor': projectileColor.value,
        'asteroidColor': asteroidColor.value,
        'borderColor': borderColor.value,
        'backgroundColor': backgroundColor.value,
        'overlayColor': overlayColor.value,
        'textColor': textColor.value,
      };

  factory ColorSchemeConfig.fromJson(Map<String, dynamic> json) =>
      ColorSchemeConfig(
        primaryColor: Color(json['primaryColor'] as int),
        playerColor: Color(json['playerColor'] as int),
        enemyColor: Color(json['enemyColor'] as int),
        projectileColor: Color(json['projectileColor'] as int),
        asteroidColor: Color(json['asteroidColor'] as int),
        borderColor: Color(json['borderColor'] as int),
        backgroundColor: Color(json['backgroundColor'] as int),
        overlayColor: Color(json['overlayColor'] as int),
        textColor: Color(json['textColor'] as int),
      );

  @override
  ColorSchemeConfig copyWith({
    Color? primaryColor,
    Color? playerColor,
    Color? enemyColor,
    Color? projectileColor,
    Color? asteroidColor,
    Color? borderColor,
    Color? backgroundColor,
    Color? overlayColor,
    Color? textColor,
  }) {
    return ColorSchemeConfig(
      primaryColor: primaryColor ?? this.primaryColor,
      playerColor: playerColor ?? this.playerColor,
      enemyColor: enemyColor ?? this.enemyColor,
      projectileColor: projectileColor ?? this.projectileColor,
      asteroidColor: asteroidColor ?? this.asteroidColor,
      borderColor: borderColor ?? this.borderColor,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      overlayColor: overlayColor ?? this.overlayColor,
      textColor: textColor ?? this.textColor,
    );
  }
}

/// Configuration for opacity levels
class OpacityConfig extends BaseGameConfig with JsonSerializable, Validatable {
  final double high;
  final double medium;
  final double low;
  final double veryLow;
  final double ultraLow;

  const OpacityConfig({
    this.high = 0.8,
    this.medium = 0.6,
    this.low = 0.4,
    this.veryLow = 0.3,
    this.ultraLow = 0.1,
  });

  @override
  List<String> get validationErrors {
    final errors = <String>[];
    if (high < 0 || high > 1)
      errors.add('High opacity must be between 0 and 1');
    if (medium < 0 || medium > 1)
      errors.add('Medium opacity must be between 0 and 1');
    if (low < 0 || low > 1) errors.add('Low opacity must be between 0 and 1');
    if (veryLow < 0 || veryLow > 1)
      errors.add('Very low opacity must be between 0 and 1');
    if (ultraLow < 0 || ultraLow > 1)
      errors.add('Ultra low opacity must be between 0 and 1');
    return errors;
  }

  @override
  Map<String, dynamic> toJson() => {
        'high': high,
        'medium': medium,
        'low': low,
        'veryLow': veryLow,
        'ultraLow': ultraLow,
      };

  factory OpacityConfig.fromJson(Map<String, dynamic> json) => OpacityConfig(
        high: json['high'] as double,
        medium: json['medium'] as double,
        low: json['low'] as double,
        veryLow: json['veryLow'] as double,
        ultraLow: json['ultraLow'] as double,
      );

  @override
  OpacityConfig copyWith({
    double? high,
    double? medium,
    double? low,
    double? veryLow,
    double? ultraLow,
  }) {
    return OpacityConfig(
      high: high ?? this.high,
      medium: medium ?? this.medium,
      low: low ?? this.low,
      veryLow: veryLow ?? this.veryLow,
      ultraLow: ultraLow ?? this.ultraLow,
    );
  }
}

/// Configuration for text styles and sizes
class TextStyleConfig extends BaseGameConfig
    with JsonSerializable, Validatable {
  final double title;
  final double subtitle;
  final double body;
  final double button;
  final double score;
  final double lives;
  final double countdown;
  final double gameOver;

  const TextStyleConfig({
    this.title = 48.0,
    this.subtitle = 24.0,
    this.body = 16.0,
    this.button = 18.0,
    this.score = 20.0,
    this.lives = 20.0,
    this.countdown = 64.0,
    this.gameOver = 48.0,
  });

  @override
  List<String> get validationErrors {
    final errors = <String>[];
    if (title <= 0) errors.add('Title font size must be positive');
    if (subtitle <= 0) errors.add('Subtitle font size must be positive');
    if (body <= 0) errors.add('Body font size must be positive');
    if (button <= 0) errors.add('Button font size must be positive');
    if (score <= 0) errors.add('Score font size must be positive');
    if (lives <= 0) errors.add('Lives font size must be positive');
    if (countdown <= 0) errors.add('Countdown font size must be positive');
    if (gameOver <= 0) errors.add('Game over font size must be positive');
    return errors;
  }

  @override
  Map<String, dynamic> toJson() => {
        'title': title,
        'subtitle': subtitle,
        'body': body,
        'button': button,
        'score': score,
        'lives': lives,
        'countdown': countdown,
        'gameOver': gameOver,
      };

  factory TextStyleConfig.fromJson(Map<String, dynamic> json) =>
      TextStyleConfig(
        title: json['title'] as double,
        subtitle: json['subtitle'] as double,
        body: json['body'] as double,
        button: json['button'] as double,
        score: json['score'] as double,
        lives: json['lives'] as double,
        countdown: json['countdown'] as double,
        gameOver: json['gameOver'] as double,
      );

  @override
  TextStyleConfig copyWith({
    double? title,
    double? subtitle,
    double? body,
    double? button,
    double? score,
    double? lives,
    double? countdown,
    double? gameOver,
  }) {
    return TextStyleConfig(
      title: title ?? this.title,
      subtitle: subtitle ?? this.subtitle,
      body: body ?? this.body,
      button: button ?? this.button,
      score: score ?? this.score,
      lives: lives ?? this.lives,
      countdown: countdown ?? this.countdown,
      gameOver: gameOver ?? this.gameOver,
    );
  }
}

/// Main UI configuration class
class UIConfig extends BaseGameConfig with JsonSerializable, Validatable {
  final ColorSchemeConfig colors;
  final OpacityConfig opacity;
  final TextStyleConfig textStyles;
  final double uiPadding;
  final double uiElementSpacing;
  final double menuButtonWidth;
  final double menuButtonHeight;
  final double menuButtonSpacing;
  final double menuButtonRadius;
  final double actionButtonSize;
  final double actionButtonSpacing;

  // Countdown text
  final String countdownText1;
  final String countdownText2;
  final String countdownText3;
  final String countdownTextGo;

  const UIConfig({
    this.colors = const ColorSchemeConfig(),
    this.opacity = const OpacityConfig(),
    this.textStyles = const TextStyleConfig(),
    this.uiPadding = 20.0,
    this.uiElementSpacing = 8.0,
    this.menuButtonWidth = 280.0,
    this.menuButtonHeight = 60.0,
    this.menuButtonSpacing = 25.0,
    this.menuButtonRadius = 30.0,
    this.actionButtonSize = 40.0,
    this.actionButtonSpacing = 15.0,
    this.countdownText1 = '1',
    this.countdownText2 = '2',
    this.countdownText3 = '3',
    this.countdownTextGo = 'GO!',
  });

  @override
  List<String> get validationErrors {
    final errors = <String>[];
    if (uiPadding < 0) errors.add('UI padding must be non-negative');
    if (uiElementSpacing < 0)
      errors.add('UI element spacing must be non-negative');
    if (menuButtonWidth <= 0) errors.add('Menu button width must be positive');
    if (menuButtonHeight <= 0)
      errors.add('Menu button height must be positive');
    if (menuButtonSpacing < 0)
      errors.add('Menu button spacing must be non-negative');
    if (menuButtonRadius < 0)
      errors.add('Menu button radius must be non-negative');
    if (actionButtonSize <= 0)
      errors.add('Action button size must be positive');
    if (actionButtonSpacing < 0)
      errors.add('Action button spacing must be non-negative');

    if (!colors.validate()) {
      errors.addAll(colors.validationErrors.map((e) => 'Colors: $e'));
    }
    if (!opacity.validate()) {
      errors.addAll(opacity.validationErrors.map((e) => 'Opacity: $e'));
    }
    if (!textStyles.validate()) {
      errors.addAll(textStyles.validationErrors.map((e) => 'Text Styles: $e'));
    }
    return errors;
  }

  @override
  Map<String, dynamic> toJson() => {
        'colors': colors.toJson(),
        'opacity': opacity.toJson(),
        'textStyles': textStyles.toJson(),
        'uiPadding': uiPadding,
        'uiElementSpacing': uiElementSpacing,
        'menuButtonWidth': menuButtonWidth,
        'menuButtonHeight': menuButtonHeight,
        'menuButtonSpacing': menuButtonSpacing,
        'menuButtonRadius': menuButtonRadius,
        'actionButtonSize': actionButtonSize,
        'actionButtonSpacing': actionButtonSpacing,
        'countdownText1': countdownText1,
        'countdownText2': countdownText2,
        'countdownText3': countdownText3,
        'countdownTextGo': countdownTextGo,
      };

  factory UIConfig.fromJson(Map<String, dynamic> json) => UIConfig(
        colors:
            ColorSchemeConfig.fromJson(json['colors'] as Map<String, dynamic>),
        opacity:
            OpacityConfig.fromJson(json['opacity'] as Map<String, dynamic>),
        textStyles: TextStyleConfig.fromJson(
            json['textStyles'] as Map<String, dynamic>),
        uiPadding: json['uiPadding'] as double,
        uiElementSpacing: json['uiElementSpacing'] as double,
        menuButtonWidth: json['menuButtonWidth'] as double,
        menuButtonHeight: json['menuButtonHeight'] as double,
        menuButtonSpacing: json['menuButtonSpacing'] as double,
        menuButtonRadius: json['menuButtonRadius'] as double,
        actionButtonSize: json['actionButtonSize'] as double,
        actionButtonSpacing: json['actionButtonSpacing'] as double,
        countdownText1: json['countdownText1'] as String,
        countdownText2: json['countdownText2'] as String,
        countdownText3: json['countdownText3'] as String,
        countdownTextGo: json['countdownTextGo'] as String,
      );

  @override
  UIConfig copyWith({
    ColorSchemeConfig? colors,
    OpacityConfig? opacity,
    TextStyleConfig? textStyles,
    double? uiPadding,
    double? uiElementSpacing,
    double? menuButtonWidth,
    double? menuButtonHeight,
    double? menuButtonSpacing,
    double? menuButtonRadius,
    double? actionButtonSize,
    double? actionButtonSpacing,
    String? countdownText1,
    String? countdownText2,
    String? countdownText3,
    String? countdownTextGo,
  }) {
    return UIConfig(
      colors: colors ?? this.colors,
      opacity: opacity ?? this.opacity,
      textStyles: textStyles ?? this.textStyles,
      uiPadding: uiPadding ?? this.uiPadding,
      uiElementSpacing: uiElementSpacing ?? this.uiElementSpacing,
      menuButtonWidth: menuButtonWidth ?? this.menuButtonWidth,
      menuButtonHeight: menuButtonHeight ?? this.menuButtonHeight,
      menuButtonSpacing: menuButtonSpacing ?? this.menuButtonSpacing,
      menuButtonRadius: menuButtonRadius ?? this.menuButtonRadius,
      actionButtonSize: actionButtonSize ?? this.actionButtonSize,
      actionButtonSpacing: actionButtonSpacing ?? this.actionButtonSpacing,
      countdownText1: countdownText1 ?? this.countdownText1,
      countdownText2: countdownText2 ?? this.countdownText2,
      countdownText3: countdownText3 ?? this.countdownText3,
      countdownTextGo: countdownTextGo ?? this.countdownTextGo,
    );
  }
}
