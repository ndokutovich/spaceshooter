import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Configuration for joystick appearance and behavior
class JoystickConfig {
  final double stickRadius;
  final double baseRadius;
  final Color baseColor;
  final Color stickColor;
  final double strokeWidth;
  final bool enableHaptics;
  final double accelerationThreshold;
  final double maxSpeed;

  const JoystickConfig({
    this.stickRadius = 20.0,
    this.baseRadius = 40.0,
    this.baseColor = Colors.white,
    this.stickColor = Colors.white,
    this.strokeWidth = 2.0,
    this.enableHaptics = true,
    this.accelerationThreshold = 0.25,
    this.maxSpeed = 0.5,
  });
}

/// Configuration for action button appearance and behavior
class ActionButtonConfig {
  final double width;
  final double height;
  final double borderRadius;
  final double borderWidth;
  final double fontSize;
  final double counterFontSize;
  final bool enableHaptics;
  final HapticFeedbackType hapticType;

  const ActionButtonConfig({
    this.width = 40.0,
    this.height = 40.0,
    this.borderRadius = double.infinity,
    this.borderWidth = 2.0,
    this.fontSize = 12.0,
    this.counterFontSize = 10.0,
    this.enableHaptics = true,
    this.hapticType = HapticFeedbackType.heavy,
  });
}

class JoystickController extends StatefulWidget {
  final Function(Offset) onMove;
  final JoystickConfig config;

  const JoystickController({
    super.key,
    required this.onMove,
    this.config = const JoystickConfig(),
  });

  @override
  State<JoystickController> createState() => _JoystickControllerState();
}

class _JoystickControllerState extends State<JoystickController> {
  Offset _stickPosition = Offset.zero;
  bool _isDragging = false;

  void _updateStick(Offset position) {
    final delta =
        position - Offset(widget.config.baseRadius, widget.config.baseRadius);
    if (delta.distance > widget.config.baseRadius) {
      _stickPosition = delta * (widget.config.baseRadius / delta.distance);
    } else {
      _stickPosition = delta;
    }

    // Calculate speed multiplier based on distance from center
    final normalizedDistance =
        _stickPosition.distance / widget.config.baseRadius;
    double speedMultiplier;

    if (normalizedDistance <= widget.config.accelerationThreshold) {
      // Linear acceleration in the inner zone
      speedMultiplier =
          (normalizedDistance / widget.config.accelerationThreshold) *
              widget.config.maxSpeed;
    } else {
      // Constant max speed beyond threshold
      speedMultiplier = widget.config.maxSpeed;
    }

    // Apply the speed to the normalized direction
    final direction = _stickPosition.distance > 0
        ? _stickPosition / _stickPosition.distance
        : Offset.zero;

    // Normalize diagonal movement
    var movement = direction * speedMultiplier;
    final actualSpeed = movement.distance;
    if (actualSpeed > 0) {
      movement = movement * (speedMultiplier / actualSpeed);
    }

    if (widget.config.enableHaptics) {
      HapticFeedback.lightImpact();
    }
    widget.onMove(movement);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.config.baseRadius * 2,
      height: widget.config.baseRadius * 2,
      child: GestureDetector(
        onPanStart: (details) {
          _isDragging = true;
          if (widget.config.enableHaptics) {
            HapticFeedback.mediumImpact();
          }
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
            stickRadius: widget.config.stickRadius,
            baseRadius: widget.config.baseRadius,
            baseColor: widget.config.baseColor,
            stickColor: widget.config.stickColor,
            strokeWidth: widget.config.strokeWidth,
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
  final Color baseColor;
  final Color stickColor;
  final double strokeWidth;

  JoystickPainter({
    required this.stickPosition,
    required this.stickRadius,
    required this.baseRadius,
    required this.baseColor,
    required this.stickColor,
    required this.strokeWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(baseRadius, baseRadius);

    // Draw base
    final basePaint = Paint()
      ..color = baseColor.withOpacity(0.3)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;
    canvas.drawCircle(center, baseRadius, basePaint);

    // Draw stick
    final stickPaint = Paint()
      ..color = stickColor.withOpacity(0.5)
      ..style = PaintingStyle.fill;
    canvas.drawCircle(center + stickPosition, stickRadius, stickPaint);
  }

  @override
  bool shouldRepaint(JoystickPainter oldDelegate) =>
      stickPosition != oldDelegate.stickPosition ||
      stickRadius != oldDelegate.stickRadius ||
      baseRadius != oldDelegate.baseRadius ||
      baseColor != oldDelegate.baseColor ||
      stickColor != oldDelegate.stickColor ||
      strokeWidth != oldDelegate.strokeWidth;
}

class ActionButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String label;
  final Color color;
  final String? counter;
  final ActionButtonConfig config;

  const ActionButton({
    super.key,
    required this.onPressed,
    required this.label,
    required this.color,
    this.counter,
    this.config = const ActionButtonConfig(),
  });

  void _handleHaptic() {
    if (!config.enableHaptics) return;

    switch (config.hapticType) {
      case HapticFeedbackType.light:
        HapticFeedback.lightImpact();
        break;
      case HapticFeedbackType.medium:
        HapticFeedback.mediumImpact();
        break;
      case HapticFeedbackType.heavy:
        HapticFeedback.heavyImpact();
        break;
      case HapticFeedbackType.selection:
        HapticFeedback.selectionClick();
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) {
        _handleHaptic();
        onPressed();
      },
      child: Container(
        width: config.width,
        height: config.height,
        decoration: BoxDecoration(
          color: color.withOpacity(0.5),
          borderRadius: BorderRadius.circular(config.borderRadius),
          border: Border.all(
            color: color,
            width: config.borderWidth,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                label,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: config.fontSize,
                  fontWeight: FontWeight.bold,
                ),
              ),
              if (counter != null) ...[
                const SizedBox(height: 2),
                Text(
                  counter!,
                  style: TextStyle(
                    color: color,
                    fontSize: config.counterFontSize,
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

enum HapticFeedbackType {
  light,
  medium,
  heavy,
  selection,
}
