import 'package:flutter/material.dart';

/// Mixin that provides caching functionality for paths and gradients
mixin PainterCacheMixin {
  final Map<String, Path> _pathCache = {};
  final Map<String, Shader> _shaderCache = {};
  final Map<String, Paint> _paintCache = {};

  /// Get a cached path or create and cache a new one
  Path getCachedPath(String key, Path Function() createPath) {
    return _pathCache.putIfAbsent(key, createPath);
  }

  /// Get a cached shader or create and cache a new one
  Shader getCachedShader(String key, Shader Function() createShader) {
    return _shaderCache.putIfAbsent(key, createShader);
  }

  /// Get a cached paint or create and cache a new one
  Paint getCachedPaint(String key, Paint Function() createPaint) {
    return _paintCache.putIfAbsent(key, createPaint);
  }

  /// Clear all caches
  void clearCache() {
    _pathCache.clear();
    _shaderCache.clear();
    _paintCache.clear();
  }

  /// Clear specific cache by key
  void clearCacheKey(String key) {
    _pathCache.remove(key);
    _shaderCache.remove(key);
    _paintCache.remove(key);
  }

  /// Check if size or other properties have changed and require cache invalidation
  bool shouldInvalidateCache(Size oldSize, Size newSize) {
    return oldSize != newSize;
  }

  /// Generate a unique key for caching based on parameters
  String generateCacheKey(String prefix, Map<String, dynamic> params) {
    final sortedParams = Map.fromEntries(
      params.entries.toList()..sort((a, b) => a.key.compareTo(b.key)),
    );
    return '$prefix:${sortedParams.toString()}';
  }
}
