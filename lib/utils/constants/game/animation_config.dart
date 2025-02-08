import 'base_config.dart';

/// Configuration for animation durations and values
class AnimationConfig extends BaseGameConfig
    with JsonSerializable, Validatable {
  // Splash screen animations
  final Duration splashAnimationDuration;
  final Duration splashDelayDuration;
  final Duration menuTransitionDuration;

  // Game loop animations
  final Duration gameLoopDuration;
  final Duration invulnerabilityDuration;

  // Countdown animations
  final Duration countdownDuration;
  final Duration countdownTotalDuration;

  // Animation values
  final double rotationStep;

  // Animation text
  final String countdownText3;
  final String countdownText2;
  final String countdownText1;
  final String countdownTextGo;

  const AnimationConfig({
    this.splashAnimationDuration = const Duration(seconds: 2),
    this.splashDelayDuration = const Duration(seconds: 1),
    this.menuTransitionDuration = const Duration(milliseconds: 500),
    this.gameLoopDuration = const Duration(milliseconds: 16), // ~60 FPS
    this.invulnerabilityDuration = const Duration(seconds: 2),
    this.countdownDuration = const Duration(seconds: 1),
    this.countdownTotalDuration = const Duration(seconds: 3),
    this.rotationStep = 0.05,
    this.countdownText3 = '3',
    this.countdownText2 = '2',
    this.countdownText1 = '1',
    this.countdownTextGo = 'GO!',
  });

  @override
  List<String> get validationErrors {
    final errors = <String>[];

    if (splashAnimationDuration.inMilliseconds <= 0) {
      errors.add('Splash animation duration must be positive');
    }
    if (splashDelayDuration.inMilliseconds < 0) {
      errors.add('Splash delay duration cannot be negative');
    }
    if (menuTransitionDuration.inMilliseconds <= 0) {
      errors.add('Menu transition duration must be positive');
    }
    if (gameLoopDuration.inMilliseconds <= 0) {
      errors.add('Game loop duration must be positive');
    }
    if (invulnerabilityDuration.inMilliseconds <= 0) {
      errors.add('Invulnerability duration must be positive');
    }
    if (countdownDuration.inMilliseconds <= 0) {
      errors.add('Countdown duration must be positive');
    }
    if (countdownTotalDuration.inMilliseconds <=
        countdownDuration.inMilliseconds) {
      errors.add(
          'Total countdown duration must be greater than single countdown duration');
    }
    if (rotationStep <= 0) {
      errors.add('Rotation step must be positive');
    }
    if (countdownText3.isEmpty ||
        countdownText2.isEmpty ||
        countdownText1.isEmpty ||
        countdownTextGo.isEmpty) {
      errors.add('Countdown texts cannot be empty');
    }

    return errors;
  }

  @override
  Map<String, dynamic> toJson() => {
        'splashAnimationDuration': splashAnimationDuration.inMilliseconds,
        'splashDelayDuration': splashDelayDuration.inMilliseconds,
        'menuTransitionDuration': menuTransitionDuration.inMilliseconds,
        'gameLoopDuration': gameLoopDuration.inMilliseconds,
        'invulnerabilityDuration': invulnerabilityDuration.inMilliseconds,
        'countdownDuration': countdownDuration.inMilliseconds,
        'countdownTotalDuration': countdownTotalDuration.inMilliseconds,
        'rotationStep': rotationStep,
        'countdownText3': countdownText3,
        'countdownText2': countdownText2,
        'countdownText1': countdownText1,
        'countdownTextGo': countdownTextGo,
      };

  factory AnimationConfig.fromJson(Map<String, dynamic> json) =>
      AnimationConfig(
        splashAnimationDuration:
            Duration(milliseconds: json['splashAnimationDuration'] as int),
        splashDelayDuration:
            Duration(milliseconds: json['splashDelayDuration'] as int),
        menuTransitionDuration:
            Duration(milliseconds: json['menuTransitionDuration'] as int),
        gameLoopDuration:
            Duration(milliseconds: json['gameLoopDuration'] as int),
        invulnerabilityDuration:
            Duration(milliseconds: json['invulnerabilityDuration'] as int),
        countdownDuration:
            Duration(milliseconds: json['countdownDuration'] as int),
        countdownTotalDuration:
            Duration(milliseconds: json['countdownTotalDuration'] as int),
        rotationStep: json['rotationStep'] as double,
        countdownText3: json['countdownText3'] as String,
        countdownText2: json['countdownText2'] as String,
        countdownText1: json['countdownText1'] as String,
        countdownTextGo: json['countdownTextGo'] as String,
      );

  @override
  AnimationConfig copyWith({
    Duration? splashAnimationDuration,
    Duration? splashDelayDuration,
    Duration? menuTransitionDuration,
    Duration? gameLoopDuration,
    Duration? invulnerabilityDuration,
    Duration? countdownDuration,
    Duration? countdownTotalDuration,
    double? rotationStep,
    String? countdownText3,
    String? countdownText2,
    String? countdownText1,
    String? countdownTextGo,
  }) {
    return AnimationConfig(
      splashAnimationDuration:
          splashAnimationDuration ?? this.splashAnimationDuration,
      splashDelayDuration: splashDelayDuration ?? this.splashDelayDuration,
      menuTransitionDuration:
          menuTransitionDuration ?? this.menuTransitionDuration,
      gameLoopDuration: gameLoopDuration ?? this.gameLoopDuration,
      invulnerabilityDuration:
          invulnerabilityDuration ?? this.invulnerabilityDuration,
      countdownDuration: countdownDuration ?? this.countdownDuration,
      countdownTotalDuration:
          countdownTotalDuration ?? this.countdownTotalDuration,
      rotationStep: rotationStep ?? this.rotationStep,
      countdownText3: countdownText3 ?? this.countdownText3,
      countdownText2: countdownText2 ?? this.countdownText2,
      countdownText1: countdownText1 ?? this.countdownText1,
      countdownTextGo: countdownTextGo ?? this.countdownTextGo,
    );
  }
}
