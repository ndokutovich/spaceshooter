import 'package:flutter/material.dart';
import 'dart:math' as math;
import '../boss_components/base/cached_game_painter.dart';
import '../../../game/entities/bonus_item.dart';
import 'config/bonus_visual_config.dart';

class BonusPainter extends CachedGamePainter {
  final BonusType type;
  final double rotation;
  final BonusVisualConfig config;

  BonusPainter({
    required this.type,
    required this.rotation,
    required this.config,
  }) : super(
          color: config.primaryColor,
          opacity: 1.0,
          enableGlow: true,
          glowIntensity: config.glowRadius,
          glowStyle: config.glowStyle,
        );

  void _paintDamageMultiplier(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    canvas.translate(center.dx, center.dy);
    canvas.rotate(rotation);
    canvas.translate(-center.dx, -center.dy);

    // Draw a glowing "2×" symbol
    final paint = getCachedPaint(
      'damageMultiplierPaint',
      () => Paint()
        ..shader = RadialGradient(
          colors: [
            config.primaryColor,
            config.secondaryColor,
            config.secondaryColor.withOpacity(config.glowOpacity),
          ],
        ).createShader(Rect.fromLTWH(0, 0, size.width, size.height))
        ..maskFilter = MaskFilter.blur(config.glowStyle, config.glowRadius),
    );

    // Draw the background glow
    final backgroundPath = getCachedPath(
      'damageMultiplierBackground',
      () {
        final path = Path();
        path.addOval(Rect.fromCenter(
          center: center,
          width: size.width * config.baseRadius * 2,
          height: size.width * config.baseRadius * 2,
        ));
        return path;
      },
    );
    canvas.drawPath(backgroundPath, paint);

    // Draw the "2×" text
    final textPainter = TextPainter(
      text: TextSpan(
        text: '2×',
        style: TextStyle(
          color: config.sparkleColor,
          fontSize: size.width * config.textScale,
          fontWeight: FontWeight.bold,
          shadows: [
            Shadow(
              color: config.glowColor,
              blurRadius: config.glowRadius * 2,
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
    final paint = getCachedPaint(
      'goldOrePaint',
      () => Paint()
        ..shader = RadialGradient(
          colors: [
            config.primaryColor,
            config.secondaryColor,
            config.secondaryColor.withOpacity(config.glowOpacity),
          ],
        ).createShader(Rect.fromLTWH(0, 0, size.width, size.height))
        ..maskFilter = MaskFilter.blur(config.glowStyle, config.glowRadius),
    );

    // Draw irregular gold nugget shape
    final path = getCachedPath(
      'goldOrePath',
      () {
        final path = Path();
        final radius = size.width * config.baseRadius;
        final random = math.Random(42); // Fixed seed for consistent shape

        for (var i = 0; i < config.vertexCount; i++) {
          final angle = (i * 2 * math.pi) / config.vertexCount;
          final variance = 0.8 + random.nextDouble() * config.vertexVariance;
          final x = center.dx + radius * variance * math.cos(angle);
          final y = center.dy + radius * variance * math.sin(angle);
          i == 0 ? path.moveTo(x, y) : path.lineTo(x, y);
        }
        path.close();
        return path;
      },
    );

    canvas.drawPath(path, paint);

    // Add sparkles
    final sparklePaint = getCachedPaint(
      'sparklePaint',
      () => Paint()
        ..color = config.sparkleColor.withOpacity(config.sparkleOpacity)
        ..style = PaintingStyle.fill,
    );

    for (var i = 0; i < config.sparkleCount; i++) {
      final angle = (i * 2 * math.pi) / config.sparkleCount;
      final x = center.dx +
          size.width *
              config.baseRadius *
              config.sparkleDistanceScale *
              math.cos(angle);
      final y = center.dy +
          size.width *
              config.baseRadius *
              config.sparkleDistanceScale *
              math.sin(angle);

      final sparklePath = getCachedPath(
        'sparkle_$i',
        () {
          final path = Path();
          path.addOval(Rect.fromCenter(
            center: Offset(x, y),
            width: size.width * config.sparkleRadius * 2,
            height: size.width * config.sparkleRadius * 2,
          ));
          return path;
        },
      );
      canvas.drawPath(sparklePath, sparklePaint);
    }
  }

  @override
  void paintWithCache(Canvas canvas, Size size) {
    switch (type) {
      case BonusType.damageMultiplier:
        _paintDamageMultiplier(canvas, size);
        break;
      case BonusType.goldOre:
        _paintGoldOre(canvas, size);
        break;
    }
  }

  @override
  bool shouldRepaint(covariant BonusPainter oldDelegate) =>
      type != oldDelegate.type ||
      rotation != oldDelegate.rotation ||
      config != oldDelegate.config ||
      super.shouldRepaint(oldDelegate);
}
