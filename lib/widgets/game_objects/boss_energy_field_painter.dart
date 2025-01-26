import 'package:flutter/material.dart';
import 'boss_component_painter.dart';

/// Painter for the boss's background energy field
class BossEnergyFieldPainter extends BossComponentPainter {
  BossEnergyFieldPainter({
    required super.config,
    required super.healthPercentage,
    required super.isMovingRight,
    required super.isAiming,
  });

  @override
  void paintComponent(Canvas canvas, Size size, Offset center) {
    final energyFieldPaint = Paint()
      ..shader = getEnergyFieldShader(size, config.energyField, center);

    canvas.drawRect(
      Rect.fromLTWH(0, 0, size.width, size.height),
      energyFieldPaint,
    );
  }
} 