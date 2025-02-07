import 'package:flutter/material.dart';
import 'dart:math' as math;
import '../game_objects.dart';

class BossWidget extends StatelessWidget {
  final double healthPercentage;
  final bool isMovingRight;
  final bool isAiming;

  const BossWidget({
    super.key,
    required this.healthPercentage,
    required this.isMovingRight,
    required this.isAiming,
  });

  @override
  Widget build(BuildContext context) {
    return GameObjectWidget(
      painter: BossPainter(
        healthPercentage: healthPercentage,
        isMovingRight: isMovingRight,
        isAiming: isAiming,
      ),
      size: 200,
    );
  }
}

class BossPainter extends CustomPainter {
  final double healthPercentage;
  final bool isMovingRight;
  final bool isAiming;

  BossPainter({
    required this.healthPercentage,
    required this.isMovingRight,
    required this.isAiming,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);

    // Draw outer energy shield with enhanced hexagonal pattern
    final shieldPaint = Paint()
      ..shader = RadialGradient(
        center: const Alignment(0, 0),
        radius: 1.2,
        colors: [
          Colors.purple.withOpacity(0.0),
          Colors.purple.withOpacity(0.15),
          Colors.purple.withOpacity(0.25),
          Colors.purple.withOpacity(0.1),
        ],
        stops: const [0.0, 0.3, 0.6, 1.0],
      ).createShader(Rect.fromCenter(
        center: center,
        width: size.width * 1.2,
        height: size.height * 1.2,
      ))
      ..maskFilter = const MaskFilter.blur(BlurStyle.outer, 15);

    canvas.drawCircle(center, size.width * 0.6, shieldPaint);

    // Enhanced hexagonal shield pattern with double lines
    final hexPaint = Paint()
      ..color = Colors.purple.withOpacity(0.1)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    final innerHexPaint = Paint()
      ..color = Colors.purple.withOpacity(0.15)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    for (var i = 0; i < 6; i++) {
      final angle = i * math.pi / 3;
      final x = center.dx + math.cos(angle) * size.width * 0.5;
      final y = center.dy + math.sin(angle) * size.width * 0.5;
      final nextAngle = (i + 1) * math.pi / 3;
      final nextX = center.dx + math.cos(nextAngle) * size.width * 0.5;
      final nextY = center.dy + math.sin(nextAngle) * size.width * 0.5;

      // Outer hex
      canvas.drawLine(Offset(x, y), Offset(nextX, nextY), hexPaint);

      // Inner hex
      final innerX = center.dx + math.cos(angle) * size.width * 0.4;
      final innerY = center.dy + math.sin(angle) * size.width * 0.4;
      final nextInnerX = center.dx + math.cos(nextAngle) * size.width * 0.4;
      final nextInnerY = center.dy + math.sin(nextAngle) * size.width * 0.4;
      canvas.drawLine(
        Offset(innerX, innerY),
        Offset(nextInnerX, nextInnerY),
        innerHexPaint,
      );

      // Connect inner and outer hex
      if (i % 2 == 0) {
        canvas.drawLine(
          Offset(x, y),
          Offset(innerX, innerY),
          hexPaint..strokeWidth = 0.5,
        );
      }
    }

    // Draw background energy field
    final energyFieldPaint = Paint()
      ..shader = RadialGradient(
        center: const Alignment(0, -0.2),
        radius: 0.8,
        colors: [
          Colors.purple.withOpacity(0.1),
          Colors.transparent,
        ],
      ).createShader(Rect.fromCenter(
        center: center,
        width: size.width,
        height: size.height,
      ));

    canvas.drawRect(
      Rect.fromLTWH(0, 0, size.width, size.height),
      energyFieldPaint,
    );

    // Draw the main body with enhanced cruiser shape
    final bodyPath = Path();
    // Main hull with more detail
    bodyPath.moveTo(center.dx - 100, center.dy + 20);
    bodyPath.lineTo(center.dx - 90, center.dy - 30);
    bodyPath.lineTo(center.dx - 70, center.dy - 35);
    bodyPath.lineTo(center.dx - 60, center.dy - 40);
    bodyPath.lineTo(center.dx - 40, center.dy - 43);
    bodyPath.lineTo(center.dx - 30, center.dy - 45);
    bodyPath.lineTo(center.dx - 15, center.dy - 48);
    bodyPath.lineTo(center.dx, center.dy - 50);
    bodyPath.lineTo(center.dx + 15, center.dy - 48);
    bodyPath.lineTo(center.dx + 30, center.dy - 45);
    bodyPath.lineTo(center.dx + 40, center.dy - 43);
    bodyPath.lineTo(center.dx + 60, center.dy - 40);
    bodyPath.lineTo(center.dx + 70, center.dy - 35);
    bodyPath.lineTo(center.dx + 90, center.dy - 30);
    bodyPath.lineTo(center.dx + 100, center.dy + 20);
    // Enhanced launch pad extensions
    bodyPath.lineTo(center.dx + 110, center.dy + 25);
    bodyPath.lineTo(center.dx + 115, center.dy + 28);
    bodyPath.lineTo(center.dx + 110, center.dy + 30);
    bodyPath.lineTo(center.dx + 90, center.dy + 35);
    bodyPath.lineTo(center.dx + 80, center.dy + 40);
    bodyPath.lineTo(center.dx + 60, center.dy + 38);
    bodyPath.lineTo(center.dx + 40, center.dy + 35);
    bodyPath.lineTo(center.dx, center.dy + 30);
    bodyPath.lineTo(center.dx - 40, center.dy + 35);
    bodyPath.lineTo(center.dx - 60, center.dy + 38);
    bodyPath.lineTo(center.dx - 80, center.dy + 40);
    bodyPath.lineTo(center.dx - 90, center.dy + 35);
    bodyPath.lineTo(center.dx - 110, center.dy + 30);
    bodyPath.lineTo(center.dx - 115, center.dy + 28);
    bodyPath.lineTo(center.dx - 110, center.dy + 25);
    bodyPath.close();

    // Draw base layer with metallic effect
    final baseGradient = LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        Colors.purple.shade900,
        Colors.purple.shade800,
        Colors.purple.shade900,
      ],
      stops: const [0.0, 0.5, 1.0],
    );

    canvas.drawPath(
      bodyPath,
      Paint()
        ..shader = baseGradient.createShader(
          Rect.fromCenter(
            center: center,
            width: size.width,
            height: size.height,
          ),
        )
        ..style = PaintingStyle.fill,
    );

    // Draw overlay pattern
    final overlayPaint = Paint()
      ..color = Colors.purple.shade800.withOpacity(0.3)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.5;

    // Draw horizontal lines
    for (var i = -40; i <= 40; i += 10) {
      canvas.drawLine(
        Offset(center.dx - 100, center.dy + i),
        Offset(center.dx + 100, center.dy + i),
        overlayPaint,
      );
    }

    // Draw vertical lines
    for (var i = -100; i <= 100; i += 10) {
      canvas.drawLine(
        Offset(center.dx + i, center.dy - 40),
        Offset(center.dx + i, center.dy + 40),
        overlayPaint,
      );
    }

    // Draw enhanced launch pad details
    final launchPadPaint = Paint()
      ..color = Colors.purple.shade800
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    // Left launch pad with more detail
    final leftPadPath = Path();
    leftPadPath.moveTo(center.dx - 90, center.dy + 25);
    leftPadPath.lineTo(center.dx - 100, center.dy + 30);
    leftPadPath.lineTo(center.dx - 95, center.dy + 33);
    leftPadPath.lineTo(center.dx - 85, center.dy + 35);
    leftPadPath.lineTo(center.dx - 80, center.dy + 32);
    leftPadPath.close();
    canvas.drawPath(leftPadPath, launchPadPaint);

    // Additional left pad details
    canvas.drawLine(
      Offset(center.dx - 95, center.dy + 28),
      Offset(center.dx - 85, center.dy + 28),
      launchPadPaint..strokeWidth = 1,
    );
    canvas.drawLine(
      Offset(center.dx - 93, center.dy + 31),
      Offset(center.dx - 83, center.dy + 31),
      launchPadPaint..strokeWidth = 1,
    );

    // Right launch pad with more detail
    final rightPadPath = Path();
    rightPadPath.moveTo(center.dx + 90, center.dy + 25);
    rightPadPath.lineTo(center.dx + 100, center.dy + 30);
    rightPadPath.lineTo(center.dx + 95, center.dy + 33);
    rightPadPath.lineTo(center.dx + 85, center.dy + 35);
    rightPadPath.lineTo(center.dx + 80, center.dy + 32);
    rightPadPath.close();
    canvas.drawPath(rightPadPath, launchPadPaint);

    // Additional right pad details
    canvas.drawLine(
      Offset(center.dx + 95, center.dy + 28),
      Offset(center.dx + 85, center.dy + 28),
      launchPadPaint..strokeWidth = 1,
    );
    canvas.drawLine(
      Offset(center.dx + 93, center.dy + 31),
      Offset(center.dx + 83, center.dy + 31),
      launchPadPaint..strokeWidth = 1,
    );

    // Draw enhanced launch pad glow
    final padGlowPaint = Paint()
      ..shader = RadialGradient(
        center: const Alignment(0, 0),
        radius: 0.5,
        colors: [
          Colors.blue.shade300.withOpacity(0.6),
          Colors.blue.shade500.withOpacity(0.4),
          Colors.blue.shade700.withOpacity(0.2),
          Colors.transparent,
        ],
        stops: const [0.0, 0.3, 0.6, 1.0],
      ).createShader(Rect.fromCenter(
        center: center,
        width: 40,
        height: 40,
      ))
      ..maskFilter = const MaskFilter.blur(BlurStyle.outer, 12);

    // Left pad glow with pulse effect
    canvas.drawCircle(
      Offset(center.dx - 90, center.dy + 30),
      18,
      padGlowPaint,
    );
    canvas.drawCircle(
      Offset(center.dx - 90, center.dy + 30),
      12,
      padGlowPaint,
    );

    // Right pad glow with pulse effect
    canvas.drawCircle(
      Offset(center.dx + 90, center.dy + 30),
      18,
      padGlowPaint,
    );
    canvas.drawCircle(
      Offset(center.dx + 90, center.dy + 30),
      12,
      padGlowPaint,
    );

    // Draw enhanced armor plates
    final platePaint = Paint()
      ..color = Colors.purple.shade800
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    // Front armor plates with more detail
    for (var i = 0; i < 5; i++) {
      final platePath = Path();
      platePath.moveTo(center.dx - 40 + i * 20, center.dy - 45);
      platePath.lineTo(center.dx - 30 + i * 20, center.dy - 48);
      platePath.lineTo(center.dx - 20 + i * 20, center.dy - 45);
      platePath.close();
      canvas.drawPath(platePath, platePaint);

      // Add inner details to plates
      canvas.drawLine(
        Offset(center.dx - 35 + i * 20, center.dy - 46),
        Offset(center.dx - 25 + i * 20, center.dy - 46),
        platePaint,
      );
    }

    // Side armor plates with more detail
    for (var i = 0; i < 3; i++) {
      // Left side enhanced plates
      final leftPlatePath = Path();
      leftPlatePath.moveTo(center.dx - 90, center.dy - 25 + i * 20);
      leftPlatePath.lineTo(center.dx - 85, center.dy - 20 + i * 20);
      leftPlatePath.lineTo(center.dx - 80, center.dy - 15 + i * 20);
      leftPlatePath.lineTo(center.dx - 85, center.dy - 10 + i * 20);
      leftPlatePath.lineTo(center.dx - 90, center.dy - 5 + i * 20);
      leftPlatePath.close();
      canvas.drawPath(leftPlatePath, platePaint);

      // Add details to left plates
      canvas.drawLine(
        Offset(center.dx - 88, center.dy - 20 + i * 20),
        Offset(center.dx - 82, center.dy - 15 + i * 20),
        platePaint,
      );

      // Right side enhanced plates
      final rightPlatePath = Path();
      rightPlatePath.moveTo(center.dx + 90, center.dy - 25 + i * 20);
      rightPlatePath.lineTo(center.dx + 85, center.dy - 20 + i * 20);
      rightPlatePath.lineTo(center.dx + 80, center.dy - 15 + i * 20);
      rightPlatePath.lineTo(center.dx + 85, center.dy - 10 + i * 20);
      rightPlatePath.lineTo(center.dx + 90, center.dy - 5 + i * 20);
      rightPlatePath.close();
      canvas.drawPath(rightPlatePath, platePaint);

      // Add details to right plates
      canvas.drawLine(
        Offset(center.dx + 88, center.dy - 20 + i * 20),
        Offset(center.dx + 82, center.dy - 15 + i * 20),
        platePaint,
      );
    }

    // Draw enhanced metallic edge details
    final edgePaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Colors.purple.shade300,
          Colors.purple.shade400,
          Colors.purple.shade300,
        ],
      ).createShader(Rect.fromLTRB(0, 0, size.width, size.height))
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    canvas.drawPath(bodyPath, edgePaint);

    // Draw inner edge highlight
    final innerEdgePaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Colors.purple.shade400,
          Colors.purple.shade500,
          Colors.purple.shade400,
        ],
      ).createShader(Rect.fromLTRB(0, 0, size.width, size.height))
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;
    canvas.drawPath(bodyPath.shift(const Offset(0, -2)), innerEdgePaint);

    // Draw energy circuits connecting to launch pads
    final circuitColor =
        isAiming ? Colors.red.shade300 : Colors.purple.shade300;

    // Left side circuits
    BaseGamePainter.drawEnergyCircuit(
      canvas,
      Offset(center.dx - 60, center.dy - 20),
      Offset(center.dx - 90, center.dy + 25),
      circuitColor,
    );
    BaseGamePainter.drawEnergyCircuit(
      canvas,
      Offset(center.dx - 40, center.dy),
      Offset(center.dx - 85, center.dy + 30),
      circuitColor,
    );

    // Right side circuits
    BaseGamePainter.drawEnergyCircuit(
      canvas,
      Offset(center.dx + 60, center.dy - 20),
      Offset(center.dx + 90, center.dy + 25),
      circuitColor,
    );
    BaseGamePainter.drawEnergyCircuit(
      canvas,
      Offset(center.dx + 40, center.dy),
      Offset(center.dx + 85, center.dy + 30),
      circuitColor,
    );

    // Center circuits
    BaseGamePainter.drawEnergyCircuit(
      canvas,
      Offset(center.dx - 20, center.dy),
      Offset(center.dx, center.dy - 20),
      circuitColor,
    );
    BaseGamePainter.drawEnergyCircuit(
      canvas,
      Offset(center.dx + 20, center.dy),
      Offset(center.dx, center.dy - 20),
      circuitColor,
    );

    // Draw energy core with dynamic glow and inner details
    final corePaint = Paint()
      ..shader = RadialGradient(
        center: const Alignment(0, 0),
        radius: 0.8,
        colors: [
          isAiming ? Colors.red : Colors.purple.shade300,
          isAiming ? Colors.red.shade700 : Colors.purple.shade600,
          isAiming
              ? Colors.red.shade900.withOpacity(0.5)
              : Colors.purple.shade900.withOpacity(0.5),
        ],
      ).createShader(Rect.fromCenter(
        center: center,
        width: 80,
        height: 80,
      ))
      ..maskFilter = MaskFilter.blur(
        BlurStyle.outer,
        isAiming ? 30 : 20,
      );

    canvas.drawCircle(center, 35, corePaint);

    // Draw core inner details
    final coreDetailPaint = Paint()
      ..color = (isAiming ? Colors.red : Colors.purple).withOpacity(0.7)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    for (var i = 0; i < 4; i++) {
      final angle = i * math.pi / 2;
      canvas.drawArc(
        Rect.fromCenter(center: center, width: 40, height: 40),
        angle,
        math.pi / 4,
        false,
        coreDetailPaint,
      );
    }

    // Draw pulsing energy rings around core with more detail
    final ringPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    for (var i = 0; i < 3; i++) {
      ringPaint.color =
          (isAiming ? Colors.red : Colors.purple).withOpacity(0.3 - i * 0.1);
      canvas.drawCircle(center, 40 + i * 10, ringPaint);

      // Add small energy nodes along the rings
      const nodeCount = 8;
      for (var j = 0; j < nodeCount; j++) {
        final angle = j * 2 * math.pi / nodeCount;
        final nodeX = center.dx + math.cos(angle) * (40 + i * 10);
        final nodeY = center.dy + math.sin(angle) * (40 + i * 10);
        canvas.drawCircle(
          Offset(nodeX, nodeY),
          2,
          Paint()
            ..color = (isAiming ? Colors.red : Colors.purple).withOpacity(0.5)
            ..maskFilter = const MaskFilter.blur(BlurStyle.outer, 2),
        );
      }
    }

    // Draw enhanced engine exhausts
    final exhaustPaint = Paint()
      ..shader = RadialGradient(
        center: const Alignment(0, 0),
        radius: 0.5,
        colors: [
          Colors.blue.shade300,
          Colors.blue.shade500,
          Colors.blue.shade700.withOpacity(0.0),
        ],
      ).createShader(Rect.fromCenter(
        center: center,
        width: 40,
        height: 40,
      ))
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 15);

    final random = math.Random();
    // Main engines
    for (var i = 0; i < 3; i++) {
      final xOffset = -60 + i * 60;
      final flickerOffset = random.nextDouble() * 8;

      canvas.drawCircle(
        Offset(center.dx + xOffset, center.dy + 35),
        10 + flickerOffset,
        exhaustPaint,
      );

      canvas.drawCircle(
        Offset(center.dx + xOffset, center.dy + 35),
        5 + flickerOffset * 0.5,
        Paint()
          ..color = Colors.white.withOpacity(0.7)
          ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 5),
      );
    }

    // Launch pad thrusters
    final smallExhaustPaint = Paint()
      ..shader = RadialGradient(
        center: const Alignment(0, 0),
        radius: 0.5,
        colors: [
          Colors.blue.shade300.withOpacity(0.7),
          Colors.blue.shade500.withOpacity(0.5),
          Colors.transparent,
        ],
      ).createShader(Rect.fromCenter(
        center: center,
        width: 20,
        height: 20,
      ))
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 8);

    // Left pad thrusters
    canvas.drawCircle(
      Offset(center.dx - 95, center.dy + 38),
      6,
      smallExhaustPaint,
    );
    canvas.drawCircle(
      Offset(center.dx - 85, center.dy + 38),
      6,
      smallExhaustPaint,
    );

    // Right pad thrusters
    canvas.drawCircle(
      Offset(center.dx + 95, center.dy + 38),
      6,
      smallExhaustPaint,
    );
    canvas.drawCircle(
      Offset(center.dx + 85, center.dy + 38),
      6,
      smallExhaustPaint,
    );

    // Draw direction indicator with enhanced energy trail
    final indicatorPaint = Paint()
      ..shader = LinearGradient(
        begin: isMovingRight ? Alignment.centerRight : Alignment.centerLeft,
        end: isMovingRight ? Alignment.centerLeft : Alignment.centerRight,
        colors: [
          Colors.purple.shade300,
          Colors.purple.shade300.withOpacity(0.0),
        ],
      ).createShader(Rect.fromCenter(
        center: center,
        width: size.width,
        height: 20,
      ));

    if (isMovingRight) {
      canvas.drawPath(
        Path()
          ..moveTo(center.dx + 90, center.dy - 15)
          ..lineTo(center.dx + 120, center.dy)
          ..lineTo(center.dx + 90, center.dy + 15)
          ..close(),
        indicatorPaint,
      );
    } else {
      canvas.drawPath(
        Path()
          ..moveTo(center.dx - 90, center.dy - 15)
          ..lineTo(center.dx - 120, center.dy)
          ..lineTo(center.dx - 90, center.dy + 15)
          ..close(),
        indicatorPaint,
      );
    }

    // Draw enhanced health bar with energy effect and more detail
    const barWidth = 160.0;
    const barHeight = 12.0;
    final barRect = Rect.fromCenter(
      center: Offset(center.dx, center.dy - 60),
      width: barWidth,
      height: barHeight,
    );

    // Health bar background with enhanced pattern
    canvas.drawRect(
      barRect,
      Paint()
        ..color = Colors.grey.shade900
        ..style = PaintingStyle.fill,
    );

    // Add background pattern
    final patternPaint = Paint()
      ..color = Colors.grey.shade800
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    for (var i = 0; i < barWidth; i += 10) {
      canvas.drawLine(
        Offset(barRect.left + i, barRect.top),
        Offset(barRect.left + i + 5, barRect.bottom),
        patternPaint,
      );
    }

    // Enhanced health bar with stronger red gradient and glow
    final healthRect = Rect.fromLTWH(
      barRect.left,
      barRect.top,
      barWidth * healthPercentage,
      barHeight,
    );

    // Draw base health layer
    final baseHealthPaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Colors.red.shade900,
          Colors.red.shade700,
          Colors.red.shade900,
        ],
      ).createShader(healthRect);

    canvas.drawRect(healthRect, baseHealthPaint);

    // Draw glowing overlay
    final glowPaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Colors.red.shade300.withOpacity(0.6),
          Colors.red.shade500.withOpacity(0.4),
          Colors.red.shade300.withOpacity(0.6),
        ],
      ).createShader(healthRect)
      ..maskFilter = const MaskFilter.blur(BlurStyle.outer, 4);

    canvas.drawRect(healthRect, glowPaint);

    // Draw energy effect
    final energyPaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
        colors: [
          Colors.red.shade200.withOpacity(0.5),
          Colors.red.shade400.withOpacity(0.7),
          Colors.red.shade200.withOpacity(0.5),
        ],
      ).createShader(healthRect)
      ..maskFilter = const MaskFilter.blur(BlurStyle.inner, 2);

    canvas.drawRect(healthRect, energyPaint);

    // Add health segments with enhanced visibility
    final segmentPaint = Paint()
      ..color = Colors.white.withOpacity(0.2)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    for (var i = 1; i < 10; i++) {
      final x = barRect.left + (barWidth * i / 10);
      if (x <= barRect.left + barWidth * healthPercentage) {
        // Segments in health area
        canvas.drawLine(
          Offset(x, barRect.top),
          Offset(x, barRect.bottom),
          segmentPaint,
        );
      } else {
        // Segments in empty area
        canvas.drawLine(
          Offset(x, barRect.top),
          Offset(x, barRect.bottom),
          Paint()
            ..color = Colors.black.withOpacity(0.3)
            ..style = PaintingStyle.stroke
            ..strokeWidth = 1,
        );
      }
    }

    // Health bar border with enhanced glow
    canvas.drawRect(
      barRect,
      Paint()
        ..color = Colors.white.withOpacity(0.4)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2
        ..maskFilter = const MaskFilter.blur(BlurStyle.outer, 3),
    );

    // Add corner accents to health bar with enhanced visibility
    final cornerPaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Colors.white.withOpacity(0.8),
          Colors.white.withOpacity(0.4),
        ],
      ).createShader(barRect)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    const cornerSize = 5.0;
    // Top left
    canvas.drawLine(
      Offset(barRect.left, barRect.top + cornerSize),
      Offset(barRect.left, barRect.top),
      cornerPaint,
    );
    canvas.drawLine(
      Offset(barRect.left, barRect.top),
      Offset(barRect.left + cornerSize, barRect.top),
      cornerPaint,
    );
    // Top right
    canvas.drawLine(
      Offset(barRect.right - cornerSize, barRect.top),
      Offset(barRect.right, barRect.top),
      cornerPaint,
    );
    canvas.drawLine(
      Offset(barRect.right, barRect.top),
      Offset(barRect.right, barRect.top + cornerSize),
      cornerPaint,
    );
    // Bottom left
    canvas.drawLine(
      Offset(barRect.left, barRect.bottom - cornerSize),
      Offset(barRect.left, barRect.bottom),
      cornerPaint,
    );
    canvas.drawLine(
      Offset(barRect.left, barRect.bottom),
      Offset(barRect.left + cornerSize, barRect.bottom),
      cornerPaint,
    );
    // Bottom right
    canvas.drawLine(
      Offset(barRect.right - cornerSize, barRect.bottom),
      Offset(barRect.right, barRect.bottom),
      cornerPaint,
    );
    canvas.drawLine(
      Offset(barRect.right, barRect.bottom - cornerSize),
      Offset(barRect.right, barRect.bottom),
      cornerPaint,
    );
  }

  @override
  bool shouldRepaint(BossPainter oldDelegate) =>
      healthPercentage != oldDelegate.healthPercentage ||
      isMovingRight != oldDelegate.isMovingRight ||
      isAiming != oldDelegate.isAiming;
}
