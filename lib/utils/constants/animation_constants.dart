import '../constants/game/animation_config.dart';

@Deprecated(
    'Use AnimationConfig from game/animation_config.dart instead. This class will be removed in a future update.')
class AnimationConstants {
  // Animation Durations
  @Deprecated('Use AnimationConfig.splashAnimationDuration instead')
  static const Duration splashAnimationDuration = Duration(seconds: 2);
  @Deprecated('Use AnimationConfig.splashDelayDuration instead')
  static const Duration splashDelayDuration = Duration(seconds: 1);
  @Deprecated('Use AnimationConfig.menuTransitionDuration instead')
  static const Duration menuTransitionDuration = Duration(milliseconds: 500);
  @Deprecated('Use AnimationConfig.gameLoopDuration instead')
  static const Duration gameLoopDuration =
      Duration(milliseconds: 16); // ~60 FPS
  @Deprecated('Use AnimationConfig.invulnerabilityDuration instead')
  static const Duration invulnerabilityDuration = Duration(seconds: 2);
  @Deprecated('Use AnimationConfig.countdownDuration instead')
  static const Duration countdownDuration = Duration(seconds: 1);
  @Deprecated('Use AnimationConfig.countdownTotalDuration instead')
  static const Duration countdownTotalDuration = Duration(seconds: 3);

  // Animation Values
  @Deprecated('Use AnimationConfig.rotationStep instead')
  static const double rotationStep = 0.05;

  // Animation Text
  @Deprecated('Use AnimationConfig.countdownText3 instead')
  static const String countdownText3 = '3';
  @Deprecated('Use AnimationConfig.countdownText2 instead')
  static const String countdownText2 = '2';
  @Deprecated('Use AnimationConfig.countdownText1 instead')
  static const String countdownText1 = '1';
  @Deprecated('Use AnimationConfig.countdownTextGo instead')
  static const String countdownTextGo = 'GO!';
}
