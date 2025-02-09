import 'package:flutter/material.dart';

import '../../base_game_painter.dart';
import '../mixins/painter_cache_mixin.dart';

/// Base class for game painters with caching functionality
abstract class CachedGamePainter extends BaseGamePainter
    with PainterCacheMixin {
  Size? _lastSize;

  CachedGamePainter({
    required super.color,
    super.opacity = 1.0,
    super.enableGlow = true,
    super.glowIntensity = 15.0,
    super.glowStyle = BlurStyle.outer,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (_lastSize != null && shouldInvalidateCache(_lastSize!, size)) {
      clearCache();
    }
    _lastSize = size;
    paintWithCache(canvas, size);
  }

  /// Override this method to implement cached painting
  void paintWithCache(Canvas canvas, Size size);

  @override
  bool shouldRepaint(covariant BaseGamePainter oldDelegate) {
    if (oldDelegate is CachedGamePainter) {
      if (_lastSize != oldDelegate._lastSize) {
        clearCache();
      }
    }
    return super.shouldRepaint(oldDelegate);
  }
}
