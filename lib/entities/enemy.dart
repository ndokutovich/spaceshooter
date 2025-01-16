import 'package:flutter/material.dart';

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
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: Colors.red,
        borderRadius: BorderRadius.circular(20),
      ),
      child: const Icon(Icons.android, color: Colors.white),
    );
  }
}
