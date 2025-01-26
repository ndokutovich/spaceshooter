import 'package:flutter/material.dart';
import 'dart:math' as math;

/// Base painter class for game objects with common painting utilities
abstract class BaseGamePainter extends CustomPainter {
  // Common properties
  final Color color;
  final double opacity;
  final bool useGlow;
  final double glowIntensity;

  const BaseGamePainter({
    this.color = Colors.white,
    this.opacity = 1.0,
    this.useGlow = false,
    this.glowIntensity = 2.0,
  });

  /// Creates a basic paint object with common properties
  Paint createPaint({
    Color? overrideColor,
    double? overrideOpacity,
    PaintingStyle style = PaintingStyle.fill,
    double? strokeWidth,
    MaskFilter? maskFilter,
  }) {
    final paint = Paint()
      ..color = (overrideColor ?? color).withOpacity(overrideOpacity ?? opacity)
      ..style = style;

    if (strokeWidth != null) {
      paint.strokeWidth = strokeWidth;
    }

    if (useGlow && maskFilter == null) {
      paint.maskFilter = MaskFilter.blur(BlurStyle.outer, glowIntensity);
    } else if (maskFilter != null) {
      paint.maskFilter = maskFilter;
    }

    return paint;
  }

  /// Creates a gradient paint with common properties
  Paint createGradientPaint({
    required List<Color> colors,
    required List<double> stops,
    required Rect bounds,
    bool radial = false,
    Alignment? center,
    double? radius,
  }) {
    final paint = Paint();

    if (radial) {
      paint.shader = RadialGradient(
        center: center ?? Alignment.center,
        radius: radius ?? 1.0,
        colors: colors,
        stops: stops,
      ).createShader(bounds);
    } else {
      paint.shader = LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: colors,
        stops: stops,
      ).createShader(bounds);
    }

    if (useGlow) {
      paint.maskFilter = MaskFilter.blur(BlurStyle.outer, glowIntensity);
    }

    return paint;
  }

  /// Draws text with consistent styling
  void drawGameText(
    Canvas canvas,
    String text,
    Offset position, {
    double fontSize = 16,
    FontWeight fontWeight = FontWeight.bold,
    TextAlign align = TextAlign.center,
  }) {
    final textPainter = TextPainter(
      text: TextSpan(
        text: text,
        style: TextStyle(
          color: color.withOpacity(opacity),
          fontSize: fontSize,
          fontWeight: fontWeight,
        ),
      ),
      textDirection: TextDirection.ltr,
      textAlign: align,
    )..layout();

    textPainter.paint(
      canvas,
      position.translate(-textPainter.width / 2, -textPainter.height / 2),
    );
  }

  /// Draws an energy circuit effect between two points
  void drawEnergyCircuit(
    Canvas canvas,
    Offset start,
    Offset end, {
    Color? overrideColor,
    double strokeWidth = 2,
    double blurRadius = 2,
    double nodeRadius = 3,
    double nodeBlurRadius = 4,
  }) {
    final circuitPaint = createPaint(
      overrideColor: overrideColor,
      style: PaintingStyle.stroke,
      strokeWidth: strokeWidth,
      maskFilter: MaskFilter.blur(BlurStyle.outer, blurRadius),
    );

    canvas.drawLine(start, end, circuitPaint);

    final nodePaint = createPaint(
      overrideColor: overrideColor,
      style: PaintingStyle.fill,
      maskFilter: MaskFilter.blur(BlurStyle.outer, nodeBlurRadius),
    );

    canvas.drawCircle(start, nodeRadius, nodePaint);
    canvas.drawCircle(end, nodeRadius, nodePaint);
  }

  /// Draws a regular polygon with specified number of sides
  void drawRegularPolygon(
    Canvas canvas,
    Offset center,
    double radius,
    int sides, {
    double rotation = 0,
    Paint? paint,
  }) {
    final path = Path();
    final angle = (2 * math.pi) / sides;

    for (var i = 0; i <= sides; i++) {
      final currentAngle = angle * i + rotation;
      final x = center.dx + radius * math.cos(currentAngle);
      final y = center.dy + radius * math.sin(currentAngle);

      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }

    path.close();
    canvas.drawPath(path, paint ?? createPaint());
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    if (oldDelegate is BaseGamePainter) {
      return color != oldDelegate.color ||
          opacity != oldDelegate.opacity ||
          useGlow != oldDelegate.useGlow ||
          glowIntensity != oldDelegate.glowIntensity;
    }
    return true;
  }
}
