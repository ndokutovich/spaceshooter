import 'package:flutter/material.dart';
import 'dart:math' as math;
import '../../widgets/game_objects.dart';

class Asteroid {
  Offset position;
  final double speed;
  final double rotation;
  final double rotationSpeed;

  Asteroid({
    required this.position,
    required this.speed,
    double? rotation,
    double? rotationSpeed,
  })  : rotation = rotation ?? (math.Random().nextDouble() * 2 * math.pi),
        rotationSpeed =
            rotationSpeed ?? (math.Random().nextDouble() * 0.1 - 0.05);

  void update(Size screenSize) {
    position = Offset(position.dx, position.dy + speed);
    if (position.dy > screenSize.height) {
      position = Offset(position.dx, -50);
    }
  }
}

class AsteroidWidget extends StatefulWidget {
  const AsteroidWidget({super.key});

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
      painter: AsteroidPainter(rotation: _rotation),
      size: 60,
    );
  }
}
