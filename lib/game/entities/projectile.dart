import 'package:flutter/material.dart';
import '../../widgets/game_objects.dart';
import 'dart:math' as math;

class Projectile {
  Offset position;
  final double speed;
  final bool isEnemy;
  final double angle;
  final int damage;

  Projectile({
    required this.position,
    required this.speed,
    required this.isEnemy,
    this.angle = -90,
    this.damage = 1,
  });

  void update() {
    final radians = angle * math.pi / 180;
    position = Offset(
      position.dx + speed * math.cos(radians),
      position.dy + speed * math.sin(radians),
    );
  }
}

class ProjectileWidget extends StatelessWidget {
  final bool isEnemy;

  const ProjectileWidget({
    super.key,
    this.isEnemy = false,
  });

  @override
  Widget build(BuildContext context) {
    return GameObjectWidget(
      painter: ProjectilePainter(
        color: isEnemy ? Colors.red : Colors.cyan,
      ),
      size: 30,
    );
  }
}
