import 'package:flutter/material.dart';
import '../game/utils/constants.dart';

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
}

class PlayerWidget extends StatelessWidget {
  const PlayerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.circular(25),
      ),
      child: const Icon(Icons.rocket, color: Colors.white),
    );
  }
}
