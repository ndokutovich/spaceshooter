import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../widgets/ship_skins.dart';

class Enemy {
  Offset position;
  double speed;
  int health;

  Enemy({
    required this.position,
    required this.speed,
    required this.health,
  });

  void update(Size screenSize) {
    position = Offset(position.dx, position.dy + speed);
    if (position.dy > screenSize.height) {
      position = Offset(position.dx, -50);
    }
  }
}

class EnemyWidget extends StatelessWidget {
  const EnemyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: math.pi, // Rotate 180 degrees to face downward
      child: ShipSkin(
        painter: EnemyShipPainter(
          primaryColor: Colors.red,
          accentColor: Colors.redAccent,
        ),
        size: 60,
      ),
    );
  }
}
