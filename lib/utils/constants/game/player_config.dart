import 'package:flutter/material.dart';
import 'base_config.dart';
import 'weapon_config.dart';
import 'nova_config.dart';

/// Configuration for player settings
class PlayerConfig extends BaseGameConfig with JsonSerializable, Validatable {
  /// Player dimensions
  final double size;
  final double startHeightRatio;
  final double playAreaPadding;

  /// Movement settings
  final double speed;
  final double rotationSpeed;
  final double acceleration;
  final double deceleration;
  final double maxSpeed;

  /// Health and status
  final int initialLives;
  final double invulnerabilityDuration;
  final double invulnerabilityOpacity;
  final double healthRegenRate;
  final int maxHealth;

  /// Weapon settings
  final WeaponConfig primaryWeapon;
  final WeaponConfig secondaryWeapon;
  final NovaConfig nova;

  /// UI settings
  final double scoreTextSize;
  final double livesIconSize;
  final double livesTextSize;
  final double actionButtonSize;
  final double novaCounterSize;
  final double novaCounterDisplaySize;
  final double gameOverTextSize;
  final double gameOverSpacing;
  final double scoreDisplayTextSize;
  final double menuButtonWidthRatio;
  final double menuButtonHeightRatio;
  final double menuButtonSpacingRatio;
  final double overlayOpacity;

  const PlayerConfig({
    this.size = 50.0,
    this.startHeightRatio = 0.8,
    this.playAreaPadding = 100.0,
    this.speed = 5.0,
    this.rotationSpeed = 0.1,
    this.acceleration = 0.5,
    this.deceleration = 0.3,
    this.maxSpeed = 10.0,
    this.initialLives = 3,
    this.invulnerabilityDuration = 2.0,
    this.invulnerabilityOpacity = 0.5,
    this.healthRegenRate = 0.1,
    this.maxHealth = 100,
    this.primaryWeapon = const WeaponConfig(),
    this.secondaryWeapon = const WeaponConfig(),
    this.nova = const NovaConfig(),
    this.scoreTextSize = 24.0,
    this.livesIconSize = 24.0,
    this.livesTextSize = 20.0,
    this.actionButtonSize = 60.0,
    this.novaCounterSize = 24.0,
    this.novaCounterDisplaySize = 32.0,
    this.gameOverTextSize = 48.0,
    this.gameOverSpacing = 20.0,
    this.scoreDisplayTextSize = 32.0,
    this.menuButtonWidthRatio = 0.4,
    this.menuButtonHeightRatio = 0.08,
    this.menuButtonSpacingRatio = 0.02,
    this.overlayOpacity = 0.7,
  });

  @override
  List<String> get validationErrors {
    final errors = <String>[];
    if (size <= 0) errors.add('Size must be positive');
    if (startHeightRatio <= 0 || startHeightRatio > 1) {
      errors.add('Start height ratio must be between 0 and 1');
    }
    if (playAreaPadding < 0) errors.add('Play area padding cannot be negative');
    if (speed < 0) errors.add('Speed cannot be negative');
    if (rotationSpeed < 0) errors.add('Rotation speed cannot be negative');
    if (acceleration < 0) errors.add('Acceleration cannot be negative');
    if (deceleration < 0) errors.add('Deceleration cannot be negative');
    if (maxSpeed < speed)
      errors.add('Max speed must be greater than base speed');
    if (initialLives <= 0) errors.add('Initial lives must be positive');
    if (invulnerabilityDuration < 0) {
      errors.add('Invulnerability duration cannot be negative');
    }
    if (invulnerabilityOpacity < 0 || invulnerabilityOpacity > 1) {
      errors.add('Invulnerability opacity must be between 0 and 1');
    }
    if (healthRegenRate < 0) errors.add('Health regen rate cannot be negative');
    return errors;
  }

  @override
  Map<String, dynamic> toJson() => {
        'size': size,
        'startHeightRatio': startHeightRatio,
        'playAreaPadding': playAreaPadding,
        'speed': speed,
        'rotationSpeed': rotationSpeed,
        'acceleration': acceleration,
        'deceleration': deceleration,
        'maxSpeed': maxSpeed,
        'initialLives': initialLives,
        'invulnerabilityDuration': invulnerabilityDuration,
        'invulnerabilityOpacity': invulnerabilityOpacity,
        'healthRegenRate': healthRegenRate,
        'maxHealth': maxHealth,
        'primaryWeapon': primaryWeapon.toJson(),
        'secondaryWeapon': secondaryWeapon.toJson(),
        'nova': nova.toJson(),
        'scoreTextSize': scoreTextSize,
        'livesIconSize': livesIconSize,
        'livesTextSize': livesTextSize,
        'actionButtonSize': actionButtonSize,
        'novaCounterSize': novaCounterSize,
        'novaCounterDisplaySize': novaCounterDisplaySize,
        'gameOverTextSize': gameOverTextSize,
        'gameOverSpacing': gameOverSpacing,
        'scoreDisplayTextSize': scoreDisplayTextSize,
        'menuButtonWidthRatio': menuButtonWidthRatio,
        'menuButtonHeightRatio': menuButtonHeightRatio,
        'menuButtonSpacingRatio': menuButtonSpacingRatio,
        'overlayOpacity': overlayOpacity,
      };

  /// Creates a PlayerConfig from JSON
  factory PlayerConfig.fromJson(Map<String, dynamic> json) => PlayerConfig(
        size: json['size'] as double,
        startHeightRatio: json['startHeightRatio'] as double,
        playAreaPadding: json['playAreaPadding'] as double,
        speed: json['speed'] as double,
        rotationSpeed: json['rotationSpeed'] as double,
        acceleration: json['acceleration'] as double,
        deceleration: json['deceleration'] as double,
        maxSpeed: json['maxSpeed'] as double,
        initialLives: json['initialLives'] as int,
        invulnerabilityDuration: json['invulnerabilityDuration'] as double,
        invulnerabilityOpacity: json['invulnerabilityOpacity'] as double,
        healthRegenRate: json['healthRegenRate'] as double,
        maxHealth: json['maxHealth'] as int,
        primaryWeapon: WeaponConfig.fromJson(
            json['primaryWeapon'] as Map<String, dynamic>),
        secondaryWeapon: WeaponConfig.fromJson(
            json['secondaryWeapon'] as Map<String, dynamic>),
        nova: NovaConfig.fromJson(json['nova'] as Map<String, dynamic>),
        scoreTextSize: json['scoreTextSize'] as double,
        livesIconSize: json['livesIconSize'] as double,
        livesTextSize: json['livesTextSize'] as double,
        actionButtonSize: json['actionButtonSize'] as double,
        novaCounterSize: json['novaCounterSize'] as double,
        novaCounterDisplaySize: json['novaCounterDisplaySize'] as double,
        gameOverTextSize: json['gameOverTextSize'] as double,
        gameOverSpacing: json['gameOverSpacing'] as double,
        scoreDisplayTextSize: json['scoreDisplayTextSize'] as double,
        menuButtonWidthRatio: json['menuButtonWidthRatio'] as double,
        menuButtonHeightRatio: json['menuButtonHeightRatio'] as double,
        menuButtonSpacingRatio: json['menuButtonSpacingRatio'] as double,
        overlayOpacity: json['overlayOpacity'] as double,
      );

  @override
  PlayerConfig copyWith({
    double? size,
    double? startHeightRatio,
    double? playAreaPadding,
    double? speed,
    double? rotationSpeed,
    double? acceleration,
    double? deceleration,
    double? maxSpeed,
    int? initialLives,
    double? invulnerabilityDuration,
    double? invulnerabilityOpacity,
    double? healthRegenRate,
    int? maxHealth,
    WeaponConfig? primaryWeapon,
    WeaponConfig? secondaryWeapon,
    NovaConfig? nova,
    double? scoreTextSize,
    double? livesIconSize,
    double? livesTextSize,
    double? actionButtonSize,
    double? novaCounterSize,
    double? novaCounterDisplaySize,
    double? gameOverTextSize,
    double? gameOverSpacing,
    double? scoreDisplayTextSize,
    double? menuButtonWidthRatio,
    double? menuButtonHeightRatio,
    double? menuButtonSpacingRatio,
    double? overlayOpacity,
  }) {
    return PlayerConfig(
      size: size ?? this.size,
      startHeightRatio: startHeightRatio ?? this.startHeightRatio,
      playAreaPadding: playAreaPadding ?? this.playAreaPadding,
      speed: speed ?? this.speed,
      rotationSpeed: rotationSpeed ?? this.rotationSpeed,
      acceleration: acceleration ?? this.acceleration,
      deceleration: deceleration ?? this.deceleration,
      maxSpeed: maxSpeed ?? this.maxSpeed,
      initialLives: initialLives ?? this.initialLives,
      invulnerabilityDuration:
          invulnerabilityDuration ?? this.invulnerabilityDuration,
      invulnerabilityOpacity:
          invulnerabilityOpacity ?? this.invulnerabilityOpacity,
      healthRegenRate: healthRegenRate ?? this.healthRegenRate,
      maxHealth: maxHealth ?? this.maxHealth,
      primaryWeapon: primaryWeapon ?? this.primaryWeapon,
      secondaryWeapon: secondaryWeapon ?? this.secondaryWeapon,
      nova: nova ?? this.nova,
      scoreTextSize: scoreTextSize ?? this.scoreTextSize,
      livesIconSize: livesIconSize ?? this.livesIconSize,
      livesTextSize: livesTextSize ?? this.livesTextSize,
      actionButtonSize: actionButtonSize ?? this.actionButtonSize,
      novaCounterSize: novaCounterSize ?? this.novaCounterSize,
      novaCounterDisplaySize:
          novaCounterDisplaySize ?? this.novaCounterDisplaySize,
      gameOverTextSize: gameOverTextSize ?? this.gameOverTextSize,
      gameOverSpacing: gameOverSpacing ?? this.gameOverSpacing,
      scoreDisplayTextSize: scoreDisplayTextSize ?? this.scoreDisplayTextSize,
      menuButtonWidthRatio: menuButtonWidthRatio ?? this.menuButtonWidthRatio,
      menuButtonHeightRatio:
          menuButtonHeightRatio ?? this.menuButtonHeightRatio,
      menuButtonSpacingRatio:
          menuButtonSpacingRatio ?? this.menuButtonSpacingRatio,
      overlayOpacity: overlayOpacity ?? this.overlayOpacity,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is PlayerConfig &&
        other.size == size &&
        other.startHeightRatio == startHeightRatio &&
        other.playAreaPadding == playAreaPadding &&
        other.speed == speed &&
        other.rotationSpeed == rotationSpeed &&
        other.acceleration == acceleration &&
        other.deceleration == deceleration &&
        other.maxSpeed == maxSpeed &&
        other.initialLives == initialLives &&
        other.invulnerabilityDuration == invulnerabilityDuration &&
        other.invulnerabilityOpacity == invulnerabilityOpacity &&
        other.healthRegenRate == healthRegenRate &&
        other.maxHealth == maxHealth &&
        other.primaryWeapon == primaryWeapon &&
        other.secondaryWeapon == secondaryWeapon &&
        other.nova == nova &&
        other.scoreTextSize == scoreTextSize &&
        other.livesIconSize == livesIconSize &&
        other.livesTextSize == livesTextSize &&
        other.actionButtonSize == actionButtonSize &&
        other.novaCounterSize == novaCounterSize &&
        other.novaCounterDisplaySize == novaCounterDisplaySize &&
        other.gameOverTextSize == gameOverTextSize &&
        other.gameOverSpacing == gameOverSpacing &&
        other.scoreDisplayTextSize == scoreDisplayTextSize &&
        other.menuButtonWidthRatio == menuButtonWidthRatio &&
        other.menuButtonHeightRatio == menuButtonHeightRatio &&
        other.menuButtonSpacingRatio == menuButtonSpacingRatio &&
        other.overlayOpacity == overlayOpacity;
  }

  @override
  int get hashCode =>
      size.hashCode ^
      startHeightRatio.hashCode ^
      playAreaPadding.hashCode ^
      speed.hashCode ^
      rotationSpeed.hashCode ^
      acceleration.hashCode ^
      deceleration.hashCode ^
      maxSpeed.hashCode ^
      initialLives.hashCode ^
      invulnerabilityDuration.hashCode ^
      invulnerabilityOpacity.hashCode ^
      healthRegenRate.hashCode ^
      maxHealth.hashCode ^
      primaryWeapon.hashCode ^
      secondaryWeapon.hashCode ^
      nova.hashCode ^
      scoreTextSize.hashCode ^
      livesIconSize.hashCode ^
      livesTextSize.hashCode ^
      actionButtonSize.hashCode ^
      novaCounterSize.hashCode ^
      novaCounterDisplaySize.hashCode ^
      gameOverTextSize.hashCode ^
      gameOverSpacing.hashCode ^
      scoreDisplayTextSize.hashCode ^
      menuButtonWidthRatio.hashCode ^
      menuButtonHeightRatio.hashCode ^
      menuButtonSpacingRatio.hashCode ^
      overlayOpacity.hashCode;
}

/// Configuration for weapon settings
class WeaponConfig extends BaseGameConfig with JsonSerializable {
  final double width;
  final double height;
  final double offset;
  final double speed;
  final double cooldown;
  final double damage;

  const WeaponConfig({
    this.width = 4.0,
    this.height = 20.0,
    this.offset = 20.0,
    this.speed = 10.0,
    this.cooldown = 0.2,
    this.damage = 1.0,
  });

  @override
  Map<String, dynamic> toJson() => {
        'width': width,
        'height': height,
        'offset': offset,
        'speed': speed,
        'cooldown': cooldown,
        'damage': damage,
      };

  factory WeaponConfig.fromJson(Map<String, dynamic> json) => WeaponConfig(
        width: json['width'] as double,
        height: json['height'] as double,
        offset: json['offset'] as double,
        speed: json['speed'] as double,
        cooldown: json['cooldown'] as double,
        damage: json['damage'] as double,
      );

  @override
  WeaponConfig copyWith({
    double? width,
    double? height,
    double? offset,
    double? speed,
    double? cooldown,
    double? damage,
  }) {
    return WeaponConfig(
      width: width ?? this.width,
      height: height ?? this.height,
      offset: offset ?? this.offset,
      speed: speed ?? this.speed,
      cooldown: cooldown ?? this.cooldown,
      damage: damage ?? this.damage,
    );
  }
}

/// Configuration for nova ability
class NovaConfig extends BaseGameConfig with JsonSerializable {
  final double angleStep;
  final int initialBlasts;
  final double cooldown;
  final double damage;

  const NovaConfig({
    this.angleStep = 45.0,
    this.initialBlasts = 3,
    this.cooldown = 5.0,
    this.damage = 2.0,
  });

  @override
  Map<String, dynamic> toJson() => {
        'angleStep': angleStep,
        'initialBlasts': initialBlasts,
        'cooldown': cooldown,
        'damage': damage,
      };

  factory NovaConfig.fromJson(Map<String, dynamic> json) => NovaConfig(
        angleStep: json['angleStep'] as double,
        initialBlasts: json['initialBlasts'] as int,
        cooldown: json['cooldown'] as double,
        damage: json['damage'] as double,
      );

  @override
  NovaConfig copyWith({
    double? angleStep,
    int? initialBlasts,
    double? cooldown,
    double? damage,
  }) {
    return NovaConfig(
      angleStep: angleStep ?? this.angleStep,
      initialBlasts: initialBlasts ?? this.initialBlasts,
      cooldown: cooldown ?? this.cooldown,
      damage: damage ?? this.damage,
    );
  }
}
