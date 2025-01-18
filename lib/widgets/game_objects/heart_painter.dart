import 'package:flutter/material.dart';

class HeartPainter extends CustomPainter {
  final Color color;

  HeartPainter({
    this.color = Colors.red,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final path = Path();

    // Create heart shape
    path.moveTo(size.width * 0.5, size.height * 0.85);
    path.cubicTo(size.width * 0.8, size.height * 0.6, size.width * 1.1,
        size.height * 0.3, size.width * 0.5, size.height * 0.15);
    path.cubicTo(size.width * -0.1, size.height * 0.3, size.width * 0.2,
        size.height * 0.6, size.width * 0.5, size.height * 0.85);

    // Glowing effect
    final glowPaint = Paint()
      ..shader = RadialGradient(
        center: Alignment.center,
        radius: 0.8,
        colors: [
          color,
          color.withOpacity(0.6),
          color.withOpacity(0.3),
          Colors.transparent,
        ],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height))
      ..maskFilter = const MaskFilter.blur(BlurStyle.outer, 8);

    // Base heart with gradient
    final heartGradient = LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        Colors.white,
        color,
        color.withOpacity(0.8),
      ],
    );

    final heartPaint = Paint()
      ..shader = heartGradient.createShader(
        Rect.fromLTWH(0, 0, size.width, size.height),
      )
      ..style = PaintingStyle.fill;

    // Draw glow and heart
    canvas.drawPath(path, glowPaint);
    canvas.drawPath(path, heartPaint);

    // Add highlight
    final highlightPaint = Paint()
      ..color = Colors.white.withOpacity(0.5)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    canvas.drawPath(path, highlightPaint);
  }

  @override
  bool shouldRepaint(HeartPainter oldDelegate) => color != oldDelegate.color;
}
