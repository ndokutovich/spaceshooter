import 'package:flutter/material.dart';
import 'dart:math' as math;
import '../../game/entities/bonus_item.dart';

class BonusPainter extends CustomPainter {
  final BonusType type;
  final double rotation;

  const BonusPainter({
    required this.type,
    required this.rotation,
  });

  @override
  void paint(Canvas canvas, Size size) {
    switch (type) {
      case BonusType.damageMultiplier:
        _paintDamageMultiplier(canvas, size);
        break;
      case BonusType.goldOre:
        _paintGoldOre(canvas, size);
        break;
    }
  }

  void _paintDamageMultiplier(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    canvas.translate(center.dx, center.dy);
    canvas.rotate(rotation);
    canvas.translate(-center.dx, -center.dy);

    // Draw a glowing "2×" symbol
    final paint = Paint()
      ..shader = RadialGradient(
        colors: [
          Colors.red.shade400,
          Colors.red.shade600,
          Colors.red.shade800.withOpacity(0.5),
        ],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height))
      ..maskFilter = const MaskFilter.blur(BlurStyle.outer, 5);

    // Draw the background glow
    canvas.drawCircle(center, size.width * 0.4, paint);

    // Draw the "2×" text
    final textPainter = TextPainter(
      text: TextSpan(
        text: '2×',
        style: TextStyle(
          color: Colors.white,
          fontSize: size.width * 0.4,
          fontWeight: FontWeight.bold,
          shadows: [
            Shadow(
              color: Colors.red.shade400,
              blurRadius: 10,
              offset: const Offset(0, 0),
            ),
          ],
        ),
      ),
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center,
    );

    textPainter.layout();
    textPainter.paint(
      canvas,
      Offset(
        (size.width - textPainter.width) / 2,
        (size.height - textPainter.height) / 2,
      ),
    );
  }

  void _paintGoldOre(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    canvas.translate(center.dx, center.dy);
    canvas.rotate(rotation);
    canvas.translate(-center.dx, -center.dy);

    // Gold ore with sparkle effect
    final paint = Paint()
      ..shader = RadialGradient(
        colors: [
          Colors.yellow.shade200,
          Colors.orange.shade600,
          Colors.orange.shade800.withOpacity(0.5),
        ],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height))
      ..maskFilter = const MaskFilter.blur(BlurStyle.outer, 5);

    // Draw irregular gold nugget shape
    final path = Path();
    final radius = size.width * 0.3;
    const points = 8;
    final random = math.Random(42); // Fixed seed for consistent shape

    for (var i = 0; i < points; i++) {
      final angle = (i * 2 * math.pi) / points;
      final variance = 0.8 + random.nextDouble() * 0.4;
      final x = center.dx + radius * variance * math.cos(angle);
      final y = center.dy + radius * variance * math.sin(angle);
      i == 0 ? path.moveTo(x, y) : path.lineTo(x, y);
    }
    path.close();

    canvas.drawPath(path, paint);

    // Add sparkles
    final sparklePaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    for (var i = 0; i < 4; i++) {
      final angle = (i * 2 * math.pi) / 4;
      final x = center.dx + radius * 0.7 * math.cos(angle);
      final y = center.dy + radius * 0.7 * math.sin(angle);
      canvas.drawCircle(Offset(x, y), size.width * 0.05, sparklePaint);
    }
  }

  @override
  bool shouldRepaint(BonusPainter oldDelegate) =>
      type != oldDelegate.type || rotation != oldDelegate.rotation;
}
