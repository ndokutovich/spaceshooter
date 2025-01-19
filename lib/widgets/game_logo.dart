import 'package:flutter/material.dart';
import 'dart:math' as math;
import '../utils/app_constants.dart';

class GameLogo extends StatefulWidget {
  final double size;

  const GameLogo({
    super.key,
    this.size = 300,
  });

  @override
  State<GameLogo> createState() => _GameLogoState();
}

class _GameLogoState extends State<GameLogo>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: SizedBox(
        width: widget.size * 1.5,
        height: widget.size * 0.3,
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return Stack(
              alignment: Alignment.center,
              children: [
                // Background energy field
                CustomPaint(
                  size: Size(widget.size * 1.5, widget.size * 0.3),
                  painter: LogoBackgroundPainter(
                    progress: _controller.value,
                  ),
                ),
                // Main text with effects
                CustomPaint(
                  size: Size(widget.size * 1.5, widget.size * 0.3),
                  painter: LogoPainter(
                    text: AppConstants.appTitle.toUpperCase(),
                    progress: _controller.value,
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class LogoBackgroundPainter extends CustomPainter {
  final double progress;

  LogoBackgroundPainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;

    // Draw energy field
    final energyPaint = Paint()
      ..shader = RadialGradient(
        center: Alignment.center,
        radius: 1.0,
        colors: [
          AppConstants.playerColor.withOpacity(0.3),
          Colors.transparent,
        ],
        stops: const [0.0, 1.0],
      ).createShader(rect);

    canvas.drawRect(rect, energyPaint);

    // Draw pulsing rings
    final ringPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    for (var i = 0; i < 3; i++) {
      final radius = (progress + i / 3) % 1.0;
      ringPaint.color =
          AppConstants.playerColor.withOpacity((1.0 - radius) * 0.3);
      canvas.drawRRect(
        RRect.fromRectAndRadius(
          rect.inflate(radius * 50),
          const Radius.circular(20),
        ),
        ringPaint,
      );
    }
  }

  @override
  bool shouldRepaint(LogoBackgroundPainter oldDelegate) =>
      progress != oldDelegate.progress;
}

class LogoPainter extends CustomPainter {
  final String text;
  final double progress;

  LogoPainter({
    required this.text,
    required this.progress,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;

    // Main text style with shadow for depth
    final textPainter = TextPainter(
      text: TextSpan(
        text: text,
        style: TextStyle(
          color: AppConstants.textColor,
          fontSize: size.height * AppConstants.logoHeightMultiplier,
          fontWeight: FontWeight.w900,
          letterSpacing: AppConstants.logoLetterSpacing * 1.5,
          height: AppConstants.logoLineHeight,
          shadows: [
            Shadow(
              color: AppConstants.playerColor
                  .withOpacity(AppConstants.logoBaseOpacity),
              offset: const Offset(0, 2),
              blurRadius: AppConstants.logoBlurRadius * 2,
            ),
            Shadow(
              color: Colors.black,
              offset: const Offset(2, 2),
              blurRadius: 4,
            ),
          ],
        ),
      ),
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center,
    );

    textPainter.layout(
      minWidth: 0,
      maxWidth: size.width,
    );

    // Center the text horizontally
    final textX = (size.width - textPainter.width) / 2;
    final textY = (size.height - textPainter.height) / 2;

    // Enhanced metallic gradient effect
    final gradientPaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Colors.white,
          AppConstants.playerColor.withOpacity(0.9),
          Colors.white.withOpacity(0.8),
          AppConstants.playerColor,
          Colors.white.withOpacity(0.6),
        ],
        stops: const [0.0, 0.3, 0.5, 0.7, 1.0],
      ).createShader(rect);

    // Draw base text with metallic effect
    canvas.saveLayer(rect, Paint());
    textPainter.paint(canvas, Offset(textX, textY));
    canvas.drawRect(rect, gradientPaint..blendMode = BlendMode.srcIn);
    canvas.restore();

    // Draw energy lines
    final linePaint = Paint()
      ..color = AppConstants.playerColor.withOpacity(0.7)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4;

    final lineY = size.height / 2;
    final lineLength = size.width * 0.25;
    final startX = size.width * 0.1 + (progress * (size.width * 0.8));

    // Enhanced horizontal energy lines
    for (var i = 0; i < 4; i++) {
      final x = (startX + i * size.width / 5) % (size.width * 0.9);
      final opacity = (1 - (x / size.width)) * AppConstants.logoMediumOpacity;
      linePaint.color = AppConstants.playerColor.withOpacity(opacity);

      if (x + lineLength <= size.width * 0.95) {
        canvas.drawLine(
          Offset(x, lineY - AppConstants.logoEnergyLineSpacing * 1.5),
          Offset(
              x + lineLength, lineY - AppConstants.logoEnergyLineSpacing * 1.5),
          linePaint,
        );
        canvas.drawLine(
          Offset(x, lineY + AppConstants.logoEnergyLineSpacing * 1.5),
          Offset(
              x + lineLength, lineY + AppConstants.logoEnergyLineSpacing * 1.5),
          linePaint,
        );
      }
    }

    // Enhanced outer glow
    final glowPaint = Paint()
      ..maskFilter =
          MaskFilter.blur(BlurStyle.outer, AppConstants.logoOuterBlurRadius)
      ..shader = RadialGradient(
        center: Alignment.center,
        radius: 0.5,
        colors: [
          AppConstants.playerColor,
          AppConstants.playerColor.withOpacity(AppConstants.logoMediumOpacity),
          Colors.transparent,
        ],
        stops: const [0.2, 0.7, 1.0],
      ).createShader(rect);

    canvas.saveLayer(rect, Paint());
    textPainter.paint(canvas, Offset(textX, textY));
    canvas.drawRect(rect, glowPaint);
    canvas.restore();

    // Tech circuit lines with animation
    final circuitPaint = Paint()
      ..color =
          AppConstants.playerColor.withOpacity(AppConstants.logoLowOpacity)
      ..style = PaintingStyle.stroke
      ..strokeWidth = AppConstants.logoStrokeWidth * 2;

    final spacing = size.width / (AppConstants.logoCircuitLines * 1.2);
    final circuitCount = (AppConstants.logoCircuitLines * 1.2).floor();

    for (var i = 0; i < circuitCount; i++) {
      final x = size.width * 0.05 + (i * spacing);
      if (x < size.width * 0.95) {
        final wave = math.sin(progress * math.pi * 2 + i * 0.5) * 1.2;
        final startY = size.height *
            (AppConstants.logoWaveBaseHeight +
                AppConstants.logoWaveAmplitude * wave);

        // Top circuits
        if (x + spacing * 0.4 <= size.width * 0.95) {
          canvas.drawPath(
            Path()
              ..moveTo(x, 0)
              ..lineTo(x, startY)
              ..lineTo(x + spacing * 0.4, startY + 8),
            circuitPaint,
          );
        }

        // Bottom circuits
        if (x + spacing * 0.4 <= size.width * 0.95) {
          canvas.drawPath(
            Path()
              ..moveTo(x, size.height)
              ..lineTo(x, size.height - startY)
              ..lineTo(x + spacing * 0.4, size.height - startY - 8),
            circuitPaint,
          );
        }
      }
    }
  }

  @override
  bool shouldRepaint(LogoPainter oldDelegate) =>
      text != oldDelegate.text || progress != oldDelegate.progress;
}
