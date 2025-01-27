import 'package:flutter/material.dart';
import '../base_game_painter.dart';

class BossHealthBarPainter extends BaseGamePainter {
  final double healthPercentage;
  final double shieldPercentage;
  late final MaterialColor _materialColor;

  BossHealthBarPainter({
    required this.healthPercentage,
    required this.shieldPercentage,
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
    final barWidth = size.width * 0.8;
    final barHeight = size.height * 0.15;
    final barLeft = (size.width - barWidth) / 2;
    final barTop = size.height * 0.1;

    // Draw background bar
    final backgroundRect = RRect.fromRectAndRadius(
      Rect.fromLTWH(barLeft, barTop, barWidth, barHeight),
      const Radius.circular(4.0),
    );

    final backgroundPaint = Paint()
      ..color = _materialColor.shade900.withOpacity(0.3)
      ..style = PaintingStyle.fill;

    canvas.drawRRect(backgroundRect, backgroundPaint);

    // Draw shield bar if active
    if (shieldPercentage > 0) {
      final shieldWidth = barWidth * shieldPercentage;
      final shieldRect = RRect.fromRectAndRadius(
        Rect.fromLTWH(barLeft, barTop, shieldWidth, barHeight),
        const Radius.circular(4.0),
      );

      final shieldPaint = Paint()
        ..shader = LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
            _materialColor.shade200.withOpacity(0.8),
            _materialColor.shade300.withOpacity(0.6),
          ],
        ).createShader(Rect.fromLTWH(barLeft, barTop, shieldWidth, barHeight));

      canvas.drawRRect(shieldRect, shieldPaint);

      // Draw shield pattern
      final patternPaint = Paint()
        ..color = _materialColor.shade100.withOpacity(0.3)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.0;

      for (var i = 0; i < shieldWidth; i += 10) {
        canvas.drawLine(
          Offset(barLeft + i, barTop),
          Offset(barLeft + i + 5, barTop + barHeight),
          patternPaint,
        );
      }
    }

    // Draw health bar
    final healthWidth = barWidth * healthPercentage;
    final healthRect = RRect.fromRectAndRadius(
      Rect.fromLTWH(barLeft, barTop, healthWidth, barHeight),
      const Radius.circular(4.0),
    );

    final healthPaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
        colors: [
          _materialColor.shade700,
          _materialColor.shade500,
        ],
      ).createShader(Rect.fromLTWH(barLeft, barTop, healthWidth, barHeight));

    canvas.drawRRect(healthRect, healthPaint);

    // Draw segmented pattern
    final segmentPaint = Paint()
      ..color = _materialColor.shade800.withOpacity(0.5)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;

    final segmentWidth = barWidth / 10;
    for (var i = 1; i < 10; i++) {
      final x = barLeft + (segmentWidth * i);
      canvas.drawLine(
        Offset(x, barTop),
        Offset(x, barTop + barHeight),
        segmentPaint,
      );
    }

    // Draw border
    final borderPaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          _materialColor.shade300,
          _materialColor.shade500,
        ],
      ).createShader(Rect.fromLTWH(barLeft, barTop, barWidth, barHeight))
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;

    canvas.drawRRect(backgroundRect, borderPaint);

    // Draw percentage text
    final textStyle = TextStyle(
      color: _materialColor.shade100,
      fontSize: 12,
      fontWeight: FontWeight.bold,
    );

    final healthText = '${(healthPercentage * 100).toInt()}%';
    final textSpan = TextSpan(text: healthText, style: textStyle);
    final textPainter = TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr,
    );

    textPainter.layout();
    textPainter.paint(
      canvas,
      Offset(
        barLeft + (barWidth - textPainter.width) / 2,
        barTop + (barHeight - textPainter.height) / 2,
      ),
    );
  }

  @override
  bool shouldRepaint(BossHealthBarPainter oldDelegate) =>
      healthPercentage != oldDelegate.healthPercentage ||
      shieldPercentage != oldDelegate.shieldPercentage ||
      super.shouldRepaint(oldDelegate);
}
