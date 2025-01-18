import 'package:flutter/material.dart';

class ProjectilePainter extends CustomPainter {
  final Color color;

  ProjectilePainter({
    this.color = Colors.cyan,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // Energy bolt effect
    final boltGradient = RadialGradient(
      center: Alignment.center,
      radius: 0.5,
      colors: [
        Colors.white,
        color,
        color.withOpacity(0.3),
      ],
    );

    final paint = Paint()
      ..shader = boltGradient.createShader(
        Rect.fromLTWH(0, 0, size.width, size.height),
      )
      ..maskFilter = const MaskFilter.blur(BlurStyle.outer, 5);

    // Main energy bolt
    final path = Path();
    path.moveTo(size.width * 0.5, 0);
    path.lineTo(size.width * 0.7, size.height * 0.3);
    path.lineTo(size.width * 0.6, size.height * 0.5);
    path.lineTo(size.width * 0.7, size.height * 0.7);
    path.lineTo(size.width * 0.5, size.height);
    path.lineTo(size.width * 0.3, size.height * 0.7);
    path.lineTo(size.width * 0.4, size.height * 0.5);
    path.lineTo(size.width * 0.3, size.height * 0.3);
    path.close();

    canvas.drawPath(path, paint);

    // Core glow
    final corePaint = Paint()
      ..color = Colors.white
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 3);

    canvas.drawCircle(
      Offset(size.width * 0.5, size.height * 0.5),
      size.width * 0.15,
      corePaint,
    );
  }

  @override
  bool shouldRepaint(ProjectilePainter oldDelegate) =>
      color != oldDelegate.color;
}
