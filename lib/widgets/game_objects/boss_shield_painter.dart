import 'package:flutter/material.dart';
import 'boss_component_painter.dart';

/// Painter for the boss's energy shield and hexagonal pattern
class BossShieldPainter extends BossComponentPainter {
  BossShieldPainter({
    required super.config,
    required super.healthPercentage,
    required super.isMovingRight,
    required super.isAiming,
  }) : super(
          useGlow: true,
          glowIntensity: 15.0,
        );

  @override
  void paintComponent(Canvas canvas, Size size, Offset center) {
    // Draw outer energy shield
    final shieldPaint = Paint()
      ..shader = getShieldShader(size, config.shield, center)
      ..maskFilter = MaskFilter.blur(BlurStyle.outer, config.shield.glowIntensity);

    canvas.drawCircle(center, size.width * config.shield.radius, shieldPaint);

    // Draw hexagonal shield pattern
    final hexConfig = config.hexPattern;
    final paths = getHexPaths(size, hexConfig, center);
    
    // Draw outer hex
    final hexPaint = createPaint(
      overrideOpacity: hexConfig.opacity,
      style: PaintingStyle.stroke,
      strokeWidth: hexConfig.strokeWidth,
    );
    canvas.drawPath(paths[0], hexPaint);
    
    // Draw inner hex
    final innerHexPaint = createPaint(
      overrideOpacity: hexConfig.opacity * 1.5,
      style: PaintingStyle.stroke,
      strokeWidth: hexConfig.strokeWidth,
    );
    canvas.drawPath(paths[1], innerHexPaint);
    
    // Draw connectors
    final connectorPaint = createPaint(
      overrideOpacity: hexConfig.opacity,
      style: PaintingStyle.stroke,
      strokeWidth: hexConfig.connectorStrokeWidth,
    );
    for (var i = 2; i < paths.length; i++) {
      canvas.drawPath(paths[i], connectorPaint);
    }
  }
} 