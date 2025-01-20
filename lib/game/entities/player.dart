import 'package:flutter/material.dart';
import '../../utils/constants/gameplay_constants.dart';
import '../../widgets/ship_skins.dart';
import 'projectile.dart';

class Player {
  Offset position;
  bool isInvulnerable = false;

  Player({this.position = const Offset(0, 0)});

  void move(Offset delta, Size screenSize) {
    position += delta;
    position = Offset(
      position.dx.clamp(GameplayConstants.playAreaPadding,
          screenSize.width - GameplayConstants.playAreaPadding),
      position.dy.clamp(0, screenSize.height),
    );
  }

  Projectile shoot() {
    return Projectile(
      position: Offset(
        position.dx,
        position.dy - GameplayConstants.projectileOffset,
      ),
      speed: GameplayConstants.projectileSpeed,
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
