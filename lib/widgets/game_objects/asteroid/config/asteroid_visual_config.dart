import 'package:flutter/material.dart';

/// Configuration for asteroid visual properties
class AsteroidVisualConfig {
  // Base colors
  final Color primaryColor;
  final Color accentColor;
  final Color damageColor;
  final Color highlightColor;

  // Shape properties
  final double baseRadius;
  final double vertexVariance;
  final int vertexCount;

  // Damage effects
  final int cracksPerDamageLevel;
  final int chipsPerDamageLevel;
  final double crackLength;
  final double crackWidth;
  final double crackOpacity;
  final double chipSize;
  final double chipOpacity;

  // Surface details
  final int craterCount;
  final double craterSize;
  final double craterOpacity;
  final double craterEccentricity;

  // Glow effects
  final double glowRadius;
  final double glowOpacity;
  final BlurStyle glowStyle;

  // Edge highlights
  final double edgeHighlightWidth;
  final double edgeHighlightOpacity;

  const AsteroidVisualConfig({
    this.primaryColor = const Color(0xFF8B4513), // Saddle brown
    this.accentColor = const Color(0xFFD2691E), // Chocolate
    this.damageColor = Colors.black,
    this.highlightColor = Colors.white,
    this.baseRadius = 0.4,
    this.vertexVariance = 0.2,
    this.vertexCount = 8,
    this.cracksPerDamageLevel = 3,
    this.chipsPerDamageLevel = 2,
    this.crackLength = 0.3,
    this.crackWidth = 2.0,
    this.crackOpacity = 0.7,
    this.chipSize = 0.15,
    this.chipOpacity = 0.5,
    this.craterCount = 3,
    this.craterSize = 0.2,
    this.craterOpacity = 0.6,
    this.craterEccentricity = 0.8,
    this.glowRadius = 3.0,
    this.glowOpacity = 0.3,
    this.glowStyle = BlurStyle.outer,
    this.edgeHighlightWidth = 2.0,
    this.edgeHighlightOpacity = 0.3,
  });

  /// Create a damaged version of the configuration based on health
  AsteroidVisualConfig withDamage(int health, {int maxHealth = 3}) {
    final damageRatio = 1 - (health / maxHealth);
    return AsteroidVisualConfig(
      primaryColor: Color.lerp(primaryColor, damageColor, damageRatio)!,
      accentColor: Color.lerp(accentColor, damageColor, damageRatio)!,
      damageColor: damageColor,
      highlightColor: Color.lerp(highlightColor, damageColor, damageRatio)!,
      baseRadius: baseRadius,
      vertexVariance: vertexVariance,
      vertexCount: vertexCount,
      cracksPerDamageLevel: cracksPerDamageLevel,
      chipsPerDamageLevel: chipsPerDamageLevel,
      crackLength: crackLength,
      crackWidth: crackWidth,
      crackOpacity: crackOpacity + (damageRatio * 0.2),
      chipSize: chipSize,
      chipOpacity: chipOpacity + (damageRatio * 0.2),
      craterCount: craterCount,
      craterSize: craterSize,
      craterOpacity: craterOpacity,
      craterEccentricity: craterEccentricity,
      glowRadius: glowRadius + (damageRatio * 2),
      glowOpacity: glowOpacity + (damageRatio * 0.2),
      glowStyle: glowStyle,
      edgeHighlightWidth: edgeHighlightWidth,
      edgeHighlightOpacity: edgeHighlightOpacity,
    );
  }

  /// Create a copy of this configuration with some properties replaced
  AsteroidVisualConfig copyWith({
    Color? primaryColor,
    Color? accentColor,
    Color? damageColor,
    Color? highlightColor,
    double? baseRadius,
    double? vertexVariance,
    int? vertexCount,
    int? cracksPerDamageLevel,
    int? chipsPerDamageLevel,
    double? crackLength,
    double? crackWidth,
    double? crackOpacity,
    double? chipSize,
    double? chipOpacity,
    int? craterCount,
    double? craterSize,
    double? craterOpacity,
    double? craterEccentricity,
    double? glowRadius,
    double? glowOpacity,
    BlurStyle? glowStyle,
    double? edgeHighlightWidth,
    double? edgeHighlightOpacity,
  }) {
    return AsteroidVisualConfig(
      primaryColor: primaryColor ?? this.primaryColor,
      accentColor: accentColor ?? this.accentColor,
      damageColor: damageColor ?? this.damageColor,
      highlightColor: highlightColor ?? this.highlightColor,
      baseRadius: baseRadius ?? this.baseRadius,
      vertexVariance: vertexVariance ?? this.vertexVariance,
      vertexCount: vertexCount ?? this.vertexCount,
      cracksPerDamageLevel: cracksPerDamageLevel ?? this.cracksPerDamageLevel,
      chipsPerDamageLevel: chipsPerDamageLevel ?? this.chipsPerDamageLevel,
      crackLength: crackLength ?? this.crackLength,
      crackWidth: crackWidth ?? this.crackWidth,
      crackOpacity: crackOpacity ?? this.crackOpacity,
      chipSize: chipSize ?? this.chipSize,
      chipOpacity: chipOpacity ?? this.chipOpacity,
      craterCount: craterCount ?? this.craterCount,
      craterSize: craterSize ?? this.craterSize,
      craterOpacity: craterOpacity ?? this.craterOpacity,
      craterEccentricity: craterEccentricity ?? this.craterEccentricity,
      glowRadius: glowRadius ?? this.glowRadius,
      glowOpacity: glowOpacity ?? this.glowOpacity,
      glowStyle: glowStyle ?? this.glowStyle,
      edgeHighlightWidth: edgeHighlightWidth ?? this.edgeHighlightWidth,
      edgeHighlightOpacity: edgeHighlightOpacity ?? this.edgeHighlightOpacity,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AsteroidVisualConfig &&
          runtimeType == other.runtimeType &&
          primaryColor == other.primaryColor &&
          accentColor == other.accentColor &&
          damageColor == other.damageColor &&
          highlightColor == other.highlightColor &&
          baseRadius == other.baseRadius &&
          vertexVariance == other.vertexVariance &&
          vertexCount == other.vertexCount &&
          cracksPerDamageLevel == other.cracksPerDamageLevel &&
          chipsPerDamageLevel == other.chipsPerDamageLevel &&
          crackLength == other.crackLength &&
          crackWidth == other.crackWidth &&
          crackOpacity == other.crackOpacity &&
          chipSize == other.chipSize &&
          chipOpacity == other.chipOpacity &&
          craterCount == other.craterCount &&
          craterSize == other.craterSize &&
          craterOpacity == other.craterOpacity &&
          craterEccentricity == other.craterEccentricity &&
          glowRadius == other.glowRadius &&
          glowOpacity == other.glowOpacity &&
          glowStyle == other.glowStyle &&
          edgeHighlightWidth == other.edgeHighlightWidth &&
          edgeHighlightOpacity == other.edgeHighlightOpacity;

  @override
  int get hashCode =>
      primaryColor.hashCode ^
      accentColor.hashCode ^
      damageColor.hashCode ^
      highlightColor.hashCode ^
      baseRadius.hashCode ^
      vertexVariance.hashCode ^
      vertexCount.hashCode ^
      cracksPerDamageLevel.hashCode ^
      chipsPerDamageLevel.hashCode ^
      crackLength.hashCode ^
      crackWidth.hashCode ^
      crackOpacity.hashCode ^
      chipSize.hashCode ^
      chipOpacity.hashCode ^
      craterCount.hashCode ^
      craterSize.hashCode ^
      craterOpacity.hashCode ^
      craterEccentricity.hashCode ^
      glowRadius.hashCode ^
      glowOpacity.hashCode ^
      glowStyle.hashCode ^
      edgeHighlightWidth.hashCode ^
      edgeHighlightOpacity.hashCode;
}
