class GameConstants {
  // Player settings
  static const double playerSize = 50.0;
  static const double playerStartHeightRatio = 0.8;
  static const double playerSpeed = 5.0;

  // Enemy settings
  static const int enemyCount = 10;
  static const double enemySize = 40.0;
  static const double enemySpawnHeightRatio = 0.3;
  static const double baseEnemySpeed = 2.0;
  static const double enemyLevelSpeedIncrease = 0.5;
  static const int enemyHealthIncreaseLevel = 2;

  // Asteroid settings
  static const int asteroidCount = 5;
  static const double asteroidSize = 50.0;
  static const double baseAsteroidSpeed = 1.0;
  static const double maxAsteroidSpeedVariation = 2.0;

  // Projectile settings
  static const double projectileWidth = 4.0;
  static const double projectileHeight = 20.0;
  static const double projectileOffset = 20.0;
  static const double projectileSpeed = 10.0;
  static const double novaAngleStep = 45.0;

  // Play area settings
  static const double playAreaPadding = 60.0;
  static const double borderWidth = 2.0;
  static const double collisionDistance = 30.0;

  // UI settings
  static const double uiPadding = 20.0;
  static const double uiElementSpacing = 8.0;
  static const double scoreTextSize = 20.0;
  static const double livesIconSize = 24.0;
  static const double livesTextSize = 20.0;

  // Game over screen settings
  static const double gameOverTextSize = 48.0;
  static const double scoreDisplayTextSize = 24.0;
  static const double gameOverSpacing = 20.0;
  static const double gameOverButtonPaddingH = 32.0;
  static const double gameOverButtonPaddingV = 16.0;

  // Initial game settings
  static const int initialLives = 3;
  static const int initialNovaBlasts = 3;
}
