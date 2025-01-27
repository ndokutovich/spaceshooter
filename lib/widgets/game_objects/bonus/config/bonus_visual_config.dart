import 'package:flutter/material.dart';
import '../../../../game/entities/bonus_item.dart';

/// Configuration for bonus item visual properties
class BonusVisualConfig {
  // Base colors
  final Color primaryColor;
  final Color secondaryColor;
  final Color glowColor;
  final Color sparkleColor;

  // Glow effects
  final double glowRadius;
  final double glowOpacity;
  final BlurStyle glowStyle;

  // Size properties
  final double baseRadius;
  final double textScale;
  final double sparkleRadius;

  // Sparkle effects
  final int sparkleCount;
  final double sparkleOpacity;
  final double sparkleDistanceScale;

  // Shape properties (for gold ore)
  final int vertexCount;
  final double vertexVariance;

  const BonusVisualConfig._({
    required this.primaryColor,
    required this.secondaryColor,
    required this.glowColor,
    required this.sparkleColor,
    this.glowRadius = 5.0,
    this.glowOpacity = 0.5,
    this.glowStyle = BlurStyle.outer,
    this.baseRadius = 0.3,
    this.textScale = 0.4,
    this.sparkleRadius = 0.05,
    this.sparkleCount = 4,
    this.sparkleOpacity = 1.0,
    this.sparkleDistanceScale = 0.7,
    this.vertexCount = 8,
    this.vertexVariance = 0.4,
  });

  /// Create configuration for damage multiplier bonus
  factory BonusVisualConfig.damageMultiplier() {
    return const BonusVisualConfig._(
      primaryColor: Color(0xFFEF5350), // Red 400
      secondaryColor: Color(0xFFC62828), // Red 800
      glowColor: Color(0xFFEF5350), // Red 400
      sparkleColor: Colors.white,
    );
  }

  /// Create configuration for gold ore bonus
  factory BonusVisualConfig.goldOre() {
    return const BonusVisualConfig._(
      primaryColor: Color(0xFFFFEB3B), // Yellow
      secondaryColor: Color(0xFFFB8C00), // Orange 800
      glowColor: Color(0xFFFFA000), // Orange 700
      sparkleColor: Colors.white,
    );
  }

  /// Get configuration for specific bonus type
  factory BonusVisualConfig.forType(BonusType type) {
    switch (type) {
      case BonusType.damageMultiplier:
        return BonusVisualConfig.damageMultiplier();
      case BonusType.goldOre:
        return BonusVisualConfig.goldOre();
    }
  }

  /// Create a copy of this configuration with some properties replaced
  BonusVisualConfig copyWith({
    Color? primaryColor,
    Color? secondaryColor,
    Color? glowColor,
    Color? sparkleColor,
    double? glowRadius,
    double? glowOpacity,
    BlurStyle? glowStyle,
    double? baseRadius,
    double? textScale,
    double? sparkleRadius,
    int? sparkleCount,
    double? sparkleOpacity,
    double? sparkleDistanceScale,
    int? vertexCount,
    double? vertexVariance,
  }) {
    return BonusVisualConfig._(
      primaryColor: primaryColor ?? this.primaryColor,
      secondaryColor: secondaryColor ?? this.secondaryColor,
      glowColor: glowColor ?? this.glowColor,
      sparkleColor: sparkleColor ?? this.sparkleColor,
      glowRadius: glowRadius ?? this.glowRadius,
      glowOpacity: glowOpacity ?? this.glowOpacity,
      glowStyle: glowStyle ?? this.glowStyle,
      baseRadius: baseRadius ?? this.baseRadius,
      textScale: textScale ?? this.textScale,
      sparkleRadius: sparkleRadius ?? this.sparkleRadius,
      sparkleCount: sparkleCount ?? this.sparkleCount,
      sparkleOpacity: sparkleOpacity ?? this.sparkleOpacity,
      sparkleDistanceScale: sparkleDistanceScale ?? this.sparkleDistanceScale,
      vertexCount: vertexCount ?? this.vertexCount,
      vertexVariance: vertexVariance ?? this.vertexVariance,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BonusVisualConfig &&
          runtimeType == other.runtimeType &&
          primaryColor == other.primaryColor &&
          secondaryColor == other.secondaryColor &&
          glowColor == other.glowColor &&
          sparkleColor == other.sparkleColor &&
          glowRadius == other.glowRadius &&
          glowOpacity == other.glowOpacity &&
          glowStyle == other.glowStyle &&
          baseRadius == other.baseRadius &&
          textScale == other.textScale &&
          sparkleRadius == other.sparkleRadius &&
          sparkleCount == other.sparkleCount &&
          sparkleOpacity == other.sparkleOpacity &&
          sparkleDistanceScale == other.sparkleDistanceScale &&
          vertexCount == other.vertexCount &&
          vertexVariance == other.vertexVariance;

  @override
  int get hashCode =>
      primaryColor.hashCode ^
      secondaryColor.hashCode ^
      glowColor.hashCode ^
      sparkleColor.hashCode ^
      glowRadius.hashCode ^
      glowOpacity.hashCode ^
      glowStyle.hashCode ^
      baseRadius.hashCode ^
      textScale.hashCode ^
      sparkleRadius.hashCode ^
      sparkleCount.hashCode ^
      sparkleOpacity.hashCode ^
      sparkleDistanceScale.hashCode ^
      vertexCount.hashCode ^
      vertexVariance.hashCode;
}
