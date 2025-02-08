import '../constants/game/config.dart';

@Deprecated(
    'Use GameplayConfig from game/config.dart instead. This class will be removed in a future update.')
class GameplayConstants {
  // Player settings
  static const double playerSize = 50.0;
  static const double playerStartHeightRatio = 0.8;
  static const double playerSpeed = 5.0;
  static const int initialLives = 3;

  // Enemy settings
  static const int enemyCount = 10;
  static const double enemySize = 40.0;
  static const double enemySpawnHeightRatio = 0.3;
  static const double baseEnemySpeed = 2.0;
  static const double enemyLevelSpeedIncrease = 0.5;
  static const int enemyHealthIncreaseLevel = 2;
  static const double enemyRespawnHeight = -50.0;

  // Asteroid settings
  @Deprecated('Use GameplayConfig.asteroids.count instead')
  static const int asteroidCount = 6;
  @Deprecated('Use GameplayConfig.asteroids.size instead')
  static const double asteroidSize = 50.0;
  @Deprecated('Use GameplayConfig.asteroids.baseSpeed instead')
  static const double asteroidBaseSpeed = 1.0;
  @Deprecated('Use GameplayConfig.asteroids.maxSpeedVariation instead')
  static const double asteroidMaxSpeedVariation = 1.0;
  @Deprecated('Use GameplayConfig.asteroids.baseHealth instead')
  static const int asteroidBaseHealth = 3;
  @Deprecated('Use GameplayConfig.asteroids.healthIncreaseLevel instead')
  static const int asteroidHealthIncreaseLevel = 2;

  // Projectile settings
  static const double projectileWidth = 4.0;
  static const double projectileHeight = 20.0;
  static const double projectileOffset = 20.0;
  static const double projectileSpeed = 10.0;
  static const int initialNovaBlasts = 3;

  // Play area settings
  @Deprecated('Use GameplayConfig.playAreaPadding instead')
  static const double playAreaPadding = 100.0;
  @Deprecated('Use GameplayConfig.borderWidth instead')
  static const double borderWidth = 2.0;
  @Deprecated('Use GameplayConfig.collisionDistance instead')
  static const double collisionDistance = 30.0;

  // Game mechanics
  @Deprecated('Use GameplayConfig.scorePerKill instead')
  static const int scorePerKill = 100;
  @Deprecated('Use GameplayConfig.targetFPS instead')
  static const int targetFPS = 60;
  static const int scoreIncrement = 100;

  // Bonus settings
  @Deprecated('Use GameplayConfig.bonus.multiplierValue instead')
  static const int bonusMultiplierValue = 2;
  @Deprecated('Use GameplayConfig.bonus.goldValue instead')
  static const int bonusGoldValue = 500;
  @Deprecated('Use GameplayConfig.bonus.rotationStep instead')
  static const double bonusRotationStep = 0.05;
  @Deprecated('Use GameplayConfig.bonus.dropRate instead')
  static const double bonusDropRate = 0.3;
  @Deprecated('Use GameplayConfig.bonus.size instead')
  static const double bonusSize = 30.0;

  // Game over screen settings
  static const double gameOverTextSize = 48.0;
  static const double scoreDisplayTextSize = 24.0;
  static const double gameOverSpacing = 20.0;
  static const double gameOverButtonPaddingH = 32.0;
  static const double gameOverButtonPaddingV = 16.0;

  // UI settings specific to gameplay
  static const double scoreTextSize = 20.0;
  static const double livesIconSize = 24.0;
  static const double livesTextSize = 20.0;

  // Difficulty settings
  @Deprecated('Use GameplayConfig.difficulty.levelSpeedIncrease instead')
  static const double levelSpeedIncrease = 0.5;
  @Deprecated('Use GameplayConfig.difficulty.healthIncreaseLevel instead')
  static const int healthIncreaseLevel = 3;
  @Deprecated('Use GameplayConfig.difficulty.bossSpeedMultiplier instead')
  static const double bossSpeedMultiplier = 1.5;
  @Deprecated('Use GameplayConfig.difficulty.bossHealthMultiplier instead')
  static const double bossHealthMultiplier = 2.0;
  @Deprecated('Use GameplayConfig.difficulty.bossScoreMultiplier instead')
  static const double bossScoreMultiplier = 10.0;
}
