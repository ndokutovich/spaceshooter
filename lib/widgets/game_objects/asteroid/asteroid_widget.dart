import 'package:flutter/material.dart';

import 'asteroid_painter.dart';
import 'controllers/asteroid_controller.dart';

/// Widget for rendering an asteroid with animations
class AsteroidWidget extends StatefulWidget {
  final AsteroidController controller;
  final double size;

  const AsteroidWidget({
    super.key,
    required this.controller,
    this.size = 100,
  });

  @override
  State<AsteroidWidget> createState() => _AsteroidWidgetState();
}

class _AsteroidWidgetState extends State<AsteroidWidget> {
  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: widget.controller,
      builder: (context, child) {
        return CustomPaint(
          size: Size.square(widget.size),
          painter: AsteroidPainter(
            rotation: widget.controller.rotation,
            health: widget.controller.health,
            config: widget.controller.currentConfig,
          ),
        );
      },
    );
  }
}
