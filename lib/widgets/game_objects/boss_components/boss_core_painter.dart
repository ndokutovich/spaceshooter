import 'dart:math';
import 'package:flutter/material.dart';
import '../base_game_painter.dart';

class BossCorePainter extends BaseGamePainter {
  final double coreEnergy;
  final double rotationAngle;
  late final MaterialColor _materialColor;

  BossCorePainter({
    required this.coreEnergy,
    required this.rotationAngle,
    Color color = Colors.purple,
    super.opacity = 1.0,
    super.enableGlow = true,
    super.glowIntensity = 15.0,
    super.glowStyle = BlurStyle.outer,
  }) : super(color: color) {
    // Convert color to MaterialColor if it isn't already
    _materialColor = color is MaterialColor
        ? color
        : Colors.purple; // Fallback to purple if not a MaterialColor
  }

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width * 0.3;

    // Draw core background glow
    final glowPaint = Paint()
      ..shader = RadialGradient(
        center: const Alignment(0, 0),
        radius: 1.2,
        colors: [
          _materialColor.shade300.withOpacity(0.5 * coreEnergy),
          Colors.transparent,
        ],
      ).createShader(Rect.fromCenter(
        center: center,
        width: size.width,
        height: size.height,
      ));

    canvas.drawCircle(center, radius * 1.5, glowPaint);

    // Draw core base
    final corePaint = Paint()
      ..shader = RadialGradient(
        center: const Alignment(-0.2, -0.2),
        radius: 1.0,
        colors: [
          _materialColor.shade300,
          _materialColor.shade500,
          _materialColor.shade700,
        ],
      ).createShader(Rect.fromCenter(
        center: center,
        width: radius * 2,
        height: radius * 2,
      ));

    canvas.drawCircle(center, radius, corePaint);

    // Draw rotating energy rings
    canvas.save();
    canvas.translate(center.dx, center.dy);
    canvas.rotate(rotationAngle);

    final ringPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    // Inner ring
    final innerRingGradient = SweepGradient(
      colors: [
        _materialColor.shade300.withOpacity(0.8 * coreEnergy),
        _materialColor.shade300.withOpacity(0.2 * coreEnergy),
      ],
      stops: const [0.0, 1.0],
    );

    ringPaint.shader = innerRingGradient.createShader(
      Rect.fromCircle(center: Offset.zero, radius: radius * 0.6),
    );

    canvas.drawCircle(Offset.zero, radius * 0.6, ringPaint);

    // Middle ring
    final middleRingGradient = SweepGradient(
      colors: [
        _materialColor.shade400.withOpacity(0.7 * coreEnergy),
        _materialColor.shade400.withOpacity(0.1 * coreEnergy),
      ],
      stops: const [0.0, 1.0],
    );

    ringPaint.shader = middleRingGradient.createShader(
      Rect.fromCircle(center: Offset.zero, radius: radius * 0.8),
    );

    canvas.drawCircle(Offset.zero, radius * 0.8, ringPaint);

    // Outer ring
    final outerRingGradient = SweepGradient(
      colors: [
        _materialColor.shade500.withOpacity(0.6 * coreEnergy),
        _materialColor.shade500.withOpacity(0.1 * coreEnergy),
      ],
      stops: const [0.0, 1.0],
    );

    ringPaint.shader = outerRingGradient.createShader(
      Rect.fromCircle(center: Offset.zero, radius: radius),
    );

    canvas.drawCircle(Offset.zero, radius, ringPaint);

    // Draw energy nodes
    final nodePaint = Paint()
      ..color = _materialColor.shade200.withOpacity(coreEnergy);

    for (var i = 0; i < 8; i++) {
      final angle = i * pi / 4;
      final nodeRadius = radius * 0.8;
      final x = cos(angle) * nodeRadius;
      final y = sin(angle) * nodeRadius;
      canvas.drawCircle(Offset(x, y), 4.0, nodePaint);
    }

    canvas.restore();

    // Draw core highlight
    final highlightPaint = Paint()
      ..shader = RadialGradient(
        center: const Alignment(-0.3, -0.3),
        radius: 0.5,
        colors: [
          _materialColor.shade200.withOpacity(0.8 * coreEnergy),
          Colors.transparent,
        ],
      ).createShader(Rect.fromCenter(
        center: center,
        width: radius * 2,
        height: radius * 2,
      ));

    canvas.drawCircle(center, radius * 0.4, highlightPaint);
  }

  @override
  bool shouldRepaint(BossCorePainter oldDelegate) =>
      coreEnergy != oldDelegate.coreEnergy ||
      rotationAngle != oldDelegate.rotationAngle ||
      super.shouldRepaint(oldDelegate);
}
