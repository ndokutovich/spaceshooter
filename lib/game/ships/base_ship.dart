import 'package:flutter/material.dart';

abstract class BaseShip {
  Offset position;
  double speed;
  int health;
  final double size;

  BaseShip({
    required this.position,
    required this.speed,
    required this.size,
    this.health = 1,
  });

  void update(Size screenSize);
  void move(Offset delta, Size screenSize);
}

abstract class BaseShipPainter extends CustomPainter {
  final Color primaryColor;
  final Color accentColor;

  BaseShipPainter({
    required this.primaryColor,
    required this.accentColor,
  });

  @override
  void paint(Canvas canvas, Size size);

  @override
  bool shouldRepaint(covariant BaseShipPainter oldDelegate) =>
      primaryColor != oldDelegate.primaryColor ||
      accentColor != oldDelegate.accentColor;
}

class ShipWidget extends StatelessWidget {
  final BaseShipPainter painter;
  final double size;

  const ShipWidget({
    super.key,
    required this.painter,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: painter,
      size: Size(size, size),
    );
  }
}
