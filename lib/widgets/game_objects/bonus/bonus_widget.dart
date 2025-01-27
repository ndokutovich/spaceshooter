import 'package:flutter/material.dart';
import 'bonus_painter.dart';
import 'controllers/bonus_controller.dart';

/// Widget for rendering a bonus item with animations
class BonusWidget extends StatefulWidget {
  final BonusController controller;
  final double size;

  const BonusWidget({
    super.key,
    required this.controller,
    this.size = 30,
  });

  @override
  State<BonusWidget> createState() => _BonusWidgetState();
}

class _BonusWidgetState extends State<BonusWidget> {
  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: widget.controller,
      builder: (context, child) {
        return CustomPaint(
          size: Size.square(widget.size),
          painter: BonusPainter(
            type: widget.controller.type,
            rotation: widget.controller.rotation,
            config: widget.controller.config,
          ),
        );
      },
    );
  }
}
