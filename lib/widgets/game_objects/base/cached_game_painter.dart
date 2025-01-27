import 'package:flutter/material.dart';

/// Base class for game painters that provides caching functionality
abstract class CachedGamePainter extends CustomPainter {
  final Color color;
  final double opacity;
  final bool enableGlow;
  final double glowIntensity;
  final BlurStyle glowStyle;

  final Map<String, Paint> _paintCache = {};
  final Map<String, Path> _pathCache = {};

  CachedGamePainter({
    required this.color,
    this.opacity = 1.0,
    this.enableGlow = true,
    this.glowIntensity = 15.0,
    this.glowStyle = BlurStyle.outer,
  });

  /// Generate a unique cache key based on the provided base key and parameters
  String generateCacheKey(String baseKey, Map<String, String> params) {
    final sortedParams = Map.fromEntries(
      params.entries.toList()..sort((a, b) => a.key.compareTo(b.key)),
    );
    return '$baseKey:${sortedParams.toString()}';
  }

  /// Get a cached paint object or create a new one using the provided factory
  Paint getCachedPaint(String key, Paint Function() factory) {
    return _paintCache.putIfAbsent(key, factory);
  }

  /// Get a cached path object or create a new one using the provided factory
  Path getCachedPath(String key, Path Function() factory) {
    return _pathCache.putIfAbsent(key, factory);
  }

  /// Clear all cached objects
  void clearCache() {
    _paintCache.clear();
    _pathCache.clear();
  }

  /// Paint the object with caching support
  @override
  void paint(Canvas canvas, Size size) {
    paintWithCache(canvas, size);
  }

  /// Paint implementation that uses caching
  void paintWithCache(Canvas canvas, Size size);

  @override
  bool shouldRepaint(covariant CachedGamePainter oldDelegate) {
    return color != oldDelegate.color ||
        opacity != oldDelegate.opacity ||
        enableGlow != oldDelegate.enableGlow ||
        glowIntensity != oldDelegate.glowIntensity ||
        glowStyle != oldDelegate.glowStyle;
  }
}
