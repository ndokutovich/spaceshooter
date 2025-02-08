import 'base_config.dart';

/// Configuration for nova blast settings
class NovaConfig extends BaseGameConfig with JsonSerializable, Validatable {
  /// Nova blast properties
  final int projectileCount;
  final double projectileSpeed;
  final int projectileDamage;
  final int maxBlasts;
  final double cooldown;
  final double radius;

  const NovaConfig({
    this.projectileCount = 16,
    this.projectileSpeed = 10.0,
    this.projectileDamage = 20,
    this.maxBlasts = 3,
    this.cooldown = 1.0,
    this.radius = 200.0,
  });

  @override
  List<String> get validationErrors {
    final errors = <String>[];
    if (projectileCount <= 0) errors.add('Projectile count must be positive');
    if (projectileSpeed <= 0) errors.add('Projectile speed must be positive');
    if (projectileDamage <= 0) errors.add('Projectile damage must be positive');
    if (maxBlasts <= 0) errors.add('Max blasts must be positive');
    if (cooldown < 0) errors.add('Cooldown cannot be negative');
    if (radius <= 0) errors.add('Radius must be positive');
    return errors;
  }

  @override
  Map<String, dynamic> toJson() => {
        'projectileCount': projectileCount,
        'projectileSpeed': projectileSpeed,
        'projectileDamage': projectileDamage,
        'maxBlasts': maxBlasts,
        'cooldown': cooldown,
        'radius': radius,
      };

  factory NovaConfig.fromJson(Map<String, dynamic> json) => NovaConfig(
        projectileCount: json['projectileCount'] as int,
        projectileSpeed: json['projectileSpeed'] as double,
        projectileDamage: json['projectileDamage'] as int,
        maxBlasts: json['maxBlasts'] as int,
        cooldown: json['cooldown'] as double,
        radius: json['radius'] as double,
      );

  @override
  NovaConfig copyWith({
    int? projectileCount,
    double? projectileSpeed,
    int? projectileDamage,
    int? maxBlasts,
    double? cooldown,
    double? radius,
  }) {
    return NovaConfig(
      projectileCount: projectileCount ?? this.projectileCount,
      projectileSpeed: projectileSpeed ?? this.projectileSpeed,
      projectileDamage: projectileDamage ?? this.projectileDamage,
      maxBlasts: maxBlasts ?? this.maxBlasts,
      cooldown: cooldown ?? this.cooldown,
      radius: radius ?? this.radius,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is NovaConfig &&
        other.projectileCount == projectileCount &&
        other.projectileSpeed == projectileSpeed &&
        other.projectileDamage == projectileDamage &&
        other.maxBlasts == maxBlasts &&
        other.cooldown == cooldown &&
        other.radius == radius;
  }

  @override
  int get hashCode =>
      projectileCount.hashCode ^
      projectileSpeed.hashCode ^
      projectileDamage.hashCode ^
      maxBlasts.hashCode ^
      cooldown.hashCode ^
      radius.hashCode;
}
