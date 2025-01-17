import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class JoystickController extends StatefulWidget {
  final Function(Offset) onMove;

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
  static const _stickRadius = 20.0;
  static const _baseRadius = 40.0;

  void _updateStick(Offset position) {
    final delta = position - const Offset(_baseRadius, _baseRadius);
    if (delta.distance > _baseRadius) {
      _stickPosition = delta * (_baseRadius / delta.distance);
    } else {
      _stickPosition = delta;
    }
    HapticFeedback.lightImpact();
    widget.onMove(_stickPosition / _baseRadius * 5);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: _baseRadius * 2,
      height: _baseRadius * 2,
      child: GestureDetector(
        onPanStart: (details) {
          _isDragging = true;
          HapticFeedback.mediumImpact();
          final box = context.findRenderObject() as RenderBox;
          final localPosition = box.globalToLocal(details.globalPosition);
          _updateStick(localPosition);
        },
        onPanUpdate: (details) {
          if (_isDragging) {
            final box = context.findRenderObject() as RenderBox;
            final localPosition = box.globalToLocal(details.globalPosition);
            _updateStick(localPosition);
          }
        },
        onPanEnd: (_) {
          _isDragging = false;
          _stickPosition = Offset.zero;
          widget.onMove(Offset.zero);
          setState(() {});
        },
        child: CustomPaint(
          painter: JoystickPainter(
            stickPosition: _stickPosition,
            stickRadius: _stickRadius,
            baseRadius: _baseRadius,
          ),
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
      ..color =
          Colors.white.withValues(red: 255, green: 255, blue: 255, alpha: 77)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    canvas.drawCircle(center, baseRadius, basePaint);

    // Draw stick
    final stickPaint = Paint()
      ..color =
          Colors.white.withValues(red: 255, green: 255, blue: 255, alpha: 128)
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
  final String? counter;

  const ActionButton({
    super.key,
    required this.onPressed,
    required this.label,
    required this.color,
    this.counter,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) {
        HapticFeedback.heavyImpact();
        onPressed();
      },
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: color.withValues(
              red: (color.r * 255),
              green: (color.g * 255),
              blue: (color.b * 255),
              alpha: 128),
          shape: BoxShape.circle,
          border: Border.all(
            color: color,
            width: 2,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                label,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
              if (counter != null) ...[
                const SizedBox(height: 2),
                Text(
                  counter!,
                  style: TextStyle(
                    color: color,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
