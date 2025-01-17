import 'package:flutter/material.dart';
import '../../widgets/game_objects.dart';
import 'dart:math' as math;

class Projectile {
  Offset position;
  final double speed;
  final bool isEnemy;
  final double angle;

  Projectile({
    required this.position,
    required this.speed,
    this.isEnemy = false,
    this.angle = -90, // Default upward direction
  });

  void update() {
    final radians = angle * math.pi / 180;
    position = Offset(
      position.dx + math.cos(radians) * speed,
      position.dy + math.sin(radians) * speed,
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
