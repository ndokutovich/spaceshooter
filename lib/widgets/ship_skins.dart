import 'package:flutter/material.dart';

class PlayerShipPainter extends CustomPainter {
  final Color primaryColor;
  final Color accentColor;

  PlayerShipPainter({
    this.primaryColor = Colors.blue,
    this.accentColor = Colors.lightBlueAccent,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.fill
      ..color = primaryColor;

    final path = Path();

    // Main body - more detailed spaceship shape
    path.moveTo(size.width * 0.5, 0); // Top center
    path.quadraticBezierTo(
      size.width * 0.7, size.height * 0.3, // Control point
      size.width * 0.9, size.height * 0.5, // Right wing tip
    );
    path.lineTo(size.width * 0.7, size.height * 0.7); // Right wing inner
    path.lineTo(size.width * 0.6, size.height * 0.6); // Right body indent
    path.lineTo(size.width * 0.5, size.height * 0.8); // Bottom center
    path.lineTo(size.width * 0.4, size.height * 0.6); // Left body indent
    path.lineTo(size.width * 0.3, size.height * 0.7); // Left wing inner
    path.lineTo(size.width * 0.1, size.height * 0.5); // Left wing tip
    path.quadraticBezierTo(
      size.width * 0.3, size.height * 0.3, // Control point
      size.width * 0.5, 0, // Back to top center
    );
    canvas.drawPath(path, paint);

    // Wing details
    final detailPaint = Paint()
      ..style = PaintingStyle.stroke
      ..color = accentColor
      ..strokeWidth = 2;

    // Right wing detail
    canvas.drawLine(
      Offset(size.width * 0.7, size.height * 0.4),
      Offset(size.width * 0.85, size.height * 0.5),
      detailPaint,
    );

    // Left wing detail
    canvas.drawLine(
      Offset(size.width * 0.3, size.height * 0.4),
      Offset(size.width * 0.15, size.height * 0.5),
      detailPaint,
    );

    // Engine glow - enhanced with multiple layers
    final enginePaint = Paint()
      ..style = PaintingStyle.fill
      ..color = accentColor
      ..maskFilter = const MaskFilter.blur(BlurStyle.outer, 8);

    // Main engine glow
    final enginePath = Path();
    enginePath.moveTo(size.width * 0.4, size.height * 0.6);
    enginePath.lineTo(size.width * 0.6, size.height * 0.6);
    enginePath.lineTo(size.width * 0.5, size.height);
    enginePath.close();
    canvas.drawPath(enginePath, enginePaint);

    // Inner engine glow
    final innerEnginePaint = Paint()
      ..style = PaintingStyle.fill
      ..color = Colors.white
      ..maskFilter = const MaskFilter.blur(BlurStyle.outer, 4);

    final innerEnginePath = Path();
    innerEnginePath.moveTo(size.width * 0.45, size.height * 0.65);
    innerEnginePath.lineTo(size.width * 0.55, size.height * 0.65);
    innerEnginePath.lineTo(size.width * 0.5, size.height * 0.9);
    innerEnginePath.close();
    canvas.drawPath(innerEnginePath, innerEnginePaint);

    // Cockpit with gradient
    final cockpitPaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          accentColor.withValues(
              red: accentColor.r * 255,
              green: accentColor.g * 255,
              blue: accentColor.b * 255,
              alpha: 230),
          accentColor.withValues(
              red: accentColor.r * 255,
              green: accentColor.g * 255,
              blue: accentColor.b * 255,
              alpha: 150),
        ],
      ).createShader(
          Rect.fromLTWH(0, size.height * 0.2, size.width, size.height * 0.3));

    final cockpitPath = Path();
    cockpitPath.moveTo(size.width * 0.5, size.height * 0.2);
    cockpitPath.quadraticBezierTo(
      size.width * 0.6,
      size.height * 0.3,
      size.width * 0.55,
      size.height * 0.4,
    );
    cockpitPath.quadraticBezierTo(
      size.width * 0.5,
      size.height * 0.45,
      size.width * 0.45,
      size.height * 0.4,
    );
    cockpitPath.quadraticBezierTo(
      size.width * 0.4,
      size.height * 0.3,
      size.width * 0.5,
      size.height * 0.2,
    );
    canvas.drawPath(cockpitPath, cockpitPaint);
  }

  @override
  bool shouldRepaint(PlayerShipPainter oldDelegate) =>
      primaryColor != oldDelegate.primaryColor ||
      accentColor != oldDelegate.accentColor;
}

class EnemyShipPainter extends CustomPainter {
  final Color primaryColor;
  final Color accentColor;

  EnemyShipPainter({
    this.primaryColor = Colors.red,
    this.accentColor = Colors.redAccent,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.fill
      ..color = primaryColor;

    final path = Path();

    // Main body - more aggressive alien design
    path.moveTo(size.width * 0.5, size.height); // Bottom center
    path.quadraticBezierTo(
      size.width * 0.8, size.height * 0.7, // Control point
      size.width, size.height * 0.5, // Far right
    );
    path.quadraticBezierTo(
      size.width * 0.9, size.height * 0.3, // Control point
      size.width * 0.7, size.height * 0.2, // Upper right indent
    );
    path.quadraticBezierTo(
      size.width * 0.6, size.height * 0.1, // Control point
      size.width * 0.5, 0, // Top center
    );
    path.quadraticBezierTo(
      size.width * 0.4, size.height * 0.1, // Control point
      size.width * 0.3, size.height * 0.2, // Upper left indent
    );
    path.quadraticBezierTo(
      size.width * 0.1, size.height * 0.3, // Control point
      0, size.height * 0.5, // Far left
    );
    path.quadraticBezierTo(
      size.width * 0.2, size.height * 0.7, // Control point
      size.width * 0.5, size.height, // Back to bottom center
    );
    canvas.drawPath(path, paint);

    // Energy core with pulsing effect
    final corePaint = Paint()
      ..style = PaintingStyle.fill
      ..color = accentColor
      ..maskFilter = const MaskFilter.blur(BlurStyle.outer, 8);

    // Outer core
    canvas.drawCircle(
      Offset(size.width * 0.5, size.height * 0.4),
      size.width * 0.2,
      corePaint,
    );

    // Inner core
    final innerCorePaint = Paint()
      ..style = PaintingStyle.fill
      ..color = Colors.white
      ..maskFilter = const MaskFilter.blur(BlurStyle.outer, 4);

    canvas.drawCircle(
      Offset(size.width * 0.5, size.height * 0.4),
      size.width * 0.1,
      innerCorePaint,
    );

    // Wing patterns
    final patternPaint = Paint()
      ..style = PaintingStyle.stroke
      ..color = accentColor
      ..strokeWidth = 2;

    // Left wing patterns
    canvas.drawPath(
      Path()
        ..moveTo(size.width * 0.1, size.height * 0.5)
        ..lineTo(size.width * 0.3, size.height * 0.4)
        ..lineTo(size.width * 0.4, size.height * 0.6),
      patternPaint,
    );

    // Right wing patterns
    canvas.drawPath(
      Path()
        ..moveTo(size.width * 0.9, size.height * 0.5)
        ..lineTo(size.width * 0.7, size.height * 0.4)
        ..lineTo(size.width * 0.6, size.height * 0.6),
      patternPaint,
    );

    // Additional details
    final detailPaint = Paint()
      ..style = PaintingStyle.stroke
      ..color = accentColor.withValues(
          red: accentColor.r * 255,
          green: accentColor.g * 255,
          blue: accentColor.b * 255,
          alpha: 150)
      ..strokeWidth = 1;

    // Armor plates
    for (var i = 0; i < 3; i++) {
      canvas.drawArc(
        Rect.fromCenter(
          center: Offset(size.width * 0.5, size.height * 0.4),
          width: size.width * (0.6 + i * 0.2),
          height: size.height * (0.4 + i * 0.1),
        ),
        0,
        3.14,
        false,
        detailPaint,
      );
    }
  }

  @override
  bool shouldRepaint(EnemyShipPainter oldDelegate) =>
      primaryColor != oldDelegate.primaryColor ||
      accentColor != oldDelegate.accentColor;
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
