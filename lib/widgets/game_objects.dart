import 'package:flutter/material.dart';
import 'dart:math' as math;

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
        color.withValues(
            red: (color.r * 255).toDouble(),
            green: (color.g * 255).toDouble(),
            blue: (color.b * 255).toDouble(),
            alpha: 77.0), // 0.3
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

class AsteroidPainter extends CustomPainter {
  final double rotation;
  final Color primaryColor;
  final Color accentColor;

  AsteroidPainter({
    required this.rotation,
    this.primaryColor = Colors.grey,
    this.accentColor = Colors.white,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    canvas.translate(center.dx, center.dy);
    canvas.rotate(rotation);
    canvas.translate(-center.dx, -center.dy);

    // Create irregular asteroid shape
    final path = Path();
    final radius = size.width * 0.4;
    const points = 8;

    for (var i = 0; i < points; i++) {
      final angle = (i * 2 * math.pi / points);
      final variance = math.Random().nextDouble() * 0.2 + 0.8; // 0.8-1.0
      final x = center.dx + radius * variance * math.cos(angle);
      final y = center.dy + radius * variance * math.sin(angle);

      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }
    path.close();

    // Base shadow
    final shadowPaint = Paint()
      ..color = Colors.black
          .withValues(red: 0.0, green: 0.0, blue: 0.0, alpha: 128.0) // 0.5
      ..style = PaintingStyle.fill;
    canvas.drawPath(path, shadowPaint);

    // Rock texture gradient
    final rockGradient = RadialGradient(
      center: const Alignment(-0.5, -0.5),
      radius: 1.2,
      colors: [
        Colors.white,
        primaryColor,
        primaryColor.withValues(
            red: (primaryColor.r * 255 - 40).toDouble(),
            green: (primaryColor.g * 255 - 40).toDouble(),
            blue: (primaryColor.b * 255 - 40).toDouble(),
            alpha: 204.0), // 0.8
      ],
    );

    final paint = Paint()
      ..shader = rockGradient.createShader(
        Rect.fromLTWH(0, 0, size.width, size.height),
      )
      ..style = PaintingStyle.fill;

    canvas.drawPath(path, paint);

    // Surface details
    final detailPaint = Paint()
      ..color = Colors.white.withValues(
          red: 255.0, green: 255.0, blue: 255.0, alpha: 153.0) // 0.6
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    // Add crater-like details
    for (var i = 0; i < 3; i++) {
      final craterPath = Path();
      final angle = math.Random().nextDouble() * 2 * math.pi;
      final distance = radius * (0.3 + math.Random().nextDouble() * 0.4);
      final craterX = center.dx + distance * math.cos(angle);
      final craterY = center.dy + distance * math.sin(angle);
      final craterSize = radius * (0.2 + math.Random().nextDouble() * 0.2);

      craterPath.addOval(
        Rect.fromCenter(
          center: Offset(craterX, craterY),
          width: craterSize,
          height: craterSize * 0.8,
        ),
      );
      canvas.drawPath(craterPath, detailPaint);
    }

    // Highlight edge
    final highlightPaint = Paint()
      ..color = Colors.white
          .withValues(red: 255.0, green: 255.0, blue: 255.0, alpha: 77.0) // 0.3
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    canvas.drawPath(path, highlightPaint);
  }

  @override
  bool shouldRepaint(AsteroidPainter oldDelegate) =>
      rotation != oldDelegate.rotation ||
      primaryColor != oldDelegate.primaryColor ||
      accentColor != oldDelegate.accentColor;
}

class GameObjectWidget extends StatelessWidget {
  final CustomPainter painter;
  final double size;

  const GameObjectWidget({
    super.key,
    required this.painter,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: painter,
      size: Size(size, size),
    );
  }
}
