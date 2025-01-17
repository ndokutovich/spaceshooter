import 'package:flutter/material.dart';
import '../../utils/constants/gameplay_constants.dart';
import '../../utils/constants/style_constants.dart';
import 'base_ship.dart';

class PlayerShip extends BaseShip {
  bool isInvulnerable;

  PlayerShip({
    required super.position,
    this.isInvulnerable = false,
  }) : super(
          speed: GameplayConstants.playerSpeed,
          size: GameplayConstants.playerSize,
        );

  @override
  void update(Size screenSize) {
    // Player position is updated through move method
  }

  @override
  void move(Offset delta, Size screenSize) {
    position += delta * speed;
    position = Offset(
      position.dx.clamp(
        GameplayConstants.playAreaPadding,
        screenSize.width - GameplayConstants.playAreaPadding,
      ),
      position.dy.clamp(0, screenSize.height),
    );
  }
}

class PlayerShipPainter extends BaseShipPainter {
  PlayerShipPainter({
    Color primaryColor = StyleConstants.playerColor,
    Color accentColor = StyleConstants.primaryColor,
  }) : super(primaryColor: primaryColor, accentColor: accentColor);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = primaryColor
      ..style = PaintingStyle.fill;

    // Create ship path
    final path = Path();
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

    // Draw ship shadow
    final shadowPaint = Paint()
      ..color = Colors.black.withOpacity(0.3)
      ..style = PaintingStyle.fill;
    canvas.drawPath(path, shadowPaint);

    // Draw main hull
    canvas.drawPath(path, paint);

    // Draw energy glow
    final glowPaint = Paint()
      ..color = accentColor
      ..maskFilter = const MaskFilter.blur(BlurStyle.outer, 10);
    canvas.drawPath(path, glowPaint);

    // Draw cockpit
    final cockpitGradient = LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        Colors.white.withOpacity(0.9),
        accentColor.withOpacity(0.3),
      ],
    );

    final cockpitPaint = Paint()
      ..shader = cockpitGradient.createShader(
        Rect.fromLTWH(
          size.width * 0.35,
          size.height * 0.15,
          size.width * 0.3,
          size.height * 0.2,
        ),
      );

    final cockpitPath = Path();
    cockpitPath.moveTo(size.width * 0.5, size.height * 0.15);
    cockpitPath.lineTo(size.width * 0.65, size.height * 0.25);
    cockpitPath.lineTo(size.width * 0.5, size.height * 0.35);
    cockpitPath.lineTo(size.width * 0.35, size.height * 0.25);
    cockpitPath.close();
    canvas.drawPath(cockpitPath, cockpitPaint);
  }
}
