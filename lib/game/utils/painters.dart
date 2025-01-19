import 'package:flutter/material.dart';

class HeartPainter extends CustomPainter {
  final Color color;

  HeartPainter({
    required this.color,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final path = Path();

    // Create heart shape with sharper angles for sci-fi look
    path.moveTo(size.width * 0.5, size.height * 0.85);
    path.lineTo(size.width * 0.15, size.height * 0.5);
    path.lineTo(size.width * 0.3, size.height * 0.3);
    path.lineTo(size.width * 0.5, size.height * 0.4);
    path.lineTo(size.width * 0.7, size.height * 0.3);
    path.lineTo(size.width * 0.85, size.height * 0.5);
    path.close();

    // Energy core gradient
    final coreGradient = RadialGradient(
      center: Alignment.center,
      radius: 0.8,
      colors: [
        Colors.white,
        color.withOpacity(0.8),
        color.withOpacity(0.6),
      ],
    );

    // Metallic edge gradient
    final edgeGradient = LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        Colors.white.withOpacity(0.9),
        color,
        color.withOpacity(0.8),
        Colors.white.withOpacity(0.3),
      ],
      stops: const [0.0, 0.3, 0.7, 1.0],
    );

    // Draw energy glow
    final glowPaint = Paint()
      ..maskFilter = const MaskFilter.blur(BlurStyle.outer, 8)
      ..shader = coreGradient.createShader(
        Rect.fromCenter(
          center: Offset(size.width * 0.5, size.height * 0.5),
          width: size.width,
          height: size.height,
        ),
      );

    // Draw metallic edge
    final edgePaint = Paint()
      ..shader = edgeGradient.createShader(
        Rect.fromLTWH(0, 0, size.width, size.height),
      )
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4;

    // Draw base with energy core
    final basePaint = Paint()
      ..shader = coreGradient.createShader(
        Rect.fromLTWH(0, 0, size.width, size.height),
      );

    // Apply all layers
    canvas.drawPath(path, glowPaint);
    canvas.drawPath(path, basePaint);
    canvas.drawPath(path, edgePaint);

    // Add highlight detail
    final detailPath = Path()
      ..moveTo(size.width * 0.3, size.height * 0.4)
      ..lineTo(size.width * 0.4, size.height * 0.5)
      ..lineTo(size.width * 0.5, size.height * 0.45);

    canvas.drawPath(
      detailPath,
      Paint()
        ..color = Colors.white.withOpacity(0.6)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2,
    );
  }

  @override
  bool shouldRepaint(HeartPainter oldDelegate) => color != oldDelegate.color;
}

class NovaCounterPainter extends CustomPainter {
  final Color color;
  final String count;

  NovaCounterPainter({
    required this.color,
    required this.count,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill
      ..maskFilter = const MaskFilter.blur(BlurStyle.outer, 5);

    canvas.drawCircle(
      Offset(size.width / 2, size.height / 2),
      size.width / 2,
      paint,
    );

    final textPainter = TextPainter(
      text: TextSpan(
        text: count,
        style: TextStyle(
          color: Colors.white,
          fontSize: size.height * 0.6,
          fontWeight: FontWeight.bold,
          shadows: [
            Shadow(
              color: color,
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

  @override
  bool shouldRepaint(NovaCounterPainter oldDelegate) =>
      color != oldDelegate.color || count != oldDelegate.count;
}
