import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../utils/constants/style_constants.dart';
import '../utils/constants/ui_constants.dart';

class MenuButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final double? width;
  final double? height;

  const MenuButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final fontSize = screenSize.width * 0.02; // 2% of screen width for text

    return GestureDetector(
      onTapDown: (_) => onPressed(),
      child: Container(
        width: width ?? UIConstants.menuButtonWidth,
        height: height ?? UIConstants.menuButtonHeight,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              StyleConstants.playerColor
                  .withOpacity(StyleConstants.opacityHigh),
              StyleConstants.playerColor.withOpacity(StyleConstants.opacityLow),
            ],
          ),
          borderRadius: BorderRadius.circular(UIConstants.menuButtonRadius),
          border: Border.all(
            color: StyleConstants.playerColor,
            width: 2,
          ),
          boxShadow: [
            BoxShadow(
              color: StyleConstants.playerColor
                  .withOpacity(StyleConstants.opacityMedium),
              blurRadius: 10,
              spreadRadius: 2,
            ),
          ],
        ),
        child: Stack(
          children: [
            // Energy field effect
            Container(
              decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.circular(UIConstants.menuButtonRadius),
                gradient: RadialGradient(
                  center: Alignment.topLeft,
                  radius: 1.5,
                  colors: [
                    Colors.white.withOpacity(StyleConstants.opacityLow),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
            // Button text
            Center(
              child: Text(
                text,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: StyleConstants.textColor,
                  fontSize: fontSize,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.3,
                  height: 1.0,
                  shadows: [
                    Shadow(
                      color: StyleConstants.playerColor,
                      blurRadius: 10,
                    ),
                  ],
                ),
              ),
            ),
            // Side accents
            Positioned(
              left:
                  (width ?? UIConstants.menuButtonWidth) * 0.05, // 5% from left
              top: (height ?? UIConstants.menuButtonHeight) *
                  0.2, // Center vertically
              bottom: (height ?? UIConstants.menuButtonHeight) *
                  0.2, // Center vertically
              child: Center(
                child: CustomPaint(
                  painter: AccentPainter(StyleConstants.playerColor),
                  size: Size(
                    (width ?? UIConstants.menuButtonWidth) *
                        0.06, // 6% of width
                    (height ?? UIConstants.menuButtonHeight) *
                        0.6, // 60% of height
                  ),
                ),
              ),
            ),
            Positioned(
              right: (width ?? UIConstants.menuButtonWidth) *
                  0.05, // 5% from right
              top: (height ?? UIConstants.menuButtonHeight) *
                  0.2, // Center vertically
              bottom: (height ?? UIConstants.menuButtonHeight) *
                  0.2, // Center vertically
              child: Center(
                child: CustomPaint(
                  painter: AccentPainter(StyleConstants.playerColor),
                  size: Size(
                    (width ?? UIConstants.menuButtonWidth) *
                        0.06, // 6% of width
                    (height ?? UIConstants.menuButtonHeight) *
                        0.6, // 60% of height
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SpaceButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color color;
  final Widget? counterWidget;
  final double width;
  final double height;
  final double fontSize;

  const SpaceButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.color = StyleConstants.playerColor,
    this.counterWidget,
    this.width = 60,
    this.height = 60,
    this.fontSize = 16,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => onPressed(),
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              color.withOpacity(StyleConstants.opacityHigh),
              color.withOpacity(StyleConstants.opacityLow),
            ],
          ),
          borderRadius: BorderRadius.circular(height / 3),
          border: Border.all(
            color: color,
            width: 2,
          ),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(StyleConstants.opacityMedium),
              blurRadius: 5,
              spreadRadius: 1,
            ),
          ],
        ),
        child: Stack(
          children: [
            // Energy field effect
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(height / 3),
                gradient: RadialGradient(
                  center: Alignment.topLeft,
                  radius: 1.5,
                  colors: [
                    Colors.white.withOpacity(StyleConstants.opacityLow),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
            // Content
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    text,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: StyleConstants.textColor,
                      fontSize: fontSize,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.3,
                      height: 1.0,
                      shadows: [
                        Shadow(
                          color: color,
                          blurRadius: 5,
                        ),
                      ],
                    ),
                  ),
                  if (counterWidget != null) ...[
                    const SizedBox(height: 4),
                    counterWidget!,
                  ],
                ],
              ),
            ),
            // Side accents
            Positioned(
              left: 5,
              top: (height - 20) / 2,
              child: CustomPaint(
                painter: AccentPainter(color),
                size: const Size(10, 20),
              ),
            ),
            Positioned(
              right: 5,
              top: (height - 20) / 2,
              child: CustomPaint(
                painter: AccentPainter(color),
                size: const Size(10, 20),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class RoundSpaceButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color color;
  final Widget? counterWidget;
  final double size;
  final double fontSize;

  const RoundSpaceButton({
    super.key,
    required this.text,
    required this.onPressed,
    required this.color,
    this.counterWidget,
    this.size = 80,
    this.fontSize = 16,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => onPressed(),
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: RadialGradient(
            center: Alignment.topLeft,
            radius: 1.2,
            colors: [
              color.withOpacity(0.8),
              color.withOpacity(0.3),
            ],
          ),
          border: Border.all(
            color: color,
            width: 2,
          ),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.5),
              blurRadius: 10,
              spreadRadius: 2,
            ),
          ],
        ),
        child: Stack(
          children: [
            // Energy field effect
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  center: Alignment.topLeft,
                  radius: 1.0,
                  colors: [
                    Colors.white.withOpacity(0.4),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
            // Rotating energy ring
            Center(
              child: SizedBox(
                width: size * 0.9,
                height: size * 0.9,
                child: CustomPaint(
                  painter: EnergyRingPainter(color),
                ),
              ),
            ),
            // Content
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    text,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: StyleConstants.textColor,
                      fontSize: fontSize,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.3,
                      height: 1.0,
                      shadows: const [
                        Shadow(
                          color: StyleConstants.playerColor,
                          blurRadius: 10,
                        ),
                      ],
                    ),
                  ),
                  if (counterWidget != null) ...[
                    const SizedBox(height: 4),
                    counterWidget!,
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class EnergyRingPainter extends CustomPainter {
  final Color color;

  EnergyRingPainter(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color.withOpacity(0.5)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    // Draw multiple concentric circles with gaps
    for (var i = 0; i < 3; i++) {
      final radius = size.width * (0.5 - i * 0.1);
      canvas.drawCircle(
        Offset(size.width / 2, size.height / 2),
        radius,
        paint,
      );
    }

    // Draw energy arcs
    final arcPaint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3;

    const startAngle = -math.pi / 4;
    const sweepAngle = math.pi / 2;

    for (var i = 0; i < 4; i++) {
      final radius = size.width * 0.45;
      canvas.save();
      canvas.translate(size.width / 2, size.height / 2);
      canvas.rotate(i * math.pi / 2);
      canvas.drawArc(
        Rect.fromCircle(
          center: Offset.zero,
          radius: radius,
        ),
        startAngle,
        sweepAngle,
        false,
        arcPaint,
      );
      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(EnergyRingPainter oldDelegate) =>
      color != oldDelegate.color;
}

class AccentPainter extends CustomPainter {
  final Color color;

  AccentPainter(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    final path = Path();

    // Draw rhombus with equal proportions
    path.moveTo(0, size.height / 2); // Left point
    path.lineTo(size.width / 2, 0); // Top point
    path.lineTo(size.width, size.height / 2); // Right point
    path.lineTo(size.width / 2, size.height); // Bottom point
    path.close(); // Connect back to start

    canvas.drawPath(path, paint);

    // Add inner glow
    final glowPaint = Paint()
      ..color = color.withOpacity(0.3)
      ..style = PaintingStyle.fill;
    canvas.drawPath(path, glowPaint);
  }

  @override
  bool shouldRepaint(AccentPainter oldDelegate) => color != oldDelegate.color;
}
