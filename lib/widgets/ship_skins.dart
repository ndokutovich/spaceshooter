import 'package:flutter/material.dart';

class PlayerShipPainter extends CustomPainter {
  final Color primaryColor;
  final Color accentColor;

  PlayerShipPainter({
    this.primaryColor = Colors.blue,
    this.accentColor = Colors.white,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // 3D hull effect with gradient
    final hullGradient = LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        Colors.white,
        primaryColor,
        primaryColor.withValues(
            red: (primaryColor.r * 255 - 40).toDouble(),
            green: (primaryColor.g * 255 - 40).toDouble(),
            blue: (primaryColor.b * 255 - 40).toDouble(),
            alpha: 255.0),
      ],
    );

    final paint = Paint()
      ..shader = hullGradient
          .createShader(Rect.fromLTWH(0, 0, size.width, size.height))
      ..style = PaintingStyle.fill;

    final path = Path();

    // Main hull - Space Rangers style with angular design
    path.moveTo(size.width * 0.5, 0); // Top point
    path.lineTo(size.width * 0.7, size.height * 0.2); // Right upper wing
    path.lineTo(size.width * 0.9, size.height * 0.4); // Right wing tip
    path.lineTo(size.width * 0.75, size.height * 0.5); // Right wing indent
    path.lineTo(size.width * 0.8, size.height * 0.7); // Right lower wing
    path.lineTo(size.width * 0.6, size.height * 0.6); // Right hull indent
    path.lineTo(size.width * 0.5, size.height * 0.8); // Bottom point
    path.lineTo(size.width * 0.4, size.height * 0.6); // Left hull indent
    path.lineTo(size.width * 0.2, size.height * 0.7); // Left lower wing
    path.lineTo(size.width * 0.25, size.height * 0.5); // Left wing indent
    path.lineTo(size.width * 0.1, size.height * 0.4); // Left wing tip
    path.lineTo(size.width * 0.3, size.height * 0.2); // Left upper wing
    path.close();

    // Draw hull shadow
    final shadowPaint = Paint()
      ..color = Colors.black
          .withValues(red: 0.0, green: 0.0, blue: 0.0, alpha: 77.0) // 0.3
      ..style = PaintingStyle.fill;
    canvas.drawPath(path, shadowPaint);

    // Draw main hull
    canvas.drawPath(path, paint);

    // Metallic highlights
    final highlightPaint = Paint()
      ..color = Colors.white.withValues(
          red: 255.0, green: 255.0, blue: 255.0, alpha: 128.0) // 0.5
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    // Upper hull highlight
    canvas.drawPath(
      Path()
        ..moveTo(size.width * 0.3, size.height * 0.2)
        ..lineTo(size.width * 0.5, size.height * 0.1)
        ..lineTo(size.width * 0.7, size.height * 0.2),
      highlightPaint,
    );

    // Energy shield effect
    final shieldPaint = Paint()
      ..shader = RadialGradient(
        center: Alignment.center,
        radius: 1.0,
        colors: [
          Colors.white.withValues(
              red: 255.0, green: 255.0, blue: 255.0, alpha: 77.0), // 0.3
          Colors.white.withValues(
              red: 255.0, green: 255.0, blue: 255.0, alpha: 0.0), // 0.0
        ],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height))
      ..style = PaintingStyle.fill;

    canvas.drawPath(path, shieldPaint);

    // Advanced engine effect
    final engineGradient = LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        Colors.white,
        Colors.white
            .withValues(red: 255.0, green: 255.0, blue: 255.0, alpha: 128.0),
        primaryColor.withValues(
            red: (primaryColor.r * 255).toDouble(),
            green: (primaryColor.g * 255).toDouble(),
            blue: (primaryColor.b * 255).toDouble(),
            alpha: 128.0), // 0.5
      ],
    );

    final enginePaint = Paint()
      ..shader = engineGradient.createShader(
        Rect.fromLTWH(size.width * 0.3, size.height * 0.6, size.width * 0.4,
            size.height * 0.4),
      )
      ..maskFilter = const MaskFilter.blur(BlurStyle.outer, 10);

    // Triple engine design
    for (var i = 0; i < 3; i++) {
      final enginePath = Path();
      final xOffset = 0.4 + (i * 0.1);
      enginePath.moveTo(size.width * xOffset, size.height * 0.6);
      enginePath.lineTo(size.width * (xOffset + 0.05), size.height * 0.7);
      enginePath.lineTo(size.width * (xOffset + 0.03), size.height);
      enginePath.lineTo(size.width * (xOffset - 0.03), size.height);
      enginePath.lineTo(size.width * (xOffset - 0.05), size.height * 0.7);
      enginePath.close();
      canvas.drawPath(enginePath, enginePaint);
    }

    // Cockpit with crystal effect
    final cockpitGradient = LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        Colors.white.withValues(
            red: 255.0, green: 255.0, blue: 255.0, alpha: 230.0), // 0.9
        accentColor.withValues(
            red: (accentColor.r * 255).toDouble(),
            green: (accentColor.g * 255).toDouble(),
            blue: (accentColor.b * 255).toDouble(),
            alpha: 179.0), // 0.7
        accentColor.withValues(
            red: (accentColor.r * 255).toDouble(),
            green: (accentColor.g * 255).toDouble(),
            blue: (accentColor.b * 255).toDouble(),
            alpha: 102.0), // 0.4
      ],
    );

    final cockpitPaint = Paint()
      ..shader = cockpitGradient.createShader(
        Rect.fromLTWH(size.width * 0.35, size.height * 0.15, size.width * 0.3,
            size.height * 0.2),
      );

    final cockpitPath = Path();
    cockpitPath.moveTo(size.width * 0.5, size.height * 0.15);
    cockpitPath.lineTo(size.width * 0.65, size.height * 0.25);
    cockpitPath.lineTo(size.width * 0.5, size.height * 0.35);
    cockpitPath.lineTo(size.width * 0.35, size.height * 0.25);
    cockpitPath.close();
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
    this.accentColor = Colors.white,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // 3D hull effect with menacing gradient
    final hullGradient = LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        Colors.white,
        primaryColor,
        primaryColor.withValues(
            red: (primaryColor.r * 255 - 30).toDouble(),
            green: (primaryColor.g * 255 - 30).toDouble(),
            blue: (primaryColor.b * 255 - 30).toDouble(),
            alpha: 255.0),
      ],
    );

    final paint = Paint()
      ..shader = hullGradient
          .createShader(Rect.fromLTWH(0, 0, size.width, size.height))
      ..style = PaintingStyle.fill;

    final path = Path();

    // Alien battleship design
    path.moveTo(size.width * 0.5, size.height); // Bottom point
    path.lineTo(size.width * 0.8, size.height * 0.8); // Right lower wing
    path.lineTo(size.width * 0.95, size.height * 0.5); // Right wing tip
    path.lineTo(size.width * 0.8, size.height * 0.3); // Right upper indent
    path.lineTo(size.width * 0.6, size.height * 0.2); // Right upper wing
    path.lineTo(size.width * 0.5, 0); // Top point
    path.lineTo(size.width * 0.4, size.height * 0.2); // Left upper wing
    path.lineTo(size.width * 0.2, size.height * 0.3); // Left upper indent
    path.lineTo(size.width * 0.05, size.height * 0.5); // Left wing tip
    path.lineTo(size.width * 0.2, size.height * 0.8); // Left lower wing
    path.close();

    // Draw hull shadow
    final shadowPaint = Paint()
      ..color = Colors.black
          .withValues(red: 0.0, green: 0.0, blue: 0.0, alpha: 102.0) // 0.4
      ..style = PaintingStyle.fill;
    canvas.drawPath(path, shadowPaint);

    // Draw main hull
    canvas.drawPath(path, paint);

    // Energy core with plasma effect
    final plasmaGradient = RadialGradient(
      center: Alignment.center,
      radius: 0.8,
      colors: [
        Colors.white,
        Colors.white
            .withValues(red: 255.0, green: 255.0, blue: 255.0, alpha: 128.0),
        primaryColor.withValues(
            red: (primaryColor.r * 255).toDouble(),
            green: (primaryColor.g * 255).toDouble(),
            blue: (primaryColor.b * 255).toDouble(),
            alpha: 128.0), // 0.5
      ],
    );

    final plasmaPaint = Paint()
      ..shader = plasmaGradient.createShader(
        Rect.fromLTWH(size.width * 0.2, size.height * 0.2, size.width * 0.6,
            size.height * 0.6),
      )
      ..maskFilter = const MaskFilter.blur(BlurStyle.outer, 15);

    canvas.drawCircle(
      Offset(size.width * 0.5, size.height * 0.4),
      size.width * 0.2,
      plasmaPaint,
    );

    // Armor plates with metallic effect
    final platePaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Colors.white.withValues(
              red: 255.0, green: 255.0, blue: 255.0, alpha: 128.0), // 0.5
          accentColor.withValues(
              red: (accentColor.r * 255).toDouble(),
              green: (accentColor.g * 255).toDouble(),
              blue: (accentColor.b * 255).toDouble(),
              alpha: 77.0), // 0.3
          Colors.black
              .withValues(red: 0.0, green: 0.0, blue: 0.0, alpha: 77.0), // 0.3
        ],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height))
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    // Draw angular armor plates
    for (var i = 0; i < 3; i++) {
      final platePath = Path();
      platePath.moveTo(size.width * (0.3 + i * 0.1), size.height * 0.3);
      platePath.lineTo(size.width * (0.7 - i * 0.1), size.height * 0.3);
      platePath.lineTo(size.width * (0.6 - i * 0.05), size.height * 0.5);
      platePath.lineTo(size.width * (0.4 + i * 0.05), size.height * 0.5);
      platePath.close();
      canvas.drawPath(platePath, platePaint);
    }

    // Energy weapon glow
    final weaponPaint = Paint()
      ..color = accentColor
      ..maskFilter = const MaskFilter.blur(BlurStyle.outer, 10);

    // Side weapon pods
    canvas.drawCircle(
      Offset(size.width * 0.2, size.height * 0.6),
      size.width * 0.08,
      weaponPaint,
    );
    canvas.drawCircle(
      Offset(size.width * 0.8, size.height * 0.6),
      size.width * 0.08,
      weaponPaint,
    );
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
