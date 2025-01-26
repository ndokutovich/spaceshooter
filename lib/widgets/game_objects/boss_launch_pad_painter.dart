import 'package:flutter/material.dart';
import 'boss_component_painter.dart';

/// Painter for the boss's launch pad details
class BossLaunchPadPainter extends BossComponentPainter {
  BossLaunchPadPainter({
    required super.config,
    required super.healthPercentage,
    required super.isMovingRight,
    required super.isAiming,
  });

  @override
  void paintComponent(Canvas canvas, Size size, Offset center) {
    final paths = getLaunchPadPaths(size, config.launchPad, center);

    final launchPadPaint = createPaint(
      style: PaintingStyle.stroke,
      strokeWidth: config.launchPad.strokeWidth,
    );

    // Draw left and right launch pads
    for (final path in paths) {
      canvas.drawPath(path, launchPadPaint);
    }
  }
}
