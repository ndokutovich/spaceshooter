import 'package:flutter/material.dart';

import '../base_game_painter.dart';

class BossEnergyCircuitPainter extends BaseGamePainter {
  final List<Offset> circuitPoints;
  final double energyProgress;
  late final MaterialColor _materialColor;

  BossEnergyCircuitPainter({
    required this.circuitPoints,
    required this.energyProgress,
    Color color = Colors.purple,
    super.opacity = 1.0,
    super.enableGlow = true,
    super.glowIntensity = 15.0,
    super.glowStyle = BlurStyle.outer,
  }) : super(color: color) {
    // Convert color to MaterialColor if it isn't already
    _materialColor = color is MaterialColor
        ? color
        : Colors.purple; // Fallback to purple if not a MaterialColor
  }

  @override
  void paint(Canvas canvas, Size size) {
    if (circuitPoints.length < 2) return;

    final circuitPaint = Paint()
      ..color = _materialColor.shade300.withOpacity(0.5)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    // Draw base circuit lines
    for (var i = 0; i < circuitPoints.length - 1; i++) {
      canvas.drawLine(circuitPoints[i], circuitPoints[i + 1], circuitPaint);
    }

    // Draw energy nodes at circuit points
    final nodePaint = Paint()
      ..color = _materialColor.shade400
      ..style = PaintingStyle.fill;

    for (final point in circuitPoints) {
      canvas.drawCircle(point, 3.0, nodePaint);
    }

    // Calculate total circuit length
    double totalLength = 0;
    final segmentLengths = <double>[];
    for (var i = 0; i < circuitPoints.length - 1; i++) {
      final length = (circuitPoints[i + 1] - circuitPoints[i]).distance;
      segmentLengths.add(length);
      totalLength += length;
    }

    // Draw energy pulse effect
    if (energyProgress > 0) {
      double currentLength = 0;
      final pulsePosition = (energyProgress * totalLength) % totalLength;
      final pulsePaint = Paint()
        ..shader = RadialGradient(
          center: Alignment.center,
          radius: 0.5,
          colors: [
            _materialColor.shade300,
            _materialColor.shade300.withOpacity(0.0),
          ],
        ).createShader(Rect.fromCircle(
          center: Offset.zero,
          radius: 10.0,
        ));

      // Find current segment and draw pulse
      for (var i = 0; i < circuitPoints.length - 1; i++) {
        final segmentLength = segmentLengths[i];
        if (currentLength + segmentLength >= pulsePosition) {
          final segmentProgress =
              (pulsePosition - currentLength) / segmentLength;
          final pulsePoint = Offset.lerp(
            circuitPoints[i],
            circuitPoints[i + 1],
            segmentProgress,
          )!;

          canvas.save();
          canvas.translate(pulsePoint.dx, pulsePoint.dy);
          canvas.drawCircle(Offset.zero, 8.0, pulsePaint);
          canvas.restore();
          break;
        }
        currentLength += segmentLength;
      }

      // Draw energy flow effect
      final flowPaint = Paint()
        ..shader = LinearGradient(
          colors: [
            _materialColor.shade300.withOpacity(0.8),
            _materialColor.shade300.withOpacity(0.0),
          ],
        ).createShader(Rect.fromPoints(
          circuitPoints.first,
          circuitPoints.last,
        ))
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2.0;

      final flowPath = Path();
      flowPath.moveTo(circuitPoints.first.dx, circuitPoints.first.dy);
      for (var i = 1; i < circuitPoints.length; i++) {
        flowPath.lineTo(circuitPoints[i].dx, circuitPoints[i].dy);
      }

      canvas.drawPath(flowPath, flowPaint);
    }
  }

  @override
  bool shouldRepaint(BossEnergyCircuitPainter oldDelegate) =>
      circuitPoints != oldDelegate.circuitPoints ||
      energyProgress != oldDelegate.energyProgress ||
      super.shouldRepaint(oldDelegate);
}
