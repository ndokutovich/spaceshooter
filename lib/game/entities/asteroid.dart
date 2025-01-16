import 'package:flutter/material.dart';

class Asteroid {
  Offset position;
  double speed;

  Asteroid({required this.position, required this.speed});

  void update(Size screenSize) {
    position = Offset(position.dx, position.dy + speed);
    if (position.dy > screenSize.height) {
      position = Offset(position.dx, -50);
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
