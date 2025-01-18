import 'package:flutter/material.dart';
import 'dart:math' as math;

class RoundSpaceButton extends StatefulWidget {
  final String text;
  final VoidCallback onPressed;
  final Color color;
  final double size;
  final Widget? counterWidget;
  final double fontSize;

  const RoundSpaceButton({
    super.key,
    required this.text,
    required this.onPressed,
    required this.color,
    required this.size,
    this.counterWidget,
    this.fontSize = 24,
  });

  @override
  State<RoundSpaceButton> createState() => _RoundSpaceButtonState();
}

class _RoundSpaceButtonState extends State<RoundSpaceButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  bool _isPressed = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) {
        setState(() => _isPressed = false);
        widget.onPressed();
      },
      onTapCancel: () => setState(() => _isPressed = false),
      child: SizedBox(
        width: widget.size,
        height: widget.size,
        child: Stack(
          children: [
            // Energy ring
            AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return CustomPaint(
                  painter: _EnergyRingPainter(
                    color: widget.color,
                    progress: _controller.value,
                    isPressed: _isPressed,
                  ),
                  size: Size(widget.size, widget.size),
                );
              },
            ),
            // Button text
            if (widget.text.isNotEmpty)
              Center(
                child: Text(
                  widget.text,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: widget.fontSize,
                    fontWeight: FontWeight.bold,
                    shadows: [
                      Shadow(
                        color: widget.color,
                        blurRadius: 10,
                        offset: const Offset(0, 0),
                      ),
                    ],
                  ),
                ),
              ),
            // Counter widget (if provided)
            if (widget.counterWidget != null)
              Positioned(
                right: 0,
                top: 0,
                child: widget.counterWidget!,
              ),
          ],
        ),
      ),
    );
  }
}

class _EnergyRingPainter extends CustomPainter {
  final Color color;
  final double progress;
  final bool isPressed;

  _EnergyRingPainter({
    required this.color,
    required this.progress,
    required this.isPressed,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;

    // Draw base circle with gradient
    final baseGradient = RadialGradient(
      colors: [
        color.withOpacity(0.7),
        color.withOpacity(0.3),
        color.withOpacity(0.1),
      ],
    );

    final basePaint = Paint()
      ..shader = baseGradient.createShader(
        Rect.fromCircle(center: center, radius: radius),
      )
      ..maskFilter = const MaskFilter.blur(BlurStyle.outer, 10);

    canvas.drawCircle(center, radius * 0.9, basePaint);

    // Draw rotating energy ring
    final ringPaint = Paint()
      ..color = color.withOpacity(isPressed ? 0.8 : 0.5)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 3);

    final rotationAngle = progress * 2 * math.pi;
    canvas.save();
    canvas.translate(center.dx, center.dy);
    canvas.rotate(rotationAngle);
    canvas.translate(-center.dx, -center.dy);

    // Draw energy arcs
    for (var i = 0; i < 4; i++) {
      final startAngle = (i * math.pi / 2) + math.pi / 6;
      final sweepAngle = math.pi / 3;
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius * 0.85),
        startAngle,
        sweepAngle,
        false,
        ringPaint,
      );
    }

    canvas.restore();

    // Add inner glow when pressed
    if (isPressed) {
      final glowPaint = Paint()
        ..color = color.withOpacity(0.3)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 10);
      canvas.drawCircle(center, radius * 0.7, glowPaint);
    }
  }

  @override
  bool shouldRepaint(_EnergyRingPainter oldDelegate) =>
      color != oldDelegate.color ||
      progress != oldDelegate.progress ||
      isPressed != oldDelegate.isPressed;
}
