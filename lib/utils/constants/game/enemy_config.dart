import 'base_config.dart';

/// Configuration for enemy settings and behavior
class EnemyConfig extends BaseGameConfig with JsonSerializable, Validatable {
  // Basic enemy settings
  final int count;
  final double size;
  final double spawnHeightRatio;
  final double baseSpeed;
  final double levelSpeedIncrease;
  final int healthIncreaseLevel;
  final double respawnHeight;
  final int baseHealth;

  // Boss settings
  final BossConfig boss;

  const EnemyConfig({
    this.count = 5,
    this.size = 40.0,
    this.spawnHeightRatio = 0.3,
    this.baseSpeed = 2.0,
    this.levelSpeedIncrease = 0.5,
    this.healthIncreaseLevel = 3,
    this.respawnHeight = -50.0,
    this.baseHealth = 2,
    this.boss = const BossConfig(),
  });

  @override
  List<String> get validationErrors {
    final errors = <String>[];

    if (count <= 0) {
      errors.add('Enemy count must be positive');
    }
    if (size <= 0) {
      errors.add('Enemy size must be positive');
    }
    if (spawnHeightRatio <= 0 || spawnHeightRatio >= 1) {
      errors.add('Spawn height ratio must be between 0 and 1');
    }
    if (baseSpeed <= 0) {
      errors.add('Base speed must be positive');
    }
    if (levelSpeedIncrease < 0) {
      errors.add('Level speed increase cannot be negative');
    }
    if (healthIncreaseLevel <= 0) {
      errors.add('Health increase level must be positive');
    }
    if (baseHealth <= 0) {
      errors.add('Base health must be positive');
    }

    final bossErrors = boss.validationErrors;
    if (bossErrors.isNotEmpty) {
      errors.addAll(bossErrors.map((e) => 'Boss: $e'));
    }

    return errors;
  }

  @override
  Map<String, dynamic> toJson() => {
        'count': count,
        'size': size,
        'spawnHeightRatio': spawnHeightRatio,
        'baseSpeed': baseSpeed,
        'levelSpeedIncrease': levelSpeedIncrease,
        'healthIncreaseLevel': healthIncreaseLevel,
        'respawnHeight': respawnHeight,
        'baseHealth': baseHealth,
        'boss': boss.toJson(),
      };

  factory EnemyConfig.fromJson(Map<String, dynamic> json) => EnemyConfig(
        count: json['count'] as int,
        size: json['size'] as double,
        spawnHeightRatio: json['spawnHeightRatio'] as double,
        baseSpeed: json['baseSpeed'] as double,
        levelSpeedIncrease: json['levelSpeedIncrease'] as double,
        healthIncreaseLevel: json['healthIncreaseLevel'] as int,
        respawnHeight: json['respawnHeight'] as double,
        baseHealth: json['baseHealth'] as int,
        boss: BossConfig.fromJson(json['boss'] as Map<String, dynamic>),
      );

  @override
  EnemyConfig copyWith({
    int? count,
    double? size,
    double? spawnHeightRatio,
    double? baseSpeed,
    double? levelSpeedIncrease,
    int? healthIncreaseLevel,
    double? respawnHeight,
    int? baseHealth,
    BossConfig? boss,
  }) {
    return EnemyConfig(
      count: count ?? this.count,
      size: size ?? this.size,
      spawnHeightRatio: spawnHeightRatio ?? this.spawnHeightRatio,
      baseSpeed: baseSpeed ?? this.baseSpeed,
      levelSpeedIncrease: levelSpeedIncrease ?? this.levelSpeedIncrease,
      healthIncreaseLevel: healthIncreaseLevel ?? this.healthIncreaseLevel,
      respawnHeight: respawnHeight ?? this.respawnHeight,
      baseHealth: baseHealth ?? this.baseHealth,
      boss: boss ?? this.boss,
    );
  }
}

/// Configuration for boss enemy settings
class BossConfig extends BaseGameConfig with JsonSerializable, Validatable {
  final double size;
  final double speed;
  final int health;
  final int scoreValue;
  final double startHeightRatio;
  final double playAreaPadding;
  final Duration aimDuration;
  final double novaProjectileSpeedMultiplier;
  final double novaAngleStep;
  final int novaProjectileCount;

  const BossConfig({
    this.size = 200.0,
    this.speed = 3.0,
    this.health = 100,
    this.scoreValue = 1000,
    this.startHeightRatio = 0.2,
    this.playAreaPadding = 200.0,
    this.aimDuration = const Duration(milliseconds: 1000),
    this.novaProjectileSpeedMultiplier = 0.8,
    this.novaAngleStep = 30.0,
    this.novaProjectileCount = 12,
  });

  @override
  List<String> get validationErrors {
    final errors = <String>[];

    if (size <= 0) {
      errors.add('Boss size must be positive');
    }
    if (speed <= 0) {
      errors.add('Boss speed must be positive');
    }
    if (health <= 0) {
      errors.add('Boss health must be positive');
    }
    if (scoreValue <= 0) {
      errors.add('Boss score value must be positive');
    }
    if (startHeightRatio <= 0 || startHeightRatio >= 1) {
      errors.add('Start height ratio must be between 0 and 1');
    }
    if (playAreaPadding < 0) {
      errors.add('Play area padding cannot be negative');
    }
    if (aimDuration.inMilliseconds <= 0) {
      errors.add('Aim duration must be positive');
    }
    if (novaProjectileSpeedMultiplier <= 0) {
      errors.add('Nova projectile speed multiplier must be positive');
    }
    if (novaAngleStep <= 0 || novaAngleStep >= 360) {
      errors.add('Nova angle step must be between 0 and 360');
    }
    if (novaProjectileCount <= 0) {
      errors.add('Nova projectile count must be positive');
    }

    return errors;
  }

  @override
  Map<String, dynamic> toJson() => {
        'size': size,
        'speed': speed,
        'health': health,
        'scoreValue': scoreValue,
        'startHeightRatio': startHeightRatio,
        'playAreaPadding': playAreaPadding,
        'aimDuration': aimDuration.inMilliseconds,
        'novaProjectileSpeedMultiplier': novaProjectileSpeedMultiplier,
        'novaAngleStep': novaAngleStep,
        'novaProjectileCount': novaProjectileCount,
      };

  factory BossConfig.fromJson(Map<String, dynamic> json) => BossConfig(
        size: json['size'] as double,
        speed: json['speed'] as double,
        health: json['health'] as int,
        scoreValue: json['scoreValue'] as int,
        startHeightRatio: json['startHeightRatio'] as double,
        playAreaPadding: json['playAreaPadding'] as double,
        aimDuration: Duration(milliseconds: json['aimDuration'] as int),
        novaProjectileSpeedMultiplier:
            json['novaProjectileSpeedMultiplier'] as double,
        novaAngleStep: json['novaAngleStep'] as double,
        novaProjectileCount: json['novaProjectileCount'] as int,
      );

  @override
  BossConfig copyWith({
    double? size,
    double? speed,
    int? health,
    int? scoreValue,
    double? startHeightRatio,
    double? playAreaPadding,
    Duration? aimDuration,
    double? novaProjectileSpeedMultiplier,
    double? novaAngleStep,
    int? novaProjectileCount,
  }) {
    return BossConfig(
      size: size ?? this.size,
      speed: speed ?? this.speed,
      health: health ?? this.health,
      scoreValue: scoreValue ?? this.scoreValue,
      startHeightRatio: startHeightRatio ?? this.startHeightRatio,
      playAreaPadding: playAreaPadding ?? this.playAreaPadding,
      aimDuration: aimDuration ?? this.aimDuration,
      novaProjectileSpeedMultiplier:
          novaProjectileSpeedMultiplier ?? this.novaProjectileSpeedMultiplier,
      novaAngleStep: novaAngleStep ?? this.novaAngleStep,
      novaProjectileCount: novaProjectileCount ?? this.novaProjectileCount,
    );
  }
}
