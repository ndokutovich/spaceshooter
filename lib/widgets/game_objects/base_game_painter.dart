import 'package:flutter/material.dart';

/// Base painter class for all game objects
abstract class BaseGamePainter extends CustomPainter {
  final Color color;
  final double opacity;
  final bool enableGlow;
  final double glowIntensity;
  final BlurStyle glowStyle;

  const BaseGamePainter({
    this.color = Colors.white,
    this.opacity = 1.0,
    this.enableGlow = false,
    this.glowIntensity = 5.0,
    this.glowStyle = BlurStyle.outer,
  });

  /// Creates a paint object with common settings
  Paint createPaint({
    Color? overrideColor,
    double? overrideOpacity,
    PaintingStyle style = PaintingStyle.fill,
    bool withGlow = false,
  }) {
    final paint = Paint()
      ..color = (overrideColor ?? color).withOpacity(overrideOpacity ?? opacity)
      ..style = style;

    if (withGlow && enableGlow) {
      paint.maskFilter = MaskFilter.blur(glowStyle, glowIntensity);
    }

    return paint;
  }

  /// Creates a gradient paint with common settings
  Paint createGradientPaint({
    required Rect bounds,
    required List<Color> colors,
    List<double>? stops,
    bool radial = true,
    bool withGlow = false,
  }) {
    final paint = Paint()
      ..shader = (radial
              ? RadialGradient(colors: colors, stops: stops)
              : LinearGradient(colors: colors, stops: stops))
          .createShader(bounds);

    if (withGlow && enableGlow) {
      paint.maskFilter = MaskFilter.blur(glowStyle, glowIntensity);
    }

    return paint;
  }

  /// Helper method to draw text with consistent styling
  void drawText(
    Canvas canvas,
    String text,
    Offset position, {
    required double fontSize,
    FontWeight fontWeight = FontWeight.bold,
    Color? textColor,
    List<Shadow>? shadows,
    TextAlign align = TextAlign.center,
  }) {
    final textPainter = TextPainter(
      text: TextSpan(
        text: text,
        style: TextStyle(
          color: textColor ?? color,
          fontSize: fontSize,
          fontWeight: fontWeight,
          shadows: shadows,
        ),
      ),
      textDirection: TextDirection.ltr,
      textAlign: align,
    );

    textPainter.layout();
    textPainter.paint(canvas, position);
  }

  @override
  bool shouldRepaint(covariant BaseGamePainter oldDelegate) =>
      color != oldDelegate.color ||
      opacity != oldDelegate.opacity ||
      enableGlow != oldDelegate.enableGlow ||
      glowIntensity != oldDelegate.glowIntensity ||
      glowStyle != oldDelegate.glowStyle;

  // Add the drawEnergyCircuit method
  static void drawEnergyCircuit(
      Canvas canvas, Offset start, Offset end, Color color) {
    final circuitPaint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2
      ..maskFilter = const MaskFilter.blur(BlurStyle.outer, 2);

    canvas.drawLine(start, end, circuitPaint);

    // Draw energy nodes at endpoints
    final nodePaint = Paint()
      ..color = color
      ..style = PaintingStyle.fill
      ..maskFilter = const MaskFilter.blur(BlurStyle.outer, 4);

    canvas.drawCircle(start, 3, nodePaint);
    canvas.drawCircle(end, 3, nodePaint);
  }
}
