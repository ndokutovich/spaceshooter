import 'dart:math' as math;

import 'package:flutter/material.dart';

class Star {
  Offset position;
  double size;
  double opacity;
  double twinkleSpeed;
  double maxBrightness;

  Star({
    required this.position,
    required this.size,
    this.opacity = 1.0,
    required this.twinkleSpeed,
    required this.maxBrightness,
  });
}

class StarBackground extends StatefulWidget {
  final Size screenSize;

  const StarBackground({
    super.key,
    required this.screenSize,
  });

  @override
  State<StarBackground> createState() => _StarBackgroundState();
}

class _StarBackgroundState extends State<StarBackground>
    with SingleTickerProviderStateMixin {
  late List<Star> stars;
  late AnimationController _controller;
  final random = math.Random();

  @override
  void initState() {
    super.initState();
    _initializeStars();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    )..repeat();
    _controller.addListener(_updateStars);
  }

  void _initializeStars() {
    // Create three layers of stars with different properties
    stars = [
      ...List.generate(50, (index) => _createStar(0.3)), // Distant stars
      ...List.generate(30, (index) => _createStar(0.6)), // Mid-range stars
      ...List.generate(20, (index) => _createStar(1.0)), // Close stars
    ];
  }

  Star _createStar(double brightnessMultiplier) {
    return Star(
      position: Offset(
        random.nextDouble() * widget.screenSize.width,
        random.nextDouble() * widget.screenSize.height,
      ),
      size: (0.5 + random.nextDouble() * 2) * brightnessMultiplier,
      twinkleSpeed: 0.3 + random.nextDouble() * 2,
      maxBrightness: 0.3 + (0.7 * brightnessMultiplier),
    );
  }

  void _updateStars() {
    setState(() {
      for (var star in stars) {
        // Update star position - move downward
        star.position = Offset(
          star.position.dx,
          star.position.dy +
              (1.0 + star.size) * 0.5, // Larger stars move faster
        );

        // Reset star to top when it goes off screen
        if (star.position.dy > widget.screenSize.height) {
          star.position = Offset(
            random.nextDouble() * widget.screenSize.width,
            0, // Start from top
          );
        }

        // Create a smooth twinkling effect using sine waves
        star.opacity =
            (math.sin(_controller.value * math.pi * 2 * star.twinkleSpeed) +
                    1) /
                2 *
                star.maxBrightness;
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: widget.screenSize,
      painter: StarPainter(stars),
    );
  }
}

class StarPainter extends CustomPainter {
  final List<Star> stars;

  StarPainter(this.stars);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.white;

    for (var star in stars) {
      paint.color = Colors.white.withOpacity(star.opacity);
      canvas.drawCircle(star.position, star.size, paint);
    }
  }

  @override
  bool shouldRepaint(StarPainter oldDelegate) => true;
}
