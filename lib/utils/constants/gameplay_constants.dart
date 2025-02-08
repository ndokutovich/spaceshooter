class GameplayConstants {
  // Asteroid settings
  static const int asteroidCount = 5;
  static const double asteroidSize = 50.0;
  static const double baseAsteroidSpeed = 1.0;
  static const double maxAsteroidSpeedVariation = 2.0;
  static const int baseAsteroidHealth = 3;
  static const int asteroidHealthIncreaseLevel = 2;

  // Play area settings
  static const double playAreaPadding = 60.0;
  static const double borderWidth = 2.0;
  static const double collisionDistance = 30.0;

  // Game mechanics
  static const int scorePerKill = 100;
  static const int targetFPS = 60;
  static const int scoreIncrement = 100;

  // Bonus settings
  static const double bonusSize = 30.0;
  static const double bonusRotationStep = 0.05;
  static const int bonusMultiplierValue = 2;
  static const int bonusGoldValue = 500;
  static const double bonusDropRate = 0.3;

  // Game over screen settings
  static const double gameOverSpacing = 20.0;
  static const double gameOverButtonPaddingH = 32.0;
  static const double gameOverButtonPaddingV = 16.0;
}
