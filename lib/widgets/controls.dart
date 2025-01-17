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
  static const _minSpeed = 2.0;
  static const _maxSpeed = 5.0;
  Offset? _startPosition;

  void _updateStick(Offset position) {
    final center = _startPosition ?? Offset(_baseRadius, _baseRadius);
    final delta = position - center;
    setState(() {
      if (delta.distance > _baseRadius) {
        _stickPosition = delta * (_baseRadius / delta.distance);
      } else {
        _stickPosition = delta;
      }
    });

    final distanceRatio = _stickPosition.distance / _baseRadius;
    final speedFactor = _minSpeed + (_maxSpeed - _minSpeed) * distanceRatio;

    HapticFeedback.lightImpact();
    widget.onMove(_stickPosition / _baseRadius * speedFactor);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 60.0, top: 60.0),
      child: SizedBox(
        width: _baseRadius * 2,
        height: _baseRadius * 2,
        child: GestureDetector(
          onPanStart: (details) {
            _isDragging = true;
            final box = context.findRenderObject() as RenderBox;
            _startPosition = box.globalToLocal(details.globalPosition);
            _updateStick(_startPosition!);
            HapticFeedback.mediumImpact();
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
            _startPosition = null;
            setState(() {
              _stickPosition = Offset.zero;
            });
            widget.onMove(Offset.zero);
          },
          child: CustomPaint(
            painter: JoystickPainter(
              stickPosition: _stickPosition,
              stickRadius: _stickRadius,
              baseRadius: _baseRadius,
            ),
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
