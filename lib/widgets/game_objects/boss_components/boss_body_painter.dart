import 'package:flutter/material.dart';

import '../base_game_painter.dart';

class BossBodyPainter extends BaseGamePainter {
  final bool isMovingRight;
  late final MaterialColor _materialColor;

  BossBodyPainter({
    required this.isMovingRight,
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

    // Draw background energy field
    final energyFieldPaint = Paint()
      ..shader = RadialGradient(
        center: const Alignment(0, -0.2),
        radius: 0.8,
        colors: [
          color.withOpacity(0.1),
          Colors.transparent,
        ],
      ).createShader(Rect.fromCenter(
        center: center,
        width: size.width,
        height: size.height,
      ));

    canvas.drawRect(
      Rect.fromLTWH(0, 0, size.width, size.height),
      energyFieldPaint,
    );

    // Draw the main body with enhanced cruiser shape
    final bodyPath = Path();
    // Main hull with more detail
    bodyPath.moveTo(center.dx - 100, center.dy + 20);
    bodyPath.lineTo(center.dx - 90, center.dy - 30);
    bodyPath.lineTo(center.dx - 70, center.dy - 35);
    bodyPath.lineTo(center.dx - 60, center.dy - 40);
    bodyPath.lineTo(center.dx - 40, center.dy - 43);
    bodyPath.lineTo(center.dx - 30, center.dy - 45);
    bodyPath.lineTo(center.dx - 15, center.dy - 48);
    bodyPath.lineTo(center.dx, center.dy - 50);
    bodyPath.lineTo(center.dx + 15, center.dy - 48);
    bodyPath.lineTo(center.dx + 30, center.dy - 45);
    bodyPath.lineTo(center.dx + 40, center.dy - 43);
    bodyPath.lineTo(center.dx + 60, center.dy - 40);
    bodyPath.lineTo(center.dx + 70, center.dy - 35);
    bodyPath.lineTo(center.dx + 90, center.dy - 30);
    bodyPath.lineTo(center.dx + 100, center.dy + 20);
    // Enhanced launch pad extensions
    bodyPath.lineTo(center.dx + 110, center.dy + 25);
    bodyPath.lineTo(center.dx + 115, center.dy + 28);
    bodyPath.lineTo(center.dx + 110, center.dy + 30);
    bodyPath.lineTo(center.dx + 90, center.dy + 35);
    bodyPath.lineTo(center.dx + 80, center.dy + 40);
    bodyPath.lineTo(center.dx + 60, center.dy + 38);
    bodyPath.lineTo(center.dx + 40, center.dy + 35);
    bodyPath.lineTo(center.dx, center.dy + 30);
    bodyPath.lineTo(center.dx - 40, center.dy + 35);
    bodyPath.lineTo(center.dx - 60, center.dy + 38);
    bodyPath.lineTo(center.dx - 80, center.dy + 40);
    bodyPath.lineTo(center.dx - 90, center.dy + 35);
    bodyPath.lineTo(center.dx - 110, center.dy + 30);
    bodyPath.lineTo(center.dx - 115, center.dy + 28);
    bodyPath.lineTo(center.dx - 110, center.dy + 25);
    bodyPath.close();

    // Draw base layer with metallic effect
    final baseGradient = LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        _materialColor.shade900,
        _materialColor.shade800,
        _materialColor.shade900,
      ],
      stops: const [0.0, 0.5, 1.0],
    );

    canvas.drawPath(
      bodyPath,
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

    // Draw overlay pattern
    final overlayPaint = Paint()
      ..color = _materialColor.shade800.withOpacity(0.3)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.5;

    // Draw horizontal lines
    for (var i = -40; i <= 40; i += 10) {
      canvas.drawLine(
        Offset(center.dx - 100, center.dy + i),
        Offset(center.dx + 100, center.dy + i),
        overlayPaint,
      );
    }

    // Draw vertical lines
    for (var i = -100; i <= 100; i += 10) {
      canvas.drawLine(
        Offset(center.dx + i, center.dy - 40),
        Offset(center.dx + i, center.dy + 40),
        overlayPaint,
      );
    }

    // Draw enhanced metallic edge details
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
      ..strokeWidth = 2;
    canvas.drawPath(bodyPath, edgePaint);

    // Draw inner edge highlight
    final innerEdgePaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          _materialColor.shade400,
          _materialColor.shade500,
          _materialColor.shade400,
        ],
      ).createShader(Rect.fromLTRB(0, 0, size.width, size.height))
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;
    canvas.drawPath(bodyPath.shift(const Offset(0, -2)), innerEdgePaint);

    // Draw direction indicator with enhanced energy trail
    final indicatorPaint = Paint()
      ..shader = LinearGradient(
        begin: isMovingRight ? Alignment.centerRight : Alignment.centerLeft,
        end: isMovingRight ? Alignment.centerLeft : Alignment.centerRight,
        colors: [
          _materialColor.shade300,
          _materialColor.shade300.withOpacity(0.0),
        ],
      ).createShader(Rect.fromCenter(
        center: center,
        width: size.width,
        height: 20,
      ));

    if (isMovingRight) {
      canvas.drawPath(
        Path()
          ..moveTo(center.dx + 90, center.dy - 15)
          ..lineTo(center.dx + 120, center.dy)
          ..lineTo(center.dx + 90, center.dy + 15)
          ..close(),
        indicatorPaint,
      );
    } else {
      canvas.drawPath(
        Path()
          ..moveTo(center.dx - 90, center.dy - 15)
          ..lineTo(center.dx - 120, center.dy)
          ..lineTo(center.dx - 90, center.dy + 15)
          ..close(),
        indicatorPaint,
      );
    }
  }

  @override
  bool shouldRepaint(BossBodyPainter oldDelegate) =>
      isMovingRight != oldDelegate.isMovingRight ||
      super.shouldRepaint(oldDelegate);
}
