import '../constants/game/config.dart';

@Deprecated(
    'Use PlayerConfig from game/config.dart instead. This class will be removed in a future update.')
class PlayerConstants {
  // Player settings
  @Deprecated('Use PlayerConfig.size instead')
  static const double size = 50.0;
  @Deprecated('Use PlayerConfig.startHeightRatio instead')
  static const double startHeightRatio = 0.8;
  @Deprecated('Use PlayerConfig.speed instead')
  static const double speed = 5.0;
  @Deprecated('Use PlayerConfig.initialLives instead')
  static const int initialLives = 3;
  @Deprecated('Use PlayerConfig.invulnerabilityOpacity instead')
  static const double invulnerabilityOpacity = 0.5;

  // Player projectile settings
  @Deprecated('Use PlayerConfig.primaryWeapon.width instead')
  static const double projectileWidth = 4.0;
  @Deprecated('Use PlayerConfig.primaryWeapon.height instead')
  static const double projectileHeight = 20.0;
  @Deprecated('Use PlayerConfig.primaryWeapon.offset instead')
  static const double projectileOffset = 20.0;
  @Deprecated('Use PlayerConfig.primaryWeapon.speed instead')
  static const double projectileSpeed = 10.0;
  @Deprecated('Use PlayerConfig.nova.angleStep instead')
  static const double novaAngleStep = 45.0;
  @Deprecated('Use PlayerConfig.nova.initialBlasts instead')
  static const int initialNovaBlasts = 3;
}
