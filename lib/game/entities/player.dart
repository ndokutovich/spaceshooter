import 'package:flutter/material.dart';
import '../../utils/constants/gameplay_constants.dart';
import '../../utils/constants/player_constants.dart';
import '../../widgets/ship_skins.dart';
import 'projectile.dart';

class Player {
  Offset position;
  bool isInvulnerable = false;
  final bool useSvg;
  final Color primaryColor;
  final Color accentColor;

  Player({
    this.position = const Offset(0, 0),
    this.useSvg = true,
    this.primaryColor = Colors.blue,
    this.accentColor = Colors.lightBlueAccent,
  });

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
  final Player player;
  final double size;

  const PlayerWidget({
    super.key,
    required this.player,
    this.size = PlayerConstants.size,
  });

  @override
  Widget build(BuildContext context) {
    debugPrint('Building PlayerWidget with SVG: ${player.useSvg}');
    return SizedBox(
      width: size,
      height: size,
      child: ShipSkin(
        svgAsset: player.useSvg ? 'assets/ships/player_ship.svg' : null,
        painter: !player.useSvg
            ? PlayerShipPainter(
                primaryColor: player.primaryColor,
                accentColor: player.accentColor,
              )
            : null,
        size: size,
        tint: player.useSvg ? player.primaryColor : null,
      ),
    );
  }
}
