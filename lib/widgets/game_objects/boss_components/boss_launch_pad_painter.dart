import 'dart:math';

import 'package:flutter/material.dart';

import '../base_game_painter.dart';

class BossLaunchPadPainter extends BaseGamePainter {
  final bool isActive;
  final double chargeProgress;
  late final MaterialColor _materialColor;

  BossLaunchPadPainter({
    required this.isActive,
    required this.chargeProgress,
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
    final radius = size.width * 0.4;

    // Draw launch pad base
    final basePath = Path()
      ..moveTo(center.dx - radius * 0.8, center.dy - radius * 0.2)
      ..lineTo(center.dx - radius * 0.6, center.dy - radius * 0.4)
      ..lineTo(center.dx + radius * 0.6, center.dy - radius * 0.4)
      ..lineTo(center.dx + radius * 0.8, center.dy - radius * 0.2)
      ..lineTo(center.dx + radius * 0.8, center.dy + radius * 0.2)
      ..lineTo(center.dx + radius * 0.6, center.dy + radius * 0.4)
      ..lineTo(center.dx - radius * 0.6, center.dy + radius * 0.4)
      ..lineTo(center.dx - radius * 0.8, center.dy + radius * 0.2)
      ..close();

    // Draw base with metallic effect
    final baseGradient = LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        _materialColor.shade800,
        _materialColor.shade700,
        _materialColor.shade800,
      ],
      stops: const [0.0, 0.5, 1.0],
    );

    canvas.drawPath(
      basePath,
      Paint()
        ..shader = baseGradient.createShader(
          Rect.fromCenter(
            center: center,
            width: size.width,
            height: size.height,
          ),
        )
        ..style = PaintingStyle.fill,
    );

    // Draw grid pattern
    final gridPaint = Paint()
      ..color = _materialColor.shade900.withOpacity(0.3)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.5;

    // Horizontal grid lines
    for (var i = -0.4; i <= 0.4; i += 0.1) {
      canvas.drawLine(
        Offset(center.dx - radius * 0.7, center.dy + radius * i),
        Offset(center.dx + radius * 0.7, center.dy + radius * i),
        gridPaint,
      );
    }

    // Vertical grid lines
    for (var i = -0.7; i <= 0.7; i += 0.1) {
      canvas.drawLine(
        Offset(center.dx + radius * i, center.dy - radius * 0.35),
        Offset(center.dx + radius * i, center.dy + radius * 0.35),
        gridPaint,
      );
    }

    // Draw edge highlights
    final edgePaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          _materialColor.shade300,
          _materialColor.shade400,
          _materialColor.shade300,
        ],
      ).createShader(Rect.fromLTRB(0, 0, size.width, size.height))
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;
    canvas.drawPath(basePath, edgePaint);

    if (isActive) {
      // Draw charging effect
      final chargePaint = Paint()
        ..shader = RadialGradient(
          center: const Alignment(0, 0),
          radius: 0.8,
          colors: [
            _materialColor.shade300.withOpacity(0.8 * chargeProgress),
            _materialColor.shade500.withOpacity(0.5 * chargeProgress),
            Colors.transparent,
          ],
        ).createShader(Rect.fromCenter(
          center: center,
          width: size.width,
          height: size.height,
        ));

      canvas.drawPath(basePath, chargePaint);

      // Draw energy arcs
      final arcPaint = Paint()
        ..color = _materialColor.shade300.withOpacity(0.8 * chargeProgress)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2.0;

      for (var i = 0; i < 4; i++) {
        final angle = (i * pi / 2) + (chargeProgress * pi);
        canvas.drawArc(
          Rect.fromCenter(
            center: center,
            width: radius * 1.2,
            height: radius * 1.2,
          ),
          angle,
          pi / 4,
          false,
          arcPaint,
        );
      }
    }
  }

  @override
  bool shouldRepaint(BossLaunchPadPainter oldDelegate) =>
      isActive != oldDelegate.isActive ||
      chargeProgress != oldDelegate.chargeProgress ||
      super.shouldRepaint(oldDelegate);
}
