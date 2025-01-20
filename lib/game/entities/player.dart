import 'package:flutter/material.dart';
import '../utils/constants.dart';
import '../../widgets/ship_skins.dart';
import 'projectile.dart';

class Player {
  Offset position;
  bool isInvulnerable = false;

  Player({this.position = const Offset(0, 0)});

  void move(Offset delta, Size screenSize) {
    position += delta;
    position = Offset(
      position.dx.clamp(GameConstants.playAreaPadding,
          screenSize.width - GameConstants.playAreaPadding),
      position.dy.clamp(0, screenSize.height),
    );
  }

  Projectile shoot() {
    return Projectile(
      position: Offset(
        position.dx,
        position.dy - GameConstants.projectileOffset,
      ),
      speed: GameConstants.projectileSpeed,
      isEnemy: false,
    );
  }

  void useNovaBlast() {
    // This is handled by the GameStateManager
  }
}

class PlayerWidget extends StatelessWidget {
  const PlayerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ShipSkin(
      painter: PlayerShipPainter(
        primaryColor: Colors.blue,
        accentColor: Colors.lightBlueAccent,
      ),
      size: 80,
    );
  }
}
