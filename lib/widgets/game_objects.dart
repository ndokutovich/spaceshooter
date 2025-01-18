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

class AsteroidPainter extends CustomPainter {
  final double rotation;
  final Color primaryColor;
  final Color accentColor;
  final int health;

  AsteroidPainter({
    required this.rotation,
    this.primaryColor = const Color(0xFF8B4513), // Saddle brown
    this.accentColor = const Color(0xFFD2691E), // Chocolate
    this.health = 3,
  });

  void _drawCrack(
      Canvas canvas, Offset start, double length, double angle, Paint paint) {
    final path = Path();
    path.moveTo(start.dx, start.dy);

    final random = math.Random();
    var currentPoint = start;
    var currentAngle = angle;
    final segments = 3 + random.nextInt(3);

    for (var i = 0; i < segments; i++) {
      final segmentLength =
          length / segments * (0.7 + random.nextDouble() * 0.6);
      currentAngle +=
          (random.nextDouble() - 0.5) * 0.5; // Random angle variation
      final endPoint = Offset(
        currentPoint.dx + math.cos(currentAngle) * segmentLength,
        currentPoint.dy + math.sin(currentAngle) * segmentLength,
      );

      // Add small branches to the crack
      if (random.nextDouble() < 0.7) {
        final branchAngle =
            currentAngle + (random.nextDouble() - 0.5) * math.pi / 2;
        final branchLength = segmentLength * 0.4;
        final branchEnd = Offset(
          currentPoint.dx + math.cos(branchAngle) * branchLength,
          currentPoint.dy + math.sin(branchAngle) * branchLength,
        );
        path.moveTo(currentPoint.dx, currentPoint.dy);
        path.lineTo(branchEnd.dx, branchEnd.dy);
        path.moveTo(currentPoint.dx, currentPoint.dy);
      }

      path.lineTo(endPoint.dx, endPoint.dy);
      currentPoint = endPoint;
    }

    canvas.drawPath(path, paint);
  }

  void _drawDamage(
      Canvas canvas, Size size, Path asteroidPath, int damageLevel) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width * 0.4;
    final random = math.Random();

    final crackPaint = Paint()
      ..color = Colors.black.withOpacity(0.7)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    final chipPaint = Paint()
      ..color = Colors.black.withOpacity(0.5)
      ..style = PaintingStyle.fill;

    // Add cracks based on damage level
    for (var i = 0; i < (3 - health) * 3; i++) {
      final angle = random.nextDouble() * 2 * math.pi;
      final distance = radius * (0.3 + random.nextDouble() * 0.7);
      final startPoint = Offset(
        center.dx + math.cos(angle) * distance,
        center.dy + math.sin(angle) * distance,
      );

      _drawCrack(
        canvas,
        startPoint,
        radius * (0.3 + random.nextDouble() * 0.3),
        angle + (random.nextDouble() - 0.5) * math.pi,
        crackPaint,
      );
    }

    // Add chips and breaks in the asteroid
    for (var i = 0; i < (3 - health) * 2; i++) {
      final chipPath = Path();
      final angle = random.nextDouble() * 2 * math.pi;
      final distance = radius * 0.8;
      final chipSize = radius * (0.1 + random.nextDouble() * 0.15);

      chipPath.addOval(
        Rect.fromCenter(
          center: Offset(
            center.dx + math.cos(angle) * distance,
            center.dy + math.sin(angle) * distance,
          ),
          width: chipSize,
          height: chipSize,
        ),
      );

      canvas.drawPath(chipPath, chipPaint);
    }
  }

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

    // Create base shape
    for (var i = 0; i < points; i++) {
      final angle = (i * 2 * math.pi) / points;
      final variance = math.Random().nextDouble() * 0.2 + 0.9;
      final x = center.dx + radius * variance * math.cos(angle);
      final y = center.dy + radius * variance * math.sin(angle);
      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }
    path.close();

    // Base color based on health
    final basePaint = Paint()
      ..color = Color.lerp(
        Colors.red.withOpacity(0.7),
        primaryColor,
        health / 3,
      )!
      ..style = PaintingStyle.fill;
    canvas.drawPath(path, basePaint);

    // Draw damage effects
    _drawDamage(canvas, size, path, 3 - health);

    // Outer glow based on health
    final glowPaint = Paint()
      ..color = Color.lerp(
        Colors.red.withOpacity(0.3),
        primaryColor.withOpacity(0.3),
        health / 3,
      )!
      ..maskFilter = const MaskFilter.blur(BlurStyle.outer, 3);
    canvas.drawPath(path, glowPaint);

    // Surface details
    final detailPaint = Paint()
      ..color = Color.lerp(
        Colors.redAccent.withOpacity(0.6),
        accentColor.withOpacity(0.6),
        health / 3,
      )!
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
      ..color = Color.lerp(
        Colors.red.withOpacity(0.3),
        Colors.white.withOpacity(0.3),
        health / 3,
      )!
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    canvas.drawPath(path, highlightPaint);
  }

  @override
  bool shouldRepaint(AsteroidPainter oldDelegate) =>
      rotation != oldDelegate.rotation ||
      primaryColor != oldDelegate.primaryColor ||
      accentColor != oldDelegate.accentColor ||
      health != oldDelegate.health;
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
