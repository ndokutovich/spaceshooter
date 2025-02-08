import '../constants/game/enemy_config.dart';

@Deprecated(
    'Use EnemyConfig from game/enemy_config.dart instead. This class will be removed in a future update.')
class EnemyConstants {
  // Basic enemy settings
  @Deprecated('Use EnemyConfig.count instead')
  static const int count = 5;
  @Deprecated('Use EnemyConfig.size instead')
  static const double size = 40.0;
  @Deprecated('Use EnemyConfig.spawnHeightRatio instead')
  static const double spawnHeightRatio = 0.3;
  @Deprecated('Use EnemyConfig.baseSpeed instead')
  static const double baseSpeed = 2.0;
  @Deprecated('Use EnemyConfig.levelSpeedIncrease instead')
  static const double levelSpeedIncrease = 0.5;
  @Deprecated('Use EnemyConfig.healthIncreaseLevel instead')
  static const int healthIncreaseLevel = 3;
  @Deprecated('Use EnemyConfig.respawnHeight instead')
  static const double respawnHeight = -50.0;
  @Deprecated('Use EnemyConfig.baseHealth instead')
  static const int baseHealth = 2;

  // Boss settings
  @Deprecated('Use EnemyConfig.boss.size instead')
  static const double bossSize = 200.0;
  @Deprecated('Use EnemyConfig.boss.speed instead')
  static const double bossSpeed = 3.0;
  @Deprecated('Use EnemyConfig.boss.health instead')
  static const int bossHealth = 100;
  @Deprecated('Use EnemyConfig.boss.scoreValue instead')
  static const int bossScoreValue = 1000;
  @Deprecated('Use EnemyConfig.boss.startHeightRatio instead')
  static const double bossStartHeightRatio = 0.2;
  @Deprecated('Use EnemyConfig.boss.playAreaPadding instead')
  static const double bossPlayAreaPadding = 200.0;
  @Deprecated('Use EnemyConfig.boss.aimDuration instead')
  static const Duration bossAimDuration = Duration(milliseconds: 1000);
  @Deprecated('Use EnemyConfig.boss.novaProjectileSpeedMultiplier instead')
  static const double bossNovaProjectileSpeedMultiplier = 0.8;
  @Deprecated('Use EnemyConfig.boss.novaAngleStep instead')
  static const double bossNovaAngleStep = 30.0;
  @Deprecated('Use EnemyConfig.boss.novaProjectileCount instead')
  static const int bossNovaProjectileCount = 12;
}
