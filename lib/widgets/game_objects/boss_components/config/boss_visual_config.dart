import 'package:flutter/material.dart';

/// Base configuration class for boss visual properties
abstract class BossVisualConfig {
  final Color color;
  final double opacity;
  final bool enableGlow;
  final double glowIntensity;
  final BlurStyle glowStyle;

  const BossVisualConfig({
    required this.color,
    this.opacity = 1.0,
    this.enableGlow = true,
    this.glowIntensity = 15.0,
    this.glowStyle = BlurStyle.outer,
  });
}

/// Configuration for boss shield visual properties
class BossShieldConfig extends BossVisualConfig {
  final double hexagonalPatternScale;
  final double innerHexagonScale;
  final double shieldOpacity;
  final double patternOpacity;

  const BossShieldConfig({
    required super.color,
    super.opacity,
    super.enableGlow,
    super.glowIntensity,
    super.glowStyle,
    this.hexagonalPatternScale = 0.5,
    this.innerHexagonScale = 0.4,
    this.shieldOpacity = 0.25,
    this.patternOpacity = 0.15,
  });
}

/// Configuration for boss body visual properties
class BossBodyConfig extends BossVisualConfig {
  final double bodyScale;
  final double gridSpacing;
  final double gridOpacity;
  final double edgeHighlightWidth;
  final double innerHighlightOffset;

  const BossBodyConfig({
    required super.color,
    super.opacity,
    super.enableGlow,
    super.glowIntensity,
    super.glowStyle,
    this.bodyScale = 1.0,
    this.gridSpacing = 10.0,
    this.gridOpacity = 0.3,
    this.edgeHighlightWidth = 2.0,
    this.innerHighlightOffset = -2.0,
  });
}

/// Configuration for boss launch pad visual properties
class BossLaunchPadConfig extends BossVisualConfig {
  final double padScale;
  final double gridDensity;
  final double chargeEffectRadius;
  final double arcSpacing;
  final double arcLength;

  const BossLaunchPadConfig({
    required super.color,
    super.opacity,
    super.enableGlow,
    super.glowIntensity,
    super.glowStyle,
    this.padScale = 0.4,
    this.gridDensity = 0.1,
    this.chargeEffectRadius = 0.8,
    this.arcSpacing = 0.3,
    this.arcLength = 0.25,
  });
}

/// Configuration for boss energy circuit visual properties
class BossEnergyCircuitConfig extends BossVisualConfig {
  final double lineWidth;
  final double nodeRadius;
  final double pulseRadius;
  final double flowOpacity;
  final double nodeOpacity;

  const BossEnergyCircuitConfig({
    required super.color,
    super.opacity,
    super.enableGlow,
    super.glowIntensity,
    super.glowStyle,
    this.lineWidth = 2.0,
    this.nodeRadius = 3.0,
    this.pulseRadius = 8.0,
    this.flowOpacity = 0.8,
    this.nodeOpacity = 0.5,
  });
}

/// Configuration for boss core visual properties
class BossCoreConfig extends BossVisualConfig {
  final double coreScale;
  final double ringSpacing;
  final double nodeCount;
  final double nodeSize;
  final double highlightRadius;

  const BossCoreConfig({
    required super.color,
    super.opacity,
    super.enableGlow,
    super.glowIntensity,
    super.glowStyle,
    this.coreScale = 0.3,
    this.ringSpacing = 0.2,
    this.nodeCount = 8.0,
    this.nodeSize = 4.0,
    this.highlightRadius = 0.4,
  });
}

/// Configuration for boss health bar visual properties
class BossHealthBarConfig extends BossVisualConfig {
  final double barWidth;
  final double barHeight;
  final double cornerRadius;
  final double segmentCount;
  final double fontSize;

  const BossHealthBarConfig({
    required super.color,
    super.opacity,
    super.enableGlow,
    super.glowIntensity,
    super.glowStyle,
    this.barWidth = 0.8,
    this.barHeight = 0.15,
    this.cornerRadius = 4.0,
    this.segmentCount = 10.0,
    this.fontSize = 12.0,
  });
}
