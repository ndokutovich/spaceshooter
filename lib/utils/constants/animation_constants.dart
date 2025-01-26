class AnimationConstants {
  // Animation Durations
  static const Duration splashAnimationDuration = Duration(seconds: 2);
  static const Duration splashDelayDuration = Duration(seconds: 1);
  static const Duration menuTransitionDuration = Duration(milliseconds: 500);
  static const Duration gameLoopDuration =
      Duration(milliseconds: 16); // ~60 FPS
  static const Duration invulnerabilityDuration = Duration(seconds: 2);
  static const Duration countdownDuration = Duration(seconds: 1);
  static const Duration countdownTotalDuration = Duration(seconds: 3);

  // Animation Values
  static const double minSpeedMultiplier = 0.5;
  static const double maxSpeedMultiplier = 2.0;
  static const double novaAngleStep = 45.0;
  static const double rotationStep = 0.05;

  // Animation Text
  static const String countdownText3 = '3';
  static const String countdownText2 = '2';
  static const String countdownText1 = '1';
  static const String countdownTextGo = 'GO!';
}
