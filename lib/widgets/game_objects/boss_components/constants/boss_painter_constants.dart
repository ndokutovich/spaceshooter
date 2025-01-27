/// Constants for boss component painters
class BossPainterConstants {
  // Shield constants
  static const double shieldRadius = 0.6;
  static const double shieldGlowRadius = 1.2;
  static const double innerHexagonScale = 0.4;
  static const double outerHexagonScale = 0.5;
  static const double hexagonStrokeWidth = 1.0;
  static const double hexagonConnectorStrokeWidth = 0.5;

  // Body constants
  static const double bodyWidth = 200.0;
  static const double bodyHeight = 100.0;
  static const double gridSpacing = 10.0;
  static const double edgeStrokeWidth = 2.0;
  static const double innerEdgeOffset = -2.0;
  static const double directionIndicatorSize = 30.0;

  // Launch pad constants
  static const double padScale = 0.4;
  static const double gridDensity = 0.1;
  static const double padEdgeStrokeWidth = 1.5;
  static const double arcLength = 0.25;
  static const double arcSpacing = 0.3;
  static const double chargeEffectRadius = 0.8;

  // Energy circuit constants
  static const double circuitStrokeWidth = 2.0;
  static const double nodeRadius = 3.0;
  static const double pulseRadius = 8.0;
  static const double flowOpacity = 0.8;
  static const double nodeOpacity = 0.5;

  // Core constants
  static const double coreScale = 0.3;
  static const double coreGlowRadius = 1.5;
  static const double ringSpacing = 0.2;
  static const int nodeCount = 8;
  static const double nodeSize = 4.0;
  static const double highlightRadius = 0.4;
  static const double ringStrokeWidth = 2.0;

  // Health bar constants
  static const double barWidth = 0.8;
  static const double barHeight = 0.15;
  static const double cornerRadius = 4.0;
  static const int segmentCount = 10;
  static const double fontSize = 12.0;
  static const double barStrokeWidth = 1.5;
  static const double patternSpacing = 10.0;

  // Gradient stops
  static const List<double> defaultGradientStops = [0.0, 0.5, 1.0];
  static const List<double> shieldGradientStops = [0.0, 0.3, 0.6, 1.0];
  static const List<double> energyGradientStops = [0.0, 1.0];

  // Opacity values
  static const double baseOpacity = 1.0;
  static const double lowOpacity = 0.3;
  static const double mediumOpacity = 0.5;
  static const double highOpacity = 0.8;

  // Glow settings
  static const double defaultGlowIntensity = 15.0;
  static const double energyGlowIntensity = 10.0;
  static const double shieldGlowIntensity = 20.0;

  // Animation durations (in seconds)
  static const double pulseAnimationDuration = 2.0;
  static const double chargeAnimationDuration = 1.5;
  static const double rotationAnimationDuration = 3.0;

  // Private constructor to prevent instantiation
  const BossPainterConstants._();
}
