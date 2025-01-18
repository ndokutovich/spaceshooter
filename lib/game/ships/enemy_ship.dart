import 'package:flutter/material.dart';
import '../../utils/constants/gameplay_constants.dart';
import '../../utils/constants/style_constants.dart';
import 'base_ship.dart';

class EnemyShip extends BaseShip {
  EnemyShip({
    required super.position,
    required super.speed,
    required super.health,
  }) : super(size: GameplayConstants.enemySize);

  @override
  void update(Size screenSize) {
    position = Offset(position.dx, position.dy + speed);
    if (position.dy > screenSize.height) {
      position = Offset(
        position.dx,
        GameplayConstants.enemyRespawnHeight,
      );
    }
  }

  @override
  void move(Offset delta, Size screenSize) {
    // Enemy movement is handled in update method
  }
}

class EnemyShipPainter extends BaseShipPainter {
  EnemyShipPainter({
    super.primaryColor = StyleConstants.enemyColor,
    super.accentColor = StyleConstants.projectileColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = primaryColor
      ..style = PaintingStyle.fill;

    // Create angular enemy ship path
    final path = Path();
    path.moveTo(size.width * 0.5, size.height); // Bottom point
    path.lineTo(size.width * 0.8, size.height * 0.6); // Right wing
    path.lineTo(size.width * 0.7, size.height * 0.3); // Right indent
    path.lineTo(size.width * 0.5, 0); // Top point
    path.lineTo(size.width * 0.3, size.height * 0.3); // Left indent
    path.lineTo(size.width * 0.2, size.height * 0.6); // Left wing
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
      ..maskFilter = const MaskFilter.blur(BlurStyle.outer, 8);
    canvas.drawPath(path, glowPaint);

    // Draw armor plates
    final platePaint = Paint()
      ..color = accentColor.withOpacity(0.5)
      ..style = PaintingStyle.fill;

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

    // Draw weapon pods
    final weaponPaint = Paint()
      ..color = accentColor
      ..maskFilter = const MaskFilter.blur(BlurStyle.outer, 10);

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
}
