import 'package:flutter/material.dart';

class GameObjectWidget extends StatelessWidget {
  final CustomPainter painter;
  final double size;

  const GameObjectWidget({
    super.key,
    required this.painter,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: painter,
      size: Size(size, size),
    );
  }
}
