import 'package:flutter/material.dart';
import '../entities/player_entity.dart';
import '../../utils/constants/game/player_config.dart';

/// Widget for displaying the player ship
class PlayerView extends StatelessWidget {
  /// The player entity to display
  final PlayerEntity player;

  /// Creates a new player view
  const PlayerView({
    super.key,
    required this.player,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      duration: const Duration(milliseconds: 100),
      opacity:
          player.isInvulnerable ? player.config.invulnerabilityOpacity : 1.0,
      child: Transform.rotate(
        angle: player.rotation,
        child: CustomPaint(
          size: Size(player.config.size, player.config.size),
          painter: PlayerShipPainter(
            isAccelerating: player.isAccelerating,
          ),
        ),
      ),
    );
  }
}

/// Custom painter for drawing the player ship
class PlayerShipPainter extends CustomPainter {
  /// Whether the ship is currently accelerating
  final bool isAccelerating;

  /// Creates a new player ship painter
  PlayerShipPainter({
    this.isAccelerating = false,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);

    // Draw ship body
    final bodyPath = Path()
      ..moveTo(size.width * 0.5, 0) // Top point
      ..lineTo(size.width * 0.7, size.height * 0.2) // Right upper wing
      ..lineTo(size.width * 0.9, size.height * 0.4) // Right wing tip
      ..lineTo(size.width * 0.75, size.height * 0.5) // Right wing indent
      ..lineTo(size.width * 0.8, size.height * 0.7) // Right lower wing
      ..lineTo(size.width * 0.6, size.height * 0.6) // Right hull indent
      ..lineTo(size.width * 0.5, size.height * 0.8) // Bottom point
      ..lineTo(size.width * 0.4, size.height * 0.6) // Left hull indent
      ..lineTo(size.width * 0.2, size.height * 0.7) // Left lower wing
      ..lineTo(size.width * 0.25, size.height * 0.5) // Left wing indent
      ..lineTo(size.width * 0.1, size.height * 0.4) // Left wing tip
      ..lineTo(size.width * 0.3, size.height * 0.2) // Left upper wing
      ..close();

    // Draw ship shadow
    final shadowPaint = Paint()
      ..color = Colors.black.withOpacity(0.3)
      ..style = PaintingStyle.fill;
    canvas.drawPath(bodyPath, shadowPaint);

    // Draw main hull
    final bodyPaint = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.fill;
    canvas.drawPath(bodyPath, bodyPaint);

    // Draw energy glow
    final glowPaint = Paint()
      ..color = Colors.lightBlueAccent
      ..maskFilter = const MaskFilter.blur(BlurStyle.outer, 10);
    canvas.drawPath(bodyPath, glowPaint);

    // Draw cockpit
    final cockpitPath = Path()
      ..moveTo(size.width * 0.5, size.height * 0.15)
      ..lineTo(size.width * 0.6, size.height * 0.25)
      ..lineTo(size.width * 0.5, size.height * 0.35)
      ..lineTo(size.width * 0.4, size.height * 0.25)
      ..close();

    final cockpitGradient = LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        Colors.white.withOpacity(0.9),
        Colors.lightBlueAccent.withOpacity(0.3),
      ],
    );

    final cockpitPaint = Paint()
      ..shader = cockpitGradient.createShader(
        Rect.fromLTWH(
          size.width * 0.35,
          size.height * 0.15,
          size.width * 0.3,
          size.height * 0.2,
        ),
      );

    canvas.drawPath(cockpitPath, cockpitPaint);

    // Draw engine thrust when accelerating
    if (isAccelerating) {
      final thrustPath = Path()
        ..moveTo(size.width * 0.4, size.height * 0.8)
        ..lineTo(size.width * 0.5, size.height)
        ..lineTo(size.width * 0.6, size.height * 0.8)
        ..close();

      final thrustGradient = RadialGradient(
        center: Alignment.topCenter,
        radius: 1.0,
        colors: [
          Colors.white,
          Colors.blue.shade400,
          Colors.transparent,
        ],
        stops: const [0.0, 0.3, 1.0],
      );

      final thrustPaint = Paint()
        ..shader = thrustGradient.createShader(
          Rect.fromLTWH(
            size.width * 0.4,
            size.height * 0.8,
            size.width * 0.2,
            size.height * 0.2,
          ),
        );

      canvas.drawPath(thrustPath, thrustPaint);
    }
  }

  @override
  bool shouldRepaint(PlayerShipPainter oldDelegate) =>
      isAccelerating != oldDelegate.isAccelerating;
}
