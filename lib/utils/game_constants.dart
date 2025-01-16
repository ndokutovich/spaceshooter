class GameConstants {
  // Game Area
  static const double playAreaPadding = 120.0;
  static const double playerStartHeightRatio = 0.8;
  static const double enemySpawnHeightRatio = 0.3;
  static const double enemyRespawnHeight = -50.0;

  // Game Objects
  static const int initialLives = 3;
  static const int initialNovaBlasts = 2;
  static const int enemyCount = 10;
  static const int asteroidCount = 5;
  static const int scorePerKill = 100;

  // Speeds
  static const double playerSpeed = 5.0;
  static const double projectileSpeed = 10.0;
  static const double baseEnemySpeed = 2.0;
  static const double baseAsteroidSpeed = 1.0;
  static const double maxAsteroidSpeedVariation = 2.0;

  // Dimensions
  static const double collisionDistance = 30.0;
  static const double playerSize = 50.0;
  static const double enemySize = 40.0;
  static const double asteroidSize = 50.0;
  static const double projectileWidth = 4.0;
  static const double projectileHeight = 20.0;
  static const double projectileOffset = 20.0;
  static const double borderWidth = 2.0;

  // Game Loop
  static const int targetFPS = 60;
  static const double novaAngleStep = 45.0;
  static const double enemyLevelSpeedIncrease = 0.5;
  static const int enemyHealthIncreaseLevel = 2;

  // UI
  static const double scoreTextSize = 20.0;
  static const double livesIconSize = 24.0;
  static const double livesTextSize = 20.0;
  static const double uiElementSpacing = 8.0;
  static const double uiPadding = 20.0;
  static const double gameOverTextSize = 48.0;
  static const double scoreDisplayTextSize = 24.0;
  static const double gameOverButtonPaddingH = 32.0;
  static const double gameOverButtonPaddingV = 16.0;
  static const double gameOverSpacing = 20.0;
}
