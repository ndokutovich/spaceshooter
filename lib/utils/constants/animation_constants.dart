/// Constants for animations and transitions
class AnimationConstants {
  // Splash screen animations
  static const Duration splashAnimationDuration = Duration(seconds: 2);
  static const Duration splashDelayDuration = Duration(seconds: 1);
  static const Duration menuTransitionDuration = Duration(milliseconds: 500);

  // Game animations
  static const Duration playerHitAnimationDuration =
      Duration(milliseconds: 200);
  static const Duration explosionAnimationDuration =
      Duration(milliseconds: 500);
  static const Duration powerUpAnimationDuration = Duration(milliseconds: 300);
  static const Duration gameOverAnimationDuration = Duration(seconds: 1);

  // UI animations
  static const Duration buttonPressAnimationDuration =
      Duration(milliseconds: 100);
  static const Duration scoreUpdateAnimationDuration =
      Duration(milliseconds: 300);
  static const Duration menuButtonHoverDuration = Duration(milliseconds: 150);

  // Private constructor to prevent instantiation
  const AnimationConstants._();
}
