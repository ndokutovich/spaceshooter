import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../base_game_painter.dart';

class BossShieldPainter extends BaseGamePainter {
  const BossShieldPainter({
    super.color = Colors.purple,
    super.opacity = 1.0,
    super.enableGlow = true,
    super.glowIntensity = 15.0,
    super.glowStyle = BlurStyle.outer,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);

    // Draw outer energy shield with enhanced hexagonal pattern
    final shieldPaint = Paint()
      ..shader = RadialGradient(
        center: const Alignment(0, 0),
        radius: 1.2,
        colors: [
          color.withOpacity(0.0),
          color.withOpacity(0.15),
          color.withOpacity(0.25),
          color.withOpacity(0.1),
        ],
        stops: const [0.0, 0.3, 0.6, 1.0],
      ).createShader(Rect.fromCenter(
        center: center,
        width: size.width * 1.2,
        height: size.height * 1.2,
      ))
      ..maskFilter = MaskFilter.blur(glowStyle, glowIntensity);

    canvas.drawCircle(center, size.width * 0.6, shieldPaint);

    // Enhanced hexagonal shield pattern with double lines
    final hexPaint = Paint()
      ..color = color.withOpacity(0.1)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    final innerHexPaint = Paint()
      ..color = color.withOpacity(0.15)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    for (var i = 0; i < 6; i++) {
      final angle = i * math.pi / 3;
      final x = center.dx + math.cos(angle) * size.width * 0.5;
      final y = center.dy + math.sin(angle) * size.width * 0.5;
      final nextAngle = (i + 1) * math.pi / 3;
      final nextX = center.dx + math.cos(nextAngle) * size.width * 0.5;
      final nextY = center.dy + math.sin(nextAngle) * size.width * 0.5;

      // Outer hex
      canvas.drawLine(Offset(x, y), Offset(nextX, nextY), hexPaint);

      // Inner hex
      final innerX = center.dx + math.cos(angle) * size.width * 0.4;
      final innerY = center.dy + math.sin(angle) * size.width * 0.4;
      final nextInnerX = center.dx + math.cos(nextAngle) * size.width * 0.4;
      final nextInnerY = center.dy + math.sin(nextAngle) * size.width * 0.4;
      canvas.drawLine(
        Offset(innerX, innerY),
        Offset(nextInnerX, nextInnerY),
        innerHexPaint,
      );

      // Connect inner and outer hex
      if (i % 2 == 0) {
        canvas.drawLine(
          Offset(x, y),
          Offset(innerX, innerY),
          hexPaint..strokeWidth = 0.5,
        );
      }
    }
  }

  @override
  bool shouldRepaint(BossShieldPainter oldDelegate) =>
      super.shouldRepaint(oldDelegate);
}
