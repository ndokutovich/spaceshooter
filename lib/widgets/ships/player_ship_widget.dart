import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PlayerShipWidget extends StatelessWidget {
  final double size;
  final double rotation;
  final bool isInvulnerable;
  final bool isAccelerating;

  const PlayerShipWidget({
    super.key,
    this.size = 50.0,
    this.rotation = 0.0,
    this.isInvulnerable = false,
    this.isAccelerating = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 100),
        opacity: isInvulnerable ? 0.5 : 1.0,
        child: Transform.rotate(
          angle: rotation,
          child: Stack(
            children: [
              // Base ship SVG
              SvgPicture.asset(
                'lib/assets/ships/player_ship.svg',
                width: size,
                height: size,
              ),

              // Engine thrust effect when accelerating
              if (isAccelerating)
                Positioned(
                  bottom: 0,
                  left: size * 0.4,
                  child: Container(
                    width: size * 0.2,
                    height: size * 0.4,
                    decoration: BoxDecoration(
                      gradient: RadialGradient(
                        center: Alignment.topCenter,
                        radius: 1.0,
                        colors: [
                          Colors.white,
                          Colors.blue.shade400,
                          Colors.transparent,
                        ],
                        stops: const [0.0, 0.3, 1.0],
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
