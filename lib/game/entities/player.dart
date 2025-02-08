import 'package:flutter/material.dart';
import '../../utils/constants/game/config.dart';
import '../../widgets/ship_skins.dart';
import 'projectile.dart';

class Player {
  Offset position;
  bool isInvulnerable = false;
  final PlayerConfig config;

  Player({
    this.position = const Offset(0, 0),
    this.config = const PlayerConfig(),
  });

  void move(Offset delta, Size screenSize) {
    position += delta;
    position = Offset(
      position.dx.clamp(
          config.startHeightRatio, screenSize.width - config.startHeightRatio),
      position.dy.clamp(0, screenSize.height),
    );
  }

  Projectile shoot() {
    return Projectile(
      position: Offset(
        position.dx,
        position.dy - config.primaryWeapon.offset,
      ),
      speed: config.primaryWeapon.speed,
      isEnemy: false,
    );
  }

  void useNovaBlast() {
    // This is handled by the GameStateManager
  }
}

class PlayerWidget extends StatelessWidget {
  final PlayerConfig config;

  const PlayerWidget({
    super.key,
    this.config = const PlayerConfig(),
  });

  @override
  Widget build(BuildContext context) {
    return ShipSkin(
      painter: PlayerShipPainter(
        primaryColor: Colors.blue,
        accentColor: Colors.lightBlueAccent,
      ),
      size: config.size,
    );
  }
}
