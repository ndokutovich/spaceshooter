import 'package:flutter/material.dart';
import 'base_game_painter.dart';
import 'boss_config.dart';
import 'boss_cache_mixin.dart';

/// Base class for all boss component painters
abstract class BossComponentPainter extends BaseGamePainter with BossCacheMixin {
  final BossConfig config;
  final double healthPercentage;
  final bool isMovingRight;
  final bool isAiming;

  BossComponentPainter({
    required this.config,
    required this.healthPercentage,
    required this.isMovingRight,
    required this.isAiming,
    super.color = Colors.purple,
    super.opacity = 1.0,
    super.useGlow = false,
    super.glowIntensity = 2.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    invalidateCachesIfNeeded(size, config);
    paintComponent(canvas, size, center);
  }

  /// Implement this method to paint the specific component
  void paintComponent(Canvas canvas, Size size, Offset center);

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    if (oldDelegate is BossComponentPainter) {
      return super.shouldRepaint(oldDelegate) ||
          config != oldDelegate.config ||
          healthPercentage != oldDelegate.healthPercentage ||
          isMovingRight != oldDelegate.isMovingRight ||
          isAiming != oldDelegate.isAiming;
    }
    return true;
  }
} 