import 'package:flutter/material.dart';

class PlayerShipPainter extends CustomPainter {
  final Color primaryColor;
  final Color accentColor;
  final double _random = DateTime.now().millisecondsSinceEpoch % 100 / 100;

  PlayerShipPainter({
    this.primaryColor = Colors.blue,
    this.accentColor = Colors.lightBlueAccent,
  });

  void _drawEnergyCircuit(
      Canvas canvas, Offset start, Offset end, Color color) {
    final circuitPaint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5
      ..maskFilter = const MaskFilter.blur(BlurStyle.outer, 2);

    canvas.drawLine(start, end, circuitPaint);

    // Draw energy nodes at endpoints
    final nodePaint = Paint()
      ..color = color
      ..style = PaintingStyle.fill
      ..maskFilter = const MaskFilter.blur(BlurStyle.outer, 3);

    canvas.drawCircle(start, 2, nodePaint);
    canvas.drawCircle(end, 2, nodePaint);
  }

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);

    // Draw energy shield with enhanced hexagonal pattern
    final shieldPaint = Paint()
      ..shader = RadialGradient(
        center: const Alignment(0, 0),
        radius: 1.2,
        colors: [
          accentColor.withOpacity(0.0),
          accentColor.withOpacity(0.1),
          accentColor.withOpacity(0.2),
          accentColor.withOpacity(0.0),
        ],
        stops: const [0.0, 0.3, 0.6, 1.0],
      ).createShader(Rect.fromCenter(
        center: center,
        width: size.width * 1.2,
        height: size.height * 1.2,
      ))
      ..maskFilter = const MaskFilter.blur(BlurStyle.outer, 10);

    canvas.drawCircle(center, size.width * 0.5, shieldPaint);

    // Main hull with enhanced hexagonal pattern
    final path = Path();
    // More angular and aggressive shape
    path.moveTo(size.width * 0.5, 0); // Top point
    path.lineTo(size.width * 0.65, size.height * 0.15); // Right upper wing
    path.lineTo(size.width * 0.85, size.height * 0.3); // Right wing tip
    path.lineTo(size.width * 0.7, size.height * 0.4); // Right wing indent
    path.lineTo(size.width * 0.75, size.height * 0.6); // Right lower wing
    path.lineTo(size.width * 0.6, size.height * 0.5); // Right hull indent
    path.lineTo(size.width * 0.5, size.height * 0.7); // Bottom point
    path.lineTo(size.width * 0.4, size.height * 0.5); // Left hull indent
    path.lineTo(size.width * 0.25, size.height * 0.6); // Left lower wing
    path.lineTo(size.width * 0.3, size.height * 0.4); // Left wing indent
    path.lineTo(size.width * 0.15, size.height * 0.3); // Left wing tip
    path.lineTo(size.width * 0.35, size.height * 0.15); // Left upper wing
    path.close();

    // Draw base layer with metallic effect
    final baseGradient = LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        primaryColor.withOpacity(0.9),
        primaryColor,
        primaryColor.withOpacity(0.8),
      ],
      stops: const [0.0, 0.5, 1.0],
    );

    canvas.drawPath(
      path,
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

    // Draw enhanced armor plates
    final platePaint = Paint()
      ..color = primaryColor.withOpacity(0.7)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    // Front armor plates
    for (var i = 0; i < 3; i++) {
      final platePath = Path();
      platePath.moveTo(size.width * (0.4 + i * 0.05), size.height * 0.2);
      platePath.lineTo(size.width * (0.6 - i * 0.05), size.height * 0.2);
      platePath.lineTo(size.width * (0.55 - i * 0.03), size.height * 0.3);
      platePath.lineTo(size.width * (0.45 + i * 0.03), size.height * 0.3);
      platePath.close();
      canvas.drawPath(platePath, platePaint);

      // Add inner details to plates
      canvas.drawLine(
        Offset(size.width * (0.45 + i * 0.04), size.height * 0.25),
        Offset(size.width * (0.55 - i * 0.04), size.height * 0.25),
        platePaint,
      );
    }

    // Side armor plates
    for (var i = 0; i < 2; i++) {
      // Left side plates
      final leftPlatePath = Path();
      leftPlatePath.moveTo(size.width * 0.2, size.height * (0.35 + i * 0.15));
      leftPlatePath.lineTo(size.width * 0.3, size.height * (0.4 + i * 0.15));
      leftPlatePath.lineTo(size.width * 0.25, size.height * (0.45 + i * 0.15));
      leftPlatePath.close();
      canvas.drawPath(leftPlatePath, platePaint);

      // Right side plates
      final rightPlatePath = Path();
      rightPlatePath.moveTo(size.width * 0.8, size.height * (0.35 + i * 0.15));
      rightPlatePath.lineTo(size.width * 0.7, size.height * (0.4 + i * 0.15));
      rightPlatePath.lineTo(size.width * 0.75, size.height * (0.45 + i * 0.15));
      rightPlatePath.close();
      canvas.drawPath(rightPlatePath, platePaint);
    }

    // Draw energy circuits
    final circuitColor = accentColor.withOpacity(0.8);

    // Left side circuits
    _drawEnergyCircuit(
      canvas,
      Offset(size.width * 0.3, size.height * 0.3),
      Offset(size.width * 0.4, size.height * 0.4),
      circuitColor,
    );
    _drawEnergyCircuit(
      canvas,
      Offset(size.width * 0.2, size.height * 0.4),
      Offset(size.width * 0.3, size.height * 0.5),
      circuitColor,
    );

    // Right side circuits
    _drawEnergyCircuit(
      canvas,
      Offset(size.width * 0.7, size.height * 0.3),
      Offset(size.width * 0.6, size.height * 0.4),
      circuitColor,
    );
    _drawEnergyCircuit(
      canvas,
      Offset(size.width * 0.8, size.height * 0.4),
      Offset(size.width * 0.7, size.height * 0.5),
      circuitColor,
    );

    // Enhanced cockpit with crystal effect
    final cockpitPath = Path();
    cockpitPath.moveTo(size.width * 0.5, size.height * 0.15);
    cockpitPath.lineTo(size.width * 0.6, size.height * 0.25);
    cockpitPath.lineTo(size.width * 0.5, size.height * 0.35);
    cockpitPath.lineTo(size.width * 0.4, size.height * 0.25);
    cockpitPath.close();

    // Cockpit gradient with enhanced crystal effect
    final cockpitGradient = LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        Colors.white.withOpacity(0.9),
        accentColor.withOpacity(0.7),
        accentColor.withOpacity(0.4),
        Colors.white.withOpacity(0.6),
      ],
      stops: const [0.0, 0.3, 0.7, 1.0],
    );

    canvas.drawPath(
      cockpitPath,
      Paint()
        ..shader = cockpitGradient.createShader(
          Rect.fromLTWH(
            size.width * 0.35,
            size.height * 0.15,
            size.width * 0.3,
            size.height * 0.2,
          ),
        ),
    );

    // Add cockpit glow
    canvas.drawPath(
      cockpitPath,
      Paint()
        ..color = accentColor.withOpacity(0.5)
        ..maskFilter = const MaskFilter.blur(BlurStyle.outer, 4),
    );

    // Enhanced engine effects with blinking
    final engineGradient = LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        Colors.white,
        Colors.white.withOpacity(0.9 + _random * 0.1),
        accentColor.withOpacity(0.8 + _random * 0.2),
        primaryColor.withOpacity(0.4 + _random * 0.3),
      ],
      stops: const [0.0, 0.2, 0.5, 1.0],
    );

    final enginePaint = Paint()
      ..shader = engineGradient.createShader(
        Rect.fromLTWH(
          size.width * 0.3,
          size.height * 0.5,
          size.width * 0.4,
          size.height * 0.5,
        ),
      )
      ..maskFilter = const MaskFilter.blur(BlurStyle.outer, 25);

    // Triple engine design with enhanced blinking effects
    for (var i = 0; i < 3; i++) {
      final enginePath = Path();
      final xOffset = 0.4 + (i * 0.1);
      final flicker = _random * 0.15; // Increased flicker effect

      // Main thruster flame - made larger
      enginePath.moveTo(size.width * xOffset, size.height * 0.5);
      enginePath.quadraticBezierTo(
        size.width * (xOffset + 0.06),
        size.height * (0.7 + flicker),
        size.width * xOffset,
        size.height * (0.9 + flicker),
      );
      enginePath.quadraticBezierTo(
        size.width * (xOffset - 0.06),
        size.height * (0.7 + flicker),
        size.width * xOffset,
        size.height * 0.5,
      );
      canvas.drawPath(enginePath, enginePaint);

      // Add engine core glow with enhanced blinking
      final coreSize = 0.04 + _random * 0.02;
      canvas.drawCircle(
        Offset(size.width * xOffset, size.height * 0.55),
        size.width * coreSize,
        Paint()
          ..color = Colors.white
          ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 12),
      );

      // Inner core with more intense glow
      canvas.drawCircle(
        Offset(size.width * xOffset, size.height * 0.55),
        size.width * (coreSize * 0.6),
        Paint()
          ..color = Colors.white
          ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 8),
      );

      // Additional flame effect with enhanced visibility
      final flamePath = Path();
      flamePath.moveTo(size.width * xOffset, size.height * 0.55);
      flamePath.quadraticBezierTo(
        size.width * (xOffset + 0.04),
        size.height * (0.75 + flicker),
        size.width * xOffset,
        size.height * (0.95 + flicker),
      );
      flamePath.quadraticBezierTo(
        size.width * (xOffset - 0.04),
        size.height * (0.75 + flicker),
        size.width * xOffset,
        size.height * 0.55,
      );
      canvas.drawPath(
        flamePath,
        Paint()
          ..shader = RadialGradient(
            center: Alignment.topCenter,
            radius: 1.0,
            colors: [
              Colors.white,
              Colors.white.withOpacity(0.9),
              accentColor.withOpacity(0.7 + _random * 0.3),
              Colors.transparent,
            ],
            stops: const [0.0, 0.2, 0.6, 1.0],
          ).createShader(Rect.fromLTWH(
            size.width * (xOffset - 0.06),
            size.height * 0.5,
            size.width * 0.12,
            size.height * 0.5,
          ))
          ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 8),
      );
    }

    // Draw metallic edge details
    final edgePaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Colors.white.withOpacity(0.7),
          accentColor.withOpacity(0.5),
          Colors.white.withOpacity(0.7),
        ],
      ).createShader(Rect.fromLTRB(0, 0, size.width, size.height))
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;
    canvas.drawPath(path, edgePaint);
  }

  @override
  bool shouldRepaint(PlayerShipPainter oldDelegate) =>
      true; // Always repaint for thruster animation
}

class EnemyShipPainter extends CustomPainter {
  final Color primaryColor;
  final Color accentColor;
  final double _random = DateTime.now().millisecondsSinceEpoch % 100 / 100;

  EnemyShipPainter({
    this.primaryColor = Colors.red,
    this.accentColor = Colors.redAccent,
  });

  void _drawEnergyCircuit(
      Canvas canvas, Offset start, Offset end, Color color) {
    final circuitPaint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5
      ..maskFilter = const MaskFilter.blur(BlurStyle.outer, 2);

    canvas.drawLine(start, end, circuitPaint);

    // Draw energy nodes at endpoints
    final nodePaint = Paint()
      ..color = color
      ..style = PaintingStyle.fill
      ..maskFilter = const MaskFilter.blur(BlurStyle.outer, 3);

    canvas.drawCircle(start, 2, nodePaint);
    canvas.drawCircle(end, 2, nodePaint);
  }

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);

    // Draw energy shield with enhanced hexagonal pattern
    final shieldPaint = Paint()
      ..shader = RadialGradient(
        center: const Alignment(0, 0),
        radius: 1.2,
        colors: [
          accentColor.withOpacity(0.0),
          accentColor.withOpacity(0.1),
          accentColor.withOpacity(0.2),
          accentColor.withOpacity(0.0),
        ],
        stops: const [0.0, 0.3, 0.6, 1.0],
      ).createShader(Rect.fromCenter(
        center: center,
        width: size.width * 1.2,
        height: size.height * 1.2,
      ))
      ..maskFilter = const MaskFilter.blur(BlurStyle.outer, 10);

    canvas.drawCircle(center, size.width * 0.5, shieldPaint);

    // Main hull with enhanced alien design
    final path = Path();
    // More organic and asymmetric alien shape
    path.moveTo(size.width * 0.5, size.height); // Bottom point
    path.quadraticBezierTo(
      size.width * 0.75,
      size.height * 0.85,
      size.width * 0.85,
      size.height * 0.7,
    ); // Right curve
    path.quadraticBezierTo(
      size.width * 0.95,
      size.height * 0.55,
      size.width * 0.9,
      size.height * 0.4,
    ); // Right wing
    path.quadraticBezierTo(
      size.width * 0.85,
      size.height * 0.25,
      size.width * 0.7,
      size.height * 0.2,
    ); // Right upper curve
    path.quadraticBezierTo(
      size.width * 0.6,
      size.height * 0.15,
      size.width * 0.5,
      size.height * 0.1,
    ); // Top curve
    path.quadraticBezierTo(
      size.width * 0.4,
      size.height * 0.15,
      size.width * 0.3,
      size.height * 0.2,
    ); // Left upper curve
    path.quadraticBezierTo(
      size.width * 0.15,
      size.height * 0.25,
      size.width * 0.1,
      size.height * 0.4,
    ); // Left wing
    path.quadraticBezierTo(
      size.width * 0.05,
      size.height * 0.55,
      size.width * 0.15,
      size.height * 0.7,
    ); // Left curve
    path.quadraticBezierTo(
      size.width * 0.25,
      size.height * 0.85,
      size.width * 0.5,
      size.height,
    ); // Bottom curve
    path.close();

    // Draw base layer with metallic effect
    final baseGradient = LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        primaryColor.withOpacity(0.9),
        primaryColor,
        primaryColor.withOpacity(0.8),
      ],
      stops: const [0.0, 0.5, 1.0],
    );

    canvas.drawPath(
      path,
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

    // Draw enhanced armor plates with more organic shapes
    final platePaint = Paint()
      ..color = primaryColor.withOpacity(0.7)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    // Front armor plates with curved edges
    for (var i = 0; i < 3; i++) {
      final platePath = Path();
      final startX = size.width * (0.4 + i * 0.05);
      final endX = size.width * (0.6 - i * 0.05);
      platePath.moveTo(startX, size.height * 0.3);
      platePath.quadraticBezierTo(
        (startX + endX) / 2,
        size.height * 0.25,
        endX,
        size.height * 0.3,
      );
      platePath.quadraticBezierTo(
        (startX + endX) / 2,
        size.height * 0.45,
        startX,
        size.height * 0.3,
      );
      canvas.drawPath(platePath, platePaint);
    }

    // Side armor plates with organic curves
    for (var i = 0; i < 2; i++) {
      // Left side plates
      final leftPlatePath = Path();
      final leftY = size.height * (0.45 + i * 0.15);
      leftPlatePath.moveTo(size.width * 0.15, leftY);
      leftPlatePath.quadraticBezierTo(
        size.width * 0.25,
        leftY + size.height * 0.1,
        size.width * 0.3,
        leftY,
      );
      canvas.drawPath(leftPlatePath, platePaint);

      // Right side plates
      final rightPlatePath = Path();
      final rightY = size.height * (0.45 + i * 0.15);
      rightPlatePath.moveTo(size.width * 0.85, rightY);
      rightPlatePath.quadraticBezierTo(
        size.width * 0.75,
        rightY + size.height * 0.1,
        size.width * 0.7,
        rightY,
      );
      canvas.drawPath(rightPlatePath, platePaint);
    }

    // Draw energy circuits with organic flow
    final circuitColor = accentColor.withOpacity(0.8);

    // Left side circuits
    _drawEnergyCircuit(
      canvas,
      Offset(size.width * 0.25, size.height * 0.4),
      Offset(size.width * 0.35, size.height * 0.5),
      circuitColor,
    );
    _drawEnergyCircuit(
      canvas,
      Offset(size.width * 0.15, size.height * 0.5),
      Offset(size.width * 0.25, size.height * 0.6),
      circuitColor,
    );

    // Right side circuits
    _drawEnergyCircuit(
      canvas,
      Offset(size.width * 0.75, size.height * 0.4),
      Offset(size.width * 0.65, size.height * 0.5),
      circuitColor,
    );
    _drawEnergyCircuit(
      canvas,
      Offset(size.width * 0.85, size.height * 0.5),
      Offset(size.width * 0.75, size.height * 0.6),
      circuitColor,
    );

    // Enhanced weapon pods with organic energy core
    final weaponPaint = Paint()
      ..shader = RadialGradient(
        center: const Alignment(0, 0),
        radius: 0.8,
        colors: [
          Colors.white,
          accentColor,
          accentColor.withOpacity(0.5),
        ],
      ).createShader(Rect.fromCenter(
        center: center,
        width: size.width * 0.2,
        height: size.width * 0.2,
      ))
      ..maskFilter = const MaskFilter.blur(BlurStyle.outer, 10);

    // Organic weapon pods
    final leftPodPath = Path();
    leftPodPath.addOval(Rect.fromCenter(
      center: Offset(size.width * 0.2, size.height * 0.6),
      width: size.width * 0.16,
      height: size.width * 0.12,
    ));
    canvas.drawPath(leftPodPath, weaponPaint);

    final rightPodPath = Path();
    rightPodPath.addOval(Rect.fromCenter(
      center: Offset(size.width * 0.8, size.height * 0.6),
      width: size.width * 0.16,
      height: size.width * 0.12,
    ));
    canvas.drawPath(rightPodPath, weaponPaint);

    // Add weapon core glow with pulsing effect
    final corePaint = Paint()
      ..color = Colors.white.withOpacity(0.5 + _random * 0.5)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 5);

    canvas.drawCircle(
      Offset(size.width * 0.2, size.height * 0.6),
      size.width * 0.04,
      corePaint,
    );
    canvas.drawCircle(
      Offset(size.width * 0.8, size.height * 0.6),
      size.width * 0.04,
      corePaint,
    );

    // Enhanced engine effects with more visible blinking
    final engineGradient = LinearGradient(
      begin: Alignment.bottomCenter,
      end: Alignment.topCenter,
      colors: [
        Colors.white.withOpacity(0.8 + _random * 0.2),
        accentColor.withOpacity(0.6 + _random * 0.4),
        primaryColor.withOpacity(0.3 + _random * 0.3),
      ],
    );

    final enginePaint = Paint()
      ..shader = engineGradient.createShader(
        Rect.fromLTWH(
          size.width * 0.3,
          size.height * 0.1,
          size.width * 0.4,
          size.height * 0.4,
        ),
      )
      ..maskFilter = const MaskFilter.blur(BlurStyle.outer, 20);

    // Triple engine design with enhanced blinking effects
    for (var i = 0; i < 3; i++) {
      final enginePath = Path();
      final xOffset = 0.4 + (i * 0.1);
      final flicker = _random * 0.1; // Random flicker effect

      // Main thruster flame
      enginePath.moveTo(size.width * xOffset, size.height * 0.2);
      enginePath.quadraticBezierTo(
        size.width * (xOffset + 0.05),
        size.height * (0.05 - flicker),
        size.width * xOffset,
        size.height * (0.1 - flicker),
      );
      enginePath.quadraticBezierTo(
        size.width * (xOffset - 0.05),
        size.height * (0.05 - flicker),
        size.width * xOffset,
        size.height * 0.2,
      );
      canvas.drawPath(enginePath, enginePaint);

      // Add engine core glow with enhanced blinking
      final coreSize = 0.03 + _random * 0.02;
      canvas.drawCircle(
        Offset(size.width * xOffset, size.height * 0.15),
        size.width * coreSize,
        Paint()
          ..color = Colors.white.withOpacity(0.7 + _random * 0.3)
          ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 8),
      );

      // Additional flame effect
      final flamePath = Path();
      flamePath.moveTo(size.width * xOffset, size.height * 0.18);
      flamePath.quadraticBezierTo(
        size.width * (xOffset + 0.03),
        size.height * (0.08 - flicker),
        size.width * xOffset,
        size.height * (0.05 - flicker),
      );
      flamePath.quadraticBezierTo(
        size.width * (xOffset - 0.03),
        size.height * (0.08 - flicker),
        size.width * xOffset,
        size.height * 0.18,
      );
      canvas.drawPath(
        flamePath,
        Paint()
          ..shader = RadialGradient(
            center: Alignment.bottomCenter,
            radius: 1.0,
            colors: [
              Colors.white.withOpacity(0.8),
              accentColor.withOpacity(0.6 + _random * 0.4),
              Colors.transparent,
            ],
          ).createShader(Rect.fromLTWH(
            size.width * (xOffset - 0.05),
            size.height * 0.05,
            size.width * 0.1,
            size.height * 0.2,
          ))
          ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 5),
      );
    }

    // Draw metallic edge details
    final edgePaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Colors.white.withOpacity(0.7),
          accentColor.withOpacity(0.5),
          Colors.white.withOpacity(0.7),
        ],
      ).createShader(Rect.fromLTRB(0, 0, size.width, size.height))
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;
    canvas.drawPath(path, edgePaint);
  }

  @override
  bool shouldRepaint(EnemyShipPainter oldDelegate) =>
      true; // Always repaint for thruster animation
}

class ShipSkin extends StatelessWidget {
  final CustomPainter painter;
  final double size;

  const ShipSkin({
    super.key,
    required this.painter,
    this.size = 100,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: painter,
      size: Size(size, size),
    );
  }
}
