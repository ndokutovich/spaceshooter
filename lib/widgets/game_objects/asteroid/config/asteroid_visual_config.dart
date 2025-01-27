import 'package:flutter/material.dart';

/// Configuration for asteroid visual properties
class AsteroidVisualConfig {
  // Base colors
  final Color primaryColor;
  final Color accentColor;
  final Color damageColor;
  final Color glowColor;

  // Shape properties
  final double baseRadius;
  final double radiusVariance;
  final int vertexCount;
  final double vertexVariance;

  // Damage effects
  final int cracksPerDamageLevel;
  final int chipsPerDamageLevel;
  final double crackLength;
  final double crackWidth;
  final double chipSize;
  final double crackOpacity;
  final double chipOpacity;

  // Surface details
  final int craterCount;
  final double craterSize;
  final double craterSizeVariance;
  final double craterOpacity;
  final double craterEccentricity;

  // Glow effects
  final double glowRadius;
  final double glowOpacity;
  final BlurStyle glowStyle;

  // Edge highlights
  final double edgeWidth;
  final double edgeOpacity;
  final Color edgeHighlightColor;

  const AsteroidVisualConfig({
    this.primaryColor = const Color(0xFF8B4513), // Saddle brown
    this.accentColor = const Color(0xFFD2691E), // Chocolate
    this.damageColor = Colors.red,
    this.glowColor = Colors.white,
    this.baseRadius = 0.4,
    this.radiusVariance = 0.2,
    this.vertexCount = 8,
    this.vertexVariance = 0.2,
    this.cracksPerDamageLevel = 3,
    this.chipsPerDamageLevel = 2,
    this.crackLength = 0.3,
    this.crackWidth = 2.0,
    this.chipSize = 0.15,
    this.crackOpacity = 0.7,
    this.chipOpacity = 0.5,
    this.craterCount = 3,
    this.craterSize = 0.2,
    this.craterSizeVariance = 0.2,
    this.craterOpacity = 0.6,
    this.craterEccentricity = 0.8,
    this.glowRadius = 3.0,
    this.glowOpacity = 0.3,
    this.glowStyle = BlurStyle.outer,
    this.edgeWidth = 2.0,
    this.edgeOpacity = 0.3,
    this.edgeHighlightColor = Colors.white,
  });

  /// Create a damaged version of the configuration based on health
  AsteroidVisualConfig withDamage(int health, {int maxHealth = 3}) {
    final damageRatio = 1 - (health / maxHealth);
    return AsteroidVisualConfig(
      primaryColor: Color.lerp(primaryColor, damageColor, damageRatio)!,
      accentColor: Color.lerp(accentColor, damageColor, damageRatio)!,
      damageColor: damageColor,
      glowColor: Color.lerp(glowColor, damageColor, damageRatio)!,
      baseRadius: baseRadius,
      radiusVariance: radiusVariance,
      vertexCount: vertexCount,
      vertexVariance: vertexVariance,
      cracksPerDamageLevel: cracksPerDamageLevel,
      chipsPerDamageLevel: chipsPerDamageLevel,
      crackLength: crackLength,
      crackWidth: crackWidth,
      chipSize: chipSize,
      crackOpacity: crackOpacity + (damageRatio * 0.2),
      chipOpacity: chipOpacity + (damageRatio * 0.2),
      craterCount: craterCount,
      craterSize: craterSize,
      craterSizeVariance: craterSizeVariance,
      craterOpacity: craterOpacity,
      craterEccentricity: craterEccentricity,
      glowRadius: glowRadius + (damageRatio * 2),
      glowOpacity: glowOpacity + (damageRatio * 0.2),
      glowStyle: glowStyle,
      edgeWidth: edgeWidth,
      edgeOpacity: edgeOpacity,
      edgeHighlightColor: edgeHighlightColor,
    );
  }

  /// Create a copy of this configuration with some properties replaced
  AsteroidVisualConfig copyWith({
    Color? primaryColor,
    Color? accentColor,
    Color? damageColor,
    Color? glowColor,
    double? baseRadius,
    double? radiusVariance,
    int? vertexCount,
    double? vertexVariance,
    int? cracksPerDamageLevel,
    int? chipsPerDamageLevel,
    double? crackLength,
    double? crackWidth,
    double? chipSize,
    double? crackOpacity,
    double? chipOpacity,
    int? craterCount,
    double? craterSize,
    double? craterSizeVariance,
    double? craterOpacity,
    double? craterEccentricity,
    double? glowRadius,
    double? glowOpacity,
    BlurStyle? glowStyle,
    double? edgeWidth,
    double? edgeOpacity,
    Color? edgeHighlightColor,
  }) {
    return AsteroidVisualConfig(
      primaryColor: primaryColor ?? this.primaryColor,
      accentColor: accentColor ?? this.accentColor,
      damageColor: damageColor ?? this.damageColor,
      glowColor: glowColor ?? this.glowColor,
      baseRadius: baseRadius ?? this.baseRadius,
      radiusVariance: radiusVariance ?? this.radiusVariance,
      vertexCount: vertexCount ?? this.vertexCount,
      vertexVariance: vertexVariance ?? this.vertexVariance,
      cracksPerDamageLevel: cracksPerDamageLevel ?? this.cracksPerDamageLevel,
      chipsPerDamageLevel: chipsPerDamageLevel ?? this.chipsPerDamageLevel,
      crackLength: crackLength ?? this.crackLength,
      crackWidth: crackWidth ?? this.crackWidth,
      chipSize: chipSize ?? this.chipSize,
      crackOpacity: crackOpacity ?? this.crackOpacity,
      chipOpacity: chipOpacity ?? this.chipOpacity,
      craterCount: craterCount ?? this.craterCount,
      craterSize: craterSize ?? this.craterSize,
      craterSizeVariance: craterSizeVariance ?? this.craterSizeVariance,
      craterOpacity: craterOpacity ?? this.craterOpacity,
      craterEccentricity: craterEccentricity ?? this.craterEccentricity,
      glowRadius: glowRadius ?? this.glowRadius,
      glowOpacity: glowOpacity ?? this.glowOpacity,
      glowStyle: glowStyle ?? this.glowStyle,
      edgeWidth: edgeWidth ?? this.edgeWidth,
      edgeOpacity: edgeOpacity ?? this.edgeOpacity,
      edgeHighlightColor: edgeHighlightColor ?? this.edgeHighlightColor,
    );
  }
}
