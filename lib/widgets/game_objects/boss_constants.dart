import 'package:flutter/material.dart';

/// Visual constants for the boss widget and its components
class BossConstants {
  // Size constants
  static const double defaultSize = 200.0;
  static const double shieldRadius = 0.6;
  static const double energyFieldRadius = 0.8;

  // Shield pattern constants
  static const double outerHexRadius = 0.5;
  static const double innerHexRadius = 0.4;
  static const int hexagonSides = 6;
  static const double hexStrokeWidth = 1.0;
  static const double hexConnectorStrokeWidth = 0.5;

  // Energy circuit constants
  static const double circuitStrokeWidth = 2.0;
  static const double circuitBlurRadius = 2.0;
  static const double nodeRadius = 3.0;
  static const double nodeBlurRadius = 4.0;

  // Body dimensions
  static const double bodyWidth = 100.0;
  static const double bodyTopOffset = 50.0;
  static const double bodyBottomOffset = 20.0;
  static const double launchPadExtension = 15.0;

  // Grid pattern
  static const double gridSpacing = 10.0;
  static const double gridStrokeWidth = 0.5;
  static const double gridVerticalExtent = 40.0;
  static const double gridHorizontalExtent = 100.0;

  // Colors and opacities
  static const List<double> shieldOpacities = [0.0, 0.15, 0.25, 0.1];
  static const List<double> shieldStops = [0.0, 0.3, 0.6, 1.0];
  static const double baseOverlayOpacity = 0.3;
  static const double energyFieldOpacity = 0.1;

  // Gradient positions
  static const Alignment energyFieldCenter = Alignment(0, -0.2);
  static const double shieldGradientRadius = 1.2;

  // Launch pad detail constants
  static const double launchPadStrokeWidth = 2.0;
  static const double launchPadOffset = 90.0;
  static const double launchPadDepth = 10.0;
}
