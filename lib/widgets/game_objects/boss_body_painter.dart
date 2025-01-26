import 'package:flutter/material.dart';
import 'boss_component_painter.dart';

/// Painter for the boss's main body and grid overlay
class BossBodyPainter extends BossComponentPainter {
  BossBodyPainter({
    required super.config,
    required super.healthPercentage,
    required super.isMovingRight,
    required super.isAiming,
  });

  @override
  void paintComponent(Canvas canvas, Size size, Offset center) {
    final bodyPath = getBodyPath(size, config.body, center);
    
    // Draw base layer with metallic effect
    final bodyPaint = Paint()
      ..shader = getBodyShader(size, config.body, center)
      ..style = PaintingStyle.fill;

    canvas.drawPath(bodyPath, bodyPaint);

    // Draw grid overlay pattern
    final gridConfig = config.grid;
    final overlayPaint = createPaint(
      overrideOpacity: gridConfig.opacity,
      style: PaintingStyle.stroke,
      strokeWidth: gridConfig.strokeWidth,
    );

    // Draw horizontal lines
    for (var i = -gridConfig.verticalExtent;
        i <= gridConfig.verticalExtent;
        i += gridConfig.spacing) {
      canvas.drawLine(
        Offset(center.dx - gridConfig.horizontalExtent, center.dy + i),
        Offset(center.dx + gridConfig.horizontalExtent, center.dy + i),
        overlayPaint,
      );
    }

    // Draw vertical lines
    for (var i = -gridConfig.horizontalExtent;
        i <= gridConfig.horizontalExtent;
        i += gridConfig.spacing) {
      canvas.drawLine(
        Offset(center.dx + i, center.dy - gridConfig.verticalExtent),
        Offset(center.dx + i, center.dy + gridConfig.verticalExtent),
        overlayPaint,
      );
    }
  }
} 