import 'package:flutter/material.dart';
import '../game/utils/constants.dart';

class Projectile {
  Offset position;
  Offset velocity;

  Projectile({
    required this.position,
    Offset? velocity,
  }) : velocity = velocity ?? const Offset(0, -GameConstants.projectileSpeed);

  void update() {
    position += velocity;
  }
}

class ProjectileWidget extends StatelessWidget {
  const ProjectileWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 4,
      height: 20,
      color: Colors.yellow,
    );
  }
}
