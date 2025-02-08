import 'base_config.dart';

/// Configuration for weapon settings
class WeaponConfig extends BaseGameConfig with JsonSerializable, Validatable {
  /// Weapon properties
  final double damage;
  final double speed;
  final double cooldown;
  final double size;
  final double range;

  const WeaponConfig({
    this.damage = 10.0,
    this.speed = 8.0,
    this.cooldown = 0.2,
    this.size = 5.0,
    this.range = 1000.0,
  });

  @override
  List<String> get validationErrors {
    final errors = <String>[];
    if (damage < 0) errors.add('Damage cannot be negative');
    if (speed <= 0) errors.add('Speed must be positive');
    if (cooldown < 0) errors.add('Cooldown cannot be negative');
    if (size <= 0) errors.add('Size must be positive');
    if (range <= 0) errors.add('Range must be positive');
    return errors;
  }

  @override
  Map<String, dynamic> toJson() => {
        'damage': damage,
        'speed': speed,
        'cooldown': cooldown,
        'size': size,
        'range': range,
      };

  factory WeaponConfig.fromJson(Map<String, dynamic> json) => WeaponConfig(
        damage: json['damage'] as double,
        speed: json['speed'] as double,
        cooldown: json['cooldown'] as double,
        size: json['size'] as double,
        range: json['range'] as double,
      );

  @override
  WeaponConfig copyWith({
    double? damage,
    double? speed,
    double? cooldown,
    double? size,
    double? range,
  }) {
    return WeaponConfig(
      damage: damage ?? this.damage,
      speed: speed ?? this.speed,
      cooldown: cooldown ?? this.cooldown,
      size: size ?? this.size,
      range: range ?? this.range,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is WeaponConfig &&
        other.damage == damage &&
        other.speed == speed &&
        other.cooldown == cooldown &&
        other.size == size &&
        other.range == range;
  }

  @override
  int get hashCode =>
      damage.hashCode ^
      speed.hashCode ^
      cooldown.hashCode ^
      size.hashCode ^
      range.hashCode;
}
