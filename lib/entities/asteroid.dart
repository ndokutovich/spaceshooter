import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../widgets/game_objects.dart';

class Asteroid {
  Offset position;
  final double speed;
  final double rotation;
  final double rotationSpeed;
  int health;

  Asteroid({
    required this.position,
    required this.speed,
    double? rotation,
    double? rotationSpeed,
    this.health = 3,
  })  : rotation = rotation ?? (math.Random().nextDouble() * 2 * math.pi),
        rotationSpeed =
            rotationSpeed ?? (math.Random().nextDouble() * 0.1 - 0.05);

  void update(Size screenSize) {
    position = Offset(position.dx, position.dy + speed);
    if (position.dy > screenSize.height) {
      position = Offset(position.dx, -50);
      health = 3; // Reset health when recycling asteroid
    }
  }
}

class AsteroidWidget extends StatefulWidget {
  final int health;

  const AsteroidWidget({
    super.key,
    this.health = 3,
  });

  @override
  State<AsteroidWidget> createState() => _AsteroidWidgetState();
}

class _AsteroidWidgetState extends State<AsteroidWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late double _rotation;

  @override
  void initState() {
    super.initState();
    _rotation = math.Random().nextDouble() * 2 * math.pi;
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat();
    _controller.addListener(() {
      setState(() {
        _rotation += 0.02;
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GameObjectWidget(
      painter: AsteroidPainter(
        rotation: _rotation,
        health: widget.health,
      ),
      size: 60,
    );
  }
}
