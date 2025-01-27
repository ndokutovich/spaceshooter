class EnemyConstants {
  // Basic enemy settings
  static const int count = 5;
  static const double size = 40.0;
  static const double spawnHeightRatio = 0.3;
  static const double baseSpeed = 2.0;
  static const double levelSpeedIncrease = 0.5;
  static const int healthIncreaseLevel = 3;
  static const double respawnHeight = -50.0;
  static const int baseHealth = 2;

  // Boss settings
  static const double bossSize = 200.0;
  static const double bossSpeed = 3.0;
  static const int bossHealth = 100;
  static const int bossScoreValue = 1000;
  static const double bossStartHeightRatio = 0.2;
  static const double bossPlayAreaPadding = 200.0;
  static const Duration bossAimDuration = Duration(milliseconds: 1000);
  static const double bossNovaProjectileSpeedMultiplier = 0.8;
  static const double bossNovaAngleStep = 30.0;
  static const int bossNovaProjectileCount = 12;
}
