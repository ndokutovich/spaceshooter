import 'package:flutter/material.dart';
import 'boss_constants.dart';

/// Configuration for the boss shield effect
class BossShieldConfig {
  final double radius;
  final double gradientRadius;
  final List<double> opacities;
  final List<double> stops;
  final Color color;
  final bool useGlow;
  final double glowIntensity;

  const BossShieldConfig({
    this.radius = BossConstants.shieldRadius,
    this.gradientRadius = BossConstants.shieldGradientRadius,
    this.opacities = BossConstants.shieldOpacities,
    this.stops = BossConstants.shieldStops,
    this.color = Colors.purple,
    this.useGlow = true,
    this.glowIntensity = 15.0,
  });

  List<Color> get gradientColors =>
      opacities.map((o) => color.withOpacity(o)).toList();
}

/// Configuration for the hexagonal shield pattern
class BossHexPatternConfig {
  final double outerRadius;
  final double innerRadius;
  final int sides;
  final double strokeWidth;
  final double connectorStrokeWidth;
  final Color color;
  final double opacity;

  const BossHexPatternConfig({
    this.outerRadius = BossConstants.outerHexRadius,
    this.innerRadius = BossConstants.innerHexRadius,
    this.sides = BossConstants.hexagonSides,
    this.strokeWidth = BossConstants.hexStrokeWidth,
    this.connectorStrokeWidth = BossConstants.hexConnectorStrokeWidth,
    this.color = Colors.purple,
    this.opacity = 0.1,
  });
}

/// Configuration for the boss body
class BossBodyConfig {
  final double width;
  final double topOffset;
  final double bottomOffset;
  final Color baseColor;
  final List<Color> gradientColors;
  final List<double> gradientStops;
  final bool useMetallicEffect;

  const BossBodyConfig({
    this.width = BossConstants.bodyWidth,
    this.topOffset = BossConstants.bodyTopOffset,
    this.bottomOffset = BossConstants.bodyBottomOffset,
    this.baseColor = Colors.purple,
    this.gradientColors = const [
      Color(0xFF4A148C), // purple.shade900
      Color(0xFF6A1B9A), // purple.shade800
      Color(0xFF4A148C), // purple.shade900
    ],
    this.gradientStops = const [0.0, 0.5, 1.0],
    this.useMetallicEffect = true,
  });
}

/// Configuration for the energy field effect
class BossEnergyFieldConfig {
  final double radius;
  final Alignment center;
  final Color color;
  final double opacity;

  const BossEnergyFieldConfig({
    this.radius = BossConstants.energyFieldRadius,
    this.center = BossConstants.energyFieldCenter,
    this.color = Colors.purple,
    this.opacity = BossConstants.energyFieldOpacity,
  });
}

/// Configuration for the grid overlay pattern
class BossGridConfig {
  final double spacing;
  final double strokeWidth;
  final double verticalExtent;
  final double horizontalExtent;
  final Color color;
  final double opacity;

  const BossGridConfig({
    this.spacing = BossConstants.gridSpacing,
    this.strokeWidth = BossConstants.gridStrokeWidth,
    this.verticalExtent = BossConstants.gridVerticalExtent,
    this.horizontalExtent = BossConstants.gridHorizontalExtent,
    this.color = Colors.purple,
    this.opacity = BossConstants.baseOverlayOpacity,
  });
}

/// Configuration for the launch pad details
class BossLaunchPadConfig {
  final double extension;
  final double strokeWidth;
  final double offset;
  final double depth;
  final Color color;

  const BossLaunchPadConfig({
    this.extension = BossConstants.launchPadExtension,
    this.strokeWidth = BossConstants.launchPadStrokeWidth,
    this.offset = BossConstants.launchPadOffset,
    this.depth = BossConstants.launchPadDepth,
    this.color = Colors.purple,
  });
}

/// Combined configuration for all boss visual components
class BossConfig {
  final BossShieldConfig shield;
  final BossHexPatternConfig hexPattern;
  final BossBodyConfig body;
  final BossEnergyFieldConfig energyField;
  final BossGridConfig grid;
  final BossLaunchPadConfig launchPad;

  const BossConfig({
    this.shield = const BossShieldConfig(),
    this.hexPattern = const BossHexPatternConfig(),
    this.body = const BossBodyConfig(),
    this.energyField = const BossEnergyFieldConfig(),
    this.grid = const BossGridConfig(),
    this.launchPad = const BossLaunchPadConfig(),
  });
}
