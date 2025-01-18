import 'package:flutter/material.dart';
import 'dart:math' as math;
import '../game_objects.dart';

class BossWidget extends StatelessWidget {
  final double healthPercentage;
  final bool isMovingRight;
  final bool isAiming;

  const BossWidget({
    super.key,
    required this.healthPercentage,
    required this.isMovingRight,
    required this.isAiming,
  });

  @override
  Widget build(BuildContext context) {
    return GameObjectWidget(
      painter: BossPainter(
        healthPercentage: healthPercentage,
        isMovingRight: isMovingRight,
        isAiming: isAiming,
      ),
      size: 200,
    );
  }
}

class BossPainter extends CustomPainter {
  final double healthPercentage;
  final bool isMovingRight;
  final bool isAiming;

  BossPainter({
    required this.healthPercentage,
    required this.isMovingRight,
    required this.isAiming,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);

    // Draw the main body
    final bodyPath = Path();
    bodyPath.moveTo(center.dx - 80, center.dy);
    bodyPath.lineTo(center.dx - 100, center.dy - 30);
    bodyPath.lineTo(center.dx + 100, center.dy - 30);
    bodyPath.lineTo(center.dx + 80, center.dy);
    bodyPath.lineTo(center.dx + 100, center.dy + 30);
    bodyPath.lineTo(center.dx - 100, center.dy + 30);
    bodyPath.close();

    final bodyGradient = LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        Colors.purple.shade800,
        Colors.purple.shade500,
        Colors.purple.shade800,
      ],
    );

    final bodyPaint = Paint()
      ..shader = bodyGradient.createShader(
        Rect.fromCenter(
          center: center,
          width: size.width,
          height: size.height,
        ),
      )
      ..style = PaintingStyle.fill;

    canvas.drawPath(bodyPath, bodyPaint);

    // Draw energy core
    final corePaint = Paint()
      ..color = isAiming ? Colors.red : Colors.purple
      ..style = PaintingStyle.fill
      ..maskFilter = const MaskFilter.blur(BlurStyle.outer, 20);

    canvas.drawCircle(center, 30, corePaint);

    // Draw engine exhausts
    final exhaustPaint = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.fill
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 10);

    final random = math.Random();
    for (var i = 0; i < 3; i++) {
      final xOffset = -90 + i * 90;
      final flickerOffset = random.nextDouble() * 5;
      canvas.drawCircle(
        Offset(center.dx + xOffset, center.dy + 30),
        10 + flickerOffset,
        exhaustPaint,
      );
    }

    // Draw direction indicator
    final indicatorPaint = Paint()
      ..color = Colors.purple.shade300
      ..style = PaintingStyle.fill;

    if (isMovingRight) {
      canvas.drawPath(
        Path()
          ..moveTo(center.dx + 90, center.dy - 10)
          ..lineTo(center.dx + 110, center.dy)
          ..lineTo(center.dx + 90, center.dy + 10)
          ..close(),
        indicatorPaint,
      );
    } else {
      canvas.drawPath(
        Path()
          ..moveTo(center.dx - 90, center.dy - 10)
          ..lineTo(center.dx - 110, center.dy)
          ..lineTo(center.dx - 90, center.dy + 10)
          ..close(),
        indicatorPaint,
      );
    }

    // Draw health bar
    const barWidth = 160.0;
    const barHeight = 10.0;
    final barRect = Rect.fromCenter(
      center: Offset(center.dx, center.dy - 50),
      width: barWidth,
      height: barHeight,
    );

    // Background
    canvas.drawRect(
      barRect,
      Paint()
        ..color = Colors.grey.shade800
        ..style = PaintingStyle.fill,
    );

    // Health
    canvas.drawRect(
      Rect.fromLTWH(
        barRect.left,
        barRect.top,
        barWidth * healthPercentage,
        barHeight,
      ),
      Paint()
        ..shader = LinearGradient(
          colors: [
            Colors.red.shade700,
            Colors.red.shade500,
          ],
        ).createShader(barRect)
        ..style = PaintingStyle.fill,
    );

    // Border
    canvas.drawRect(
      barRect,
      Paint()
        ..color = Colors.white24
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1,
    );
  }

  @override
  bool shouldRepaint(BossPainter oldDelegate) =>
      healthPercentage != oldDelegate.healthPercentage ||
      isMovingRight != oldDelegate.isMovingRight ||
      isAiming != oldDelegate.isAiming;
}
