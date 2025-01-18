import 'package:flutter/material.dart';

class NovaCounterPainter extends CustomPainter {
  final Color color;
  final String count;

  NovaCounterPainter({
    required this.color,
    required this.count,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // Energy orb background
    final orbGradient = RadialGradient(
      center: Alignment.center,
      radius: 0.7,
      colors: [
        Colors.white,
        color,
        color.withOpacity(0.5),
        Colors.transparent,
      ],
    );

    final orbPaint = Paint()
      ..shader = orbGradient.createShader(
        Rect.fromLTWH(0, 0, size.width, size.height),
      )
      ..maskFilter = const MaskFilter.blur(BlurStyle.outer, 10);

    canvas.drawCircle(
      Offset(size.width / 2, size.height / 2),
      size.width * 0.4,
      orbPaint,
    );

    // Draw counter text
    final textPainter = TextPainter(
      text: TextSpan(
        text: count,
        style: TextStyle(
          color: Colors.white,
          fontSize: size.height * 0.5,
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
