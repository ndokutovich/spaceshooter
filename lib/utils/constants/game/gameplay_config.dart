import 'package:flutter/material.dart';
import 'base_config.dart';

/// Configuration for core gameplay settings
class GameplayConfig extends BaseGameConfig with JsonSerializable, Validatable {
  /// Game mechanics
  final int targetFPS;
  final int scorePerKill;

  /// Play area settings
  final double playAreaPadding;
  final double borderWidth;
  final double collisionDistance;

  /// Asteroid settings
  final AsteroidConfig asteroids;

  /// Bonus settings
  final BonusConfig bonuses;

  /// Difficulty settings
  final DifficultyConfig difficulty;

  const GameplayConfig({
    this.targetFPS = 60,
    this.scorePerKill = 100,
    this.playAreaPadding = 100.0,
    this.borderWidth = 2.0,
    this.collisionDistance = 30.0,
    this.asteroids = const AsteroidConfig(),
    this.bonuses = const BonusConfig(),
    this.difficulty = const DifficultyConfig(),
  });

  @override
  List<String> get validationErrors {
    final errors = <String>[];
    if (targetFPS <= 0) errors.add('Target FPS must be positive');
    if (scorePerKill < 0) errors.add('Score per kill cannot be negative');
    if (playAreaPadding < 0) errors.add('Play area padding cannot be negative');
    if (borderWidth < 0) errors.add('Border width cannot be negative');
    if (collisionDistance < 0) {
      errors.add('Collision distance cannot be negative');
    }

    if (!asteroids.validate()) {
      errors.addAll(asteroids.validationErrors.map((e) => 'Asteroids: $e'));
    }
    if (!bonuses.validate()) {
      errors.addAll(bonuses.validationErrors.map((e) => 'Bonuses: $e'));
    }
    if (!difficulty.validate()) {
      errors.addAll(difficulty.validationErrors.map((e) => 'Difficulty: $e'));
    }
    return errors;
  }

  @override
  Map<String, dynamic> toJson() => {
        'targetFPS': targetFPS,
        'scorePerKill': scorePerKill,
        'playAreaPadding': playAreaPadding,
        'borderWidth': borderWidth,
        'collisionDistance': collisionDistance,
        'asteroids': asteroids.toJson(),
        'bonuses': bonuses.toJson(),
        'difficulty': difficulty.toJson(),
      };

  factory GameplayConfig.fromJson(Map<String, dynamic> json) => GameplayConfig(
        targetFPS: json['targetFPS'] as int,
        scorePerKill: json['scorePerKill'] as int,
        playAreaPadding: json['playAreaPadding'] as double,
        borderWidth: json['borderWidth'] as double,
        collisionDistance: json['collisionDistance'] as double,
        asteroids:
            AsteroidConfig.fromJson(json['asteroids'] as Map<String, dynamic>),
        bonuses: BonusConfig.fromJson(json['bonuses'] as Map<String, dynamic>),
        difficulty: DifficultyConfig.fromJson(
            json['difficulty'] as Map<String, dynamic>),
      );

  @override
  GameplayConfig copyWith({
    int? targetFPS,
    int? scorePerKill,
    double? playAreaPadding,
    double? borderWidth,
    double? collisionDistance,
    AsteroidConfig? asteroids,
    BonusConfig? bonuses,
    DifficultyConfig? difficulty,
  }) {
    return GameplayConfig(
      targetFPS: targetFPS ?? this.targetFPS,
      scorePerKill: scorePerKill ?? this.scorePerKill,
      playAreaPadding: playAreaPadding ?? this.playAreaPadding,
      borderWidth: borderWidth ?? this.borderWidth,
      collisionDistance: collisionDistance ?? this.collisionDistance,
      asteroids: asteroids ?? this.asteroids,
      bonuses: bonuses ?? this.bonuses,
      difficulty: difficulty ?? this.difficulty,
    );
  }
}

/// Configuration for asteroid settings
class AsteroidConfig extends BaseGameConfig with JsonSerializable, Validatable {
  final int count;
  final double size;
  final double baseSpeed;
  final double maxSpeedVariation;
  final int baseHealth;
  final int healthIncreaseLevel;

  const AsteroidConfig({
    this.count = 6,
    this.size = 50.0,
    this.baseSpeed = 1.0,
    this.maxSpeedVariation = 1.0,
    this.baseHealth = 3,
    this.healthIncreaseLevel = 2,
  });

  @override
  List<String> get validationErrors {
    final errors = <String>[];
    if (count <= 0) errors.add('Asteroid count must be positive');
    if (size <= 0) errors.add('Asteroid size must be positive');
    if (baseSpeed <= 0) errors.add('Base speed must be positive');
    if (maxSpeedVariation < 0)
      errors.add('Speed variation must be non-negative');
    if (baseHealth <= 0) errors.add('Base health must be positive');
    if (healthIncreaseLevel <= 0)
      errors.add('Health increase level must be positive');
    return errors;
  }

  @override
  Map<String, dynamic> toJson() => {
        'count': count,
        'size': size,
        'baseSpeed': baseSpeed,
        'maxSpeedVariation': maxSpeedVariation,
        'baseHealth': baseHealth,
        'healthIncreaseLevel': healthIncreaseLevel,
      };

  factory AsteroidConfig.fromJson(Map<String, dynamic> json) => AsteroidConfig(
        count: json['count'] as int,
        size: json['size'] as double,
        baseSpeed: json['baseSpeed'] as double,
        maxSpeedVariation: json['maxSpeedVariation'] as double,
        baseHealth: json['baseHealth'] as int,
        healthIncreaseLevel: json['healthIncreaseLevel'] as int,
      );

  @override
  AsteroidConfig copyWith({
    int? count,
    double? size,
    double? baseSpeed,
    double? maxSpeedVariation,
    int? baseHealth,
    int? healthIncreaseLevel,
  }) {
    return AsteroidConfig(
      count: count ?? this.count,
      size: size ?? this.size,
      baseSpeed: baseSpeed ?? this.baseSpeed,
      maxSpeedVariation: maxSpeedVariation ?? this.maxSpeedVariation,
      baseHealth: baseHealth ?? this.baseHealth,
      healthIncreaseLevel: healthIncreaseLevel ?? this.healthIncreaseLevel,
    );
  }
}

/// Configuration for bonus settings
class BonusConfig extends BaseGameConfig with JsonSerializable, Validatable {
  final int multiplierValue;
  final int goldValue;
  final double rotationStep;
  final double dropRate;
  final double size;

  const BonusConfig({
    this.multiplierValue = 2,
    this.goldValue = 500,
    this.rotationStep = 0.05,
    this.dropRate = 0.3,
    this.size = 30.0,
  });

  @override
  List<String> get validationErrors {
    final errors = <String>[];
    if (multiplierValue <= 1)
      errors.add('Multiplier value must be greater than 1');
    if (goldValue <= 0) errors.add('Gold value must be positive');
    if (rotationStep <= 0) errors.add('Rotation step must be positive');
    if (dropRate <= 0 || dropRate > 1)
      errors.add('Drop rate must be between 0 and 1');
    if (size <= 0) errors.add('Size must be positive');
    return errors;
  }

  @override
  Map<String, dynamic> toJson() => {
        'multiplierValue': multiplierValue,
        'goldValue': goldValue,
        'rotationStep': rotationStep,
        'dropRate': dropRate,
        'size': size,
      };

  factory BonusConfig.fromJson(Map<String, dynamic> json) => BonusConfig(
        multiplierValue: json['multiplierValue'] as int,
        goldValue: json['goldValue'] as int,
        rotationStep: json['rotationStep'] as double,
        dropRate: json['dropRate'] as double,
        size: json['size'] as double,
      );

  @override
  BonusConfig copyWith({
    int? multiplierValue,
    int? goldValue,
    double? rotationStep,
    double? dropRate,
    double? size,
  }) {
    return BonusConfig(
      multiplierValue: multiplierValue ?? this.multiplierValue,
      goldValue: goldValue ?? this.goldValue,
      rotationStep: rotationStep ?? this.rotationStep,
      dropRate: dropRate ?? this.dropRate,
      size: size ?? this.size,
    );
  }
}

/// Configuration for difficulty settings
class DifficultyConfig extends BaseGameConfig
    with JsonSerializable, Validatable {
  final double levelSpeedIncrease;
  final int healthIncreaseLevel;
  final double bossSpeedMultiplier;
  final double bossHealthMultiplier;
  final double bossScoreMultiplier;

  const DifficultyConfig({
    this.levelSpeedIncrease = 0.5,
    this.healthIncreaseLevel = 3,
    this.bossSpeedMultiplier = 1.5,
    this.bossHealthMultiplier = 2.0,
    this.bossScoreMultiplier = 10.0,
  });

  @override
  List<String> get validationErrors {
    final errors = <String>[];
    if (levelSpeedIncrease < 0)
      errors.add('Level speed increase must be non-negative');
    if (healthIncreaseLevel <= 0)
      errors.add('Health increase level must be positive');
    if (bossSpeedMultiplier <= 0)
      errors.add('Boss speed multiplier must be positive');
    if (bossHealthMultiplier <= 0)
      errors.add('Boss health multiplier must be positive');
    if (bossScoreMultiplier <= 0)
      errors.add('Boss score multiplier must be positive');
    return errors;
  }

  @override
  Map<String, dynamic> toJson() => {
        'levelSpeedIncrease': levelSpeedIncrease,
        'healthIncreaseLevel': healthIncreaseLevel,
        'bossSpeedMultiplier': bossSpeedMultiplier,
        'bossHealthMultiplier': bossHealthMultiplier,
        'bossScoreMultiplier': bossScoreMultiplier,
      };

  factory DifficultyConfig.fromJson(Map<String, dynamic> json) =>
      DifficultyConfig(
        levelSpeedIncrease: json['levelSpeedIncrease'] as double,
        healthIncreaseLevel: json['healthIncreaseLevel'] as int,
        bossSpeedMultiplier: json['bossSpeedMultiplier'] as double,
        bossHealthMultiplier: json['bossHealthMultiplier'] as double,
        bossScoreMultiplier: json['bossScoreMultiplier'] as double,
      );

  @override
  DifficultyConfig copyWith({
    double? levelSpeedIncrease,
    int? healthIncreaseLevel,
    double? bossSpeedMultiplier,
    double? bossHealthMultiplier,
    double? bossScoreMultiplier,
  }) {
    return DifficultyConfig(
      levelSpeedIncrease: levelSpeedIncrease ?? this.levelSpeedIncrease,
      healthIncreaseLevel: healthIncreaseLevel ?? this.healthIncreaseLevel,
      bossSpeedMultiplier: bossSpeedMultiplier ?? this.bossSpeedMultiplier,
      bossHealthMultiplier: bossHealthMultiplier ?? this.bossHealthMultiplier,
      bossScoreMultiplier: bossScoreMultiplier ?? this.bossScoreMultiplier,
    );
  }
}
