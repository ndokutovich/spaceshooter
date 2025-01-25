import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:math' as math;

class JoystickController extends StatefulWidget {
  final Function(double dx, double dy) onMove;

  const JoystickController({
    super.key,
    required this.onMove,
  });

  @override
  State<JoystickController> createState() => _JoystickControllerState();
}

class _JoystickControllerState extends State<JoystickController> {
  Offset _stickPosition = Offset.zero;
  bool _isDragging = false;
  static const double _size = 120.0;
  static const double _innerCircleSize = 50.0;

  void _updateStickPosition(Offset position) {
    final RenderBox renderBox = context.findRenderObject() as RenderBox;
    final center = renderBox.size.center(Offset.zero);
    var stickOffset = position - renderBox.localToGlobal(center);

    final distance = stickOffset.distance;
    final maxDistance = _size / 2 - _innerCircleSize / 2;

    if (distance > maxDistance) {
      stickOffset = stickOffset * (maxDistance / distance);
    }

    setState(() {
      _stickPosition = stickOffset;
    });

    // Calculate movement values
    final dx = stickOffset.dx / maxDistance;
    final dy = stickOffset.dy / maxDistance;
    widget.onMove(dx, dy);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: _size,
      height: _size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white.withOpacity(0.1),
        border: Border.all(
          color: Colors.white.withOpacity(0.3),
          width: 2,
        ),
      ),
      child: GestureDetector(
        onPanStart: (details) {
          _isDragging = true;
          _updateStickPosition(details.globalPosition);
        },
        onPanUpdate: (details) {
          if (_isDragging) {
            _updateStickPosition(details.globalPosition);
          }
        },
        onPanEnd: (details) {
          _isDragging = false;
          setState(() {
            _stickPosition = Offset.zero;
          });
          widget.onMove(0, 0);
        },
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: _innerCircleSize,
              height: _innerCircleSize,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withOpacity(0.5),
              ),
            ),
            if (_isDragging)
              Transform.translate(
                offset: _stickPosition,
                child: Container(
                  width: _innerCircleSize,
                  height: _innerCircleSize,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white.withOpacity(0.8),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class JoystickPainter extends CustomPainter {
  final Offset stickPosition;
  final double stickRadius;
  final double baseRadius;

  JoystickPainter({
    required this.stickPosition,
    required this.stickRadius,
    required this.baseRadius,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(baseRadius, baseRadius);

    // Draw base
    final basePaint = Paint()
      ..color = Colors.white.withOpacity(0.3)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    canvas.drawCircle(center, baseRadius, basePaint);

    // Draw stick
    final stickPaint = Paint()
      ..color = Colors.white.withOpacity(0.5)
      ..style = PaintingStyle.fill;
    canvas.drawCircle(center + stickPosition, stickRadius, stickPaint);
  }

  @override
  bool shouldRepaint(JoystickPainter oldDelegate) =>
      stickPosition != oldDelegate.stickPosition;
}

class ActionButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String label;
  final Color color;
  final Widget? counterWidget;
  final String? counterText;

  const ActionButton({
    super.key,
    required this.onPressed,
    required this.label,
    required this.color,
    this.counterWidget,
    this.counterText,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) {
        HapticFeedback.mediumImpact();
        onPressed();
      },
      child: Container(
        width: 80,
        height: 80,
        decoration: BoxDecoration(
          color: color.withOpacity(0.3),
          borderRadius: BorderRadius.circular(25),
          border: Border.all(color: color),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            if (counterWidget != null) ...[
              const SizedBox(height: 4),
              counterWidget!,
            ] else if (counterText != null) ...[
              const SizedBox(height: 4),
              Text(
                counterText!,
                style: TextStyle(
                  color: color,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
