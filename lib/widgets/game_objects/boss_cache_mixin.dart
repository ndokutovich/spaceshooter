import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'dart:math' as math;
import 'boss_config.dart';

/// Mixin that provides caching functionality for complex paths and gradients
mixin BossCacheMixin {
  // Cache keys
  Size? _lastSize;
  BossConfig? _lastConfig;

  // Path caches
  Path? _bodyPath;
  Path? _leftLaunchPadPath;
  Path? _rightLaunchPadPath;
  List<Path>? _hexPaths;

  // Shader caches
  ui.Shader? _shieldShader;
  ui.Shader? _energyFieldShader;
  ui.Shader? _bodyShader;

  /// Invalidates all caches when size or config changes
  void invalidateCachesIfNeeded(Size size, BossConfig config) {
    if (_lastSize != size || _lastConfig != config) {
      _bodyPath = null;
      _leftLaunchPadPath = null;
      _rightLaunchPadPath = null;
      _hexPaths = null;
      _shieldShader = null;
      _energyFieldShader = null;
      _bodyShader = null;

      _lastSize = size;
      _lastConfig = config;
    }
  }

  /// Gets or creates the cached body path
  Path getBodyPath(Size size, BossBodyConfig config, Offset center) {
    _bodyPath ??= _createBodyPath(size, config, center);
    return _bodyPath!;
  }

  /// Gets or creates the cached launch pad paths
  List<Path> getLaunchPadPaths(
      Size size, BossLaunchPadConfig config, Offset center) {
    if (_leftLaunchPadPath == null || _rightLaunchPadPath == null) {
      final paths = _createLaunchPadPaths(size, config, center);
      _leftLaunchPadPath = paths[0];
      _rightLaunchPadPath = paths[1];
    }
    return [_leftLaunchPadPath!, _rightLaunchPadPath!];
  }

  /// Gets or creates the cached hex pattern paths
  List<Path> getHexPaths(
      Size size, BossHexPatternConfig config, Offset center) {
    _hexPaths ??= _createHexPaths(size, config, center);
    return _hexPaths!;
  }

  /// Gets or creates the cached shield shader
  ui.Shader getShieldShader(Size size, BossShieldConfig config, Offset center) {
    _shieldShader ??= _createShieldShader(size, config, center);
    return _shieldShader!;
  }

  /// Gets or creates the cached energy field shader
  ui.Shader getEnergyFieldShader(
      Size size, BossEnergyFieldConfig config, Offset center) {
    _energyFieldShader ??= _createEnergyFieldShader(size, config, center);
    return _energyFieldShader!;
  }

  /// Gets or creates the cached body shader
  ui.Shader getBodyShader(Size size, BossBodyConfig config, Offset center) {
    _bodyShader ??= _createBodyShader(size, config, center);
    return _bodyShader!;
  }

  // Private path creation methods
  Path _createBodyPath(Size size, BossBodyConfig config, Offset center) {
    final path = Path();
    final width = config.width;
    final topOffset = config.topOffset;
    final bottomOffset = config.bottomOffset;

    // Main hull with more detail
    path.moveTo(center.dx - width, center.dy + bottomOffset);
    path.lineTo(center.dx - width * 0.9, center.dy - topOffset * 0.6);
    path.lineTo(center.dx - width * 0.7, center.dy - topOffset * 0.7);
    path.lineTo(center.dx - width * 0.6, center.dy - topOffset * 0.8);
    path.lineTo(center.dx - width * 0.4, center.dy - topOffset * 0.86);
    path.lineTo(center.dx - width * 0.3, center.dy - topOffset * 0.9);
    path.lineTo(center.dx - width * 0.15, center.dy - topOffset * 0.96);
    path.lineTo(center.dx, center.dy - topOffset);
    path.lineTo(center.dx + width * 0.15, center.dy - topOffset * 0.96);
    path.lineTo(center.dx + width * 0.3, center.dy - topOffset * 0.9);
    path.lineTo(center.dx + width * 0.4, center.dy - topOffset * 0.86);
    path.lineTo(center.dx + width * 0.6, center.dy - topOffset * 0.8);
    path.lineTo(center.dx + width * 0.7, center.dy - topOffset * 0.7);
    path.lineTo(center.dx + width * 0.9, center.dy - topOffset * 0.6);
    path.lineTo(center.dx + width, center.dy + bottomOffset);
    path.close();

    return path;
  }

  List<Path> _createLaunchPadPaths(
      Size size, BossLaunchPadConfig config, Offset center) {
    final leftPath = Path();
    final rightPath = Path();
    final offset = config.offset;
    final extension = config.extension;
    final depth = config.depth;

    // Left launch pad
    leftPath.moveTo(center.dx - offset, center.dy + depth * 0.5);
    leftPath.lineTo(center.dx - (offset + extension), center.dy + depth);
    leftPath.lineTo(
        center.dx - (offset + extension * 0.8), center.dy + depth * 1.5);
    leftPath.lineTo(center.dx - offset * 0.9, center.dy + depth);
    leftPath.close();

    // Right launch pad (mirrored)
    rightPath.moveTo(center.dx + offset, center.dy + depth * 0.5);
    rightPath.lineTo(center.dx + (offset + extension), center.dy + depth);
    rightPath.lineTo(
        center.dx + (offset + extension * 0.8), center.dy + depth * 1.5);
    rightPath.lineTo(center.dx + offset * 0.9, center.dy + depth);
    rightPath.close();

    return [leftPath, rightPath];
  }

  List<Path> _createHexPaths(
      Size size, BossHexPatternConfig config, Offset center) {
    final paths = <Path>[];
    final outerRadius = size.width * config.outerRadius;
    final innerRadius = size.width * config.innerRadius;

    // Outer hex
    final outerPath = Path();
    _addHexagonToPath(outerPath, center, outerRadius);
    paths.add(outerPath);

    // Inner hex
    final innerPath = Path();
    _addHexagonToPath(innerPath, center, innerRadius);
    paths.add(innerPath);

    // Connector lines
    for (var i = 0; i < config.sides; i += 2) {
      final angle = i * (2 * math.pi) / config.sides;
      final outerX = center.dx + outerRadius * math.cos(angle);
      final outerY = center.dy + outerRadius * math.sin(angle);
      final innerX = center.dx + innerRadius * math.cos(angle);
      final innerY = center.dy + innerRadius * math.sin(angle);

      final connectorPath = Path()
        ..moveTo(outerX, outerY)
        ..lineTo(innerX, innerY);
      paths.add(connectorPath);
    }

    return paths;
  }

  void _addHexagonToPath(Path path, Offset center, double radius) {
    const sides = 6;
    final angle = (2 * math.pi) / sides;

    for (var i = 0; i <= sides; i++) {
      final x = center.dx + radius * math.cos(angle * i);
      final y = center.dy + radius * math.sin(angle * i);

      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }
    path.close();
  }

  // Private shader creation methods
  ui.Shader _createShieldShader(
      Size size, BossShieldConfig config, Offset center) {
    return RadialGradient(
      center: Alignment.center,
      radius: config.gradientRadius,
      colors: config.gradientColors,
      stops: config.stops,
    ).createShader(Rect.fromCenter(
      center: center,
      width: size.width * 1.2,
      height: size.height * 1.2,
    ));
  }

  ui.Shader _createEnergyFieldShader(
      Size size, BossEnergyFieldConfig config, Offset center) {
    return RadialGradient(
      center: config.center,
      radius: config.radius,
      colors: [
        config.color.withOpacity(config.opacity),
        Colors.transparent,
      ],
    ).createShader(Rect.fromCenter(
      center: center,
      width: size.width,
      height: size.height,
    ));
  }

  ui.Shader _createBodyShader(Size size, BossBodyConfig config, Offset center) {
    return LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: config.gradientColors,
      stops: config.gradientStops,
    ).createShader(Rect.fromCenter(
      center: center,
      width: size.width,
      height: size.height,
    ));
  }

  double cos(double x) => math.cos(x);
  double sin(double x) => math.sin(x);
}
