import 'package:flutter/material.dart';
import 'dart:math' as math;
import '../boss_components/base/cached_game_painter.dart';
import 'config/asteroid_visual_config.dart';

class AsteroidPainter extends CachedGamePainter {
  final double rotation;
  final int health;
  final AsteroidVisualConfig config;

  AsteroidPainter({
    required this.rotation,
    required this.health,
    required this.config,
  }) : super(
          color: config.primaryColor,
          opacity: 1.0,
          enableGlow: true,
          glowIntensity: config.glowRadius,
          glowStyle: config.glowStyle,
        );

  void _drawCrack(
    Canvas canvas,
    Offset start,
    double length,
    double angle,
    Paint paint,
  ) {
    final path = getCachedPath(
      generateCacheKey('crack', {
        'start': '${start.dx},${start.dy}',
        'length': length,
        'angle': angle,
      }),
      () {
        final path = Path();
        path.moveTo(start.dx, start.dy);

        final random = math.Random();
        var currentPoint = start;
        var currentAngle = angle;
        final segments = config.cracksPerDamageLevel;

        for (var i = 0; i < segments; i++) {
          final segmentLength =
              length / segments * (0.7 + random.nextDouble() * 0.6);
          currentAngle += (random.nextDouble() - 0.5) * 0.5;
          final endPoint = Offset(
            currentPoint.dx + math.cos(currentAngle) * segmentLength,
            currentPoint.dy + math.sin(currentAngle) * segmentLength,
          );

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
        return path;
      },
    );

    canvas.drawPath(path, paint);
  }

  void _drawDamage(
      Canvas canvas, Size size, Path asteroidPath, int damageLevel) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width * config.baseRadius;
    final random = math.Random();

    final crackPaint = getCachedPaint(
      'crackPaint',
      () => Paint()
        ..color = config.damageColor.withOpacity(config.crackOpacity)
        ..style = PaintingStyle.stroke
        ..strokeWidth = config.crackWidth,
    );

    final chipPaint = getCachedPaint(
      'chipPaint',
      () => Paint()
        ..color = config.damageColor.withOpacity(config.chipOpacity)
        ..style = PaintingStyle.fill,
    );

    for (var i = 0; i < (3 - health) * config.cracksPerDamageLevel; i++) {
      final angle = random.nextDouble() * 2 * math.pi;
      final distance = radius * (0.3 + random.nextDouble() * 0.7);
      final startPoint = Offset(
        center.dx + math.cos(angle) * distance,
        center.dy + math.sin(angle) * distance,
      );

      _drawCrack(
        canvas,
        startPoint,
        radius * config.crackLength,
        angle + (random.nextDouble() - 0.5) * math.pi,
        crackPaint,
      );
    }

    for (var i = 0; i < (3 - health) * config.chipsPerDamageLevel; i++) {
      final chipPath = Path();
      final angle = random.nextDouble() * 2 * math.pi;
      final distance = radius * 0.8;
      final chipSize = radius * config.chipSize;

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
  void paintWithCache(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    canvas.translate(center.dx, center.dy);
    canvas.rotate(rotation);
    canvas.translate(-center.dx, -center.dy);

    final path = getCachedPath(
      generateCacheKey('asteroid', {
        'size': '${size.width},${size.height}',
        'vertexCount': config.vertexCount,
      }),
      () {
        final path = Path();
        final radius = size.width * config.baseRadius;

        for (var i = 0; i < config.vertexCount; i++) {
          final angle = (i * 2 * math.pi) / config.vertexCount;
          final variance =
              math.Random().nextDouble() * config.vertexVariance + 0.9;
          final x = center.dx + radius * variance * math.cos(angle);
          final y = center.dy + radius * variance * math.sin(angle);
          if (i == 0) {
            path.moveTo(x, y);
          } else {
            path.lineTo(x, y);
          }
        }
        path.close();
        return path;
      },
    );

    final basePaint = getCachedPaint(
      generateCacheKey('basePaint', {'health': health}),
      () => Paint()
        ..color = Color.lerp(
          config.damageColor.withOpacity(0.7),
          config.primaryColor,
          health / 3,
        )!
        ..style = PaintingStyle.fill,
    );
    canvas.drawPath(path, basePaint);

    _drawDamage(canvas, size, path, 3 - health);

    final glowPaint = getCachedPaint(
      generateCacheKey('glowPaint', {'health': health}),
      () => Paint()
        ..color = Color.lerp(
          config.damageColor.withOpacity(config.glowOpacity),
          config.primaryColor.withOpacity(config.glowOpacity),
          health / 3,
        )!
        ..maskFilter = MaskFilter.blur(config.glowStyle, config.glowRadius),
    );
    canvas.drawPath(path, glowPaint);

    final detailPaint = getCachedPaint(
      generateCacheKey('detailPaint', {'health': health}),
      () => Paint()
        ..color = Color.lerp(
          config.damageColor.withOpacity(config.craterOpacity),
          config.accentColor.withOpacity(config.craterOpacity),
          health / 3,
        )!
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2,
    );

    for (var i = 0; i < config.craterCount; i++) {
      final craterPath = getCachedPath(
        generateCacheKey('crater', {'index': i}),
        () {
          final path = Path();
          final angle = math.Random().nextDouble() * 2 * math.pi;
          final distance = size.width *
              config.baseRadius *
              (0.3 + math.Random().nextDouble() * 0.4);
          final craterX = center.dx + distance * math.cos(angle);
          final craterY = center.dy + distance * math.sin(angle);
          final craterSize = size.width * config.baseRadius * config.craterSize;

          path.addOval(
            Rect.fromCenter(
              center: Offset(craterX, craterY),
              width: craterSize,
              height: craterSize * config.craterEccentricity,
            ),
          );
          return path;
        },
      );
      canvas.drawPath(craterPath, detailPaint);
    }

    final highlightPaint = getCachedPaint(
      generateCacheKey('highlightPaint', {'health': health}),
      () => Paint()
        ..color = Color.lerp(
          config.damageColor.withOpacity(config.edgeHighlightOpacity),
          config.highlightColor.withOpacity(config.edgeHighlightOpacity),
          health / 3,
        )!
        ..style = PaintingStyle.stroke
        ..strokeWidth = config.edgeHighlightWidth,
    );
    canvas.drawPath(path, highlightPaint);
  }

  @override
  bool shouldRepaint(covariant AsteroidPainter oldDelegate) =>
      rotation != oldDelegate.rotation ||
      health != oldDelegate.health ||
      config != oldDelegate.config ||
      super.shouldRepaint(oldDelegate);
}
