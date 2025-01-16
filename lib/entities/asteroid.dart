import 'package:flutter/material.dart';

class Asteroid {
  Offset position;
  double speed;
  double size;

  Asteroid({
    required this.position,
    required this.speed,
    this.size = 50.0,
  });

  void update(Size screenSize) {
    position = Offset(position.dx, position.dy + speed);
    if (position.dy > screenSize.height) {
      position = Offset(position.dx, -size);
    }
  }
}

class AsteroidWidget extends StatelessWidget {
  const AsteroidWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 50,
      decoration: const BoxDecoration(
        color: Colors.grey,
        shape: BoxShape.circle,
      ),
    );
  }
}
