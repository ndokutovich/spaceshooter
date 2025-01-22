import 'dart:ui';
import 'dart:math' as math;

class CollisionUtils {
  // Triangle-based collision for player with better accuracy
  static bool checkPlayerCollision(
      Offset playerPos, double playerSize, Offset otherPos, double otherSize) {
    final points = _getPlayerTrianglePoints(playerPos, playerSize);

    // For small objects like projectiles, use point-in-triangle
    if (otherSize < playerSize * 0.5) {
      return _pointInTriangle(otherPos, points[0], points[1], points[2]);
    }

    // For larger objects, check multiple points around the other object
    final otherPoints = _getCirclePoints(otherPos, otherSize * 0.4);
    for (final point in otherPoints) {
      if (_pointInTriangle(point, points[0], points[1], points[2])) {
        return true;
      }
    }
    return false;
  }

  // Helper to get player triangle points with adjusted shape
  static List<Offset> _getPlayerTrianglePoints(Offset center, double size) {
    final halfSize = size / 2;
    final height = size * 0.8; // Slightly shorter triangle
    return [
      Offset(center.dx, center.dy - height * 0.5), // Top point moved up
      Offset(
          center.dx - halfSize * 0.8, center.dy + height * 0.3), // Bottom left
      Offset(
          center.dx + halfSize * 0.8, center.dy + height * 0.3), // Bottom right
    ];
  }

  // Diamond-shaped collision for enemies with better edge detection
  static bool checkEnemyCollision(
      Offset enemyPos, double enemySize, Offset otherPos, double otherSize) {
    // Adjust enemy hitbox to be slightly wider
    final dx = (otherPos.dx - enemyPos.dx).abs();
    final dy = (otherPos.dy - enemyPos.dy).abs();
    final halfWidth = enemySize * 0.6; // Wider hitbox
    final halfHeight = enemySize * 0.5;

    // Modified diamond shape check with adjusted proportions
    return (dx / halfWidth + dy / halfHeight) <=
        1.1; // Slightly larger collision area
  }

  // Circular collision for asteroids with size-based adjustment
  static bool checkAsteroidCollision(Offset asteroidPos, double asteroidSize,
      Offset otherPos, double otherSize) {
    final dx = otherPos.dx - asteroidPos.dx;
    final dy = otherPos.dy - asteroidPos.dy;
    final distanceSquared = dx * dx + dy * dy;

    // Adjust collision radius based on asteroid health/size
    final collisionRadius =
        (asteroidSize + otherSize) * 0.45; // Slightly smaller than visual size
    return distanceSquared <= collisionRadius * collisionRadius;
  }

  // Improved boss collision with more accurate wing hitboxes
  static bool checkBossCollision(
      Offset bossPos, double bossSize, Offset otherPos, double otherSize) {
    // Main body (elliptical)
    final dx = (otherPos.dx - bossPos.dx) / (bossSize * 0.4); // Wider ellipse
    final dy =
        (otherPos.dy - bossPos.dy) / (bossSize * 0.35); // Shorter ellipse
    if (dx * dx + dy * dy <= 1.0) {
      return true;
    }

    // Improved wing hitboxes
    final wingWidth = bossSize * 0.45;
    final wingHeight = bossSize * 0.25;
    final leftWingX = bossPos.dx - bossSize * 0.6;
    final rightWingX = bossPos.dx + bossSize * 0.15;
    final wingY = bossPos.dy;

    // Check left wing with angled hitbox
    if (_checkAngledRect(
      otherPos,
      otherSize,
      Offset(leftWingX, wingY),
      wingWidth,
      wingHeight,
      -15.0, // Angle in degrees
    )) {
      return true;
    }

    // Check right wing with angled hitbox
    return _checkAngledRect(
      otherPos,
      otherSize,
      Offset(rightWingX, wingY),
      wingWidth,
      wingHeight,
      15.0, // Angle in degrees
    );
  }

  // Improved projectile collision with direction-based hitbox
  static bool checkProjectileCollision(Offset projectilePos,
      double projectileSize, Offset otherPos, double otherSize) {
    final dx = otherPos.dx - projectilePos.dx;
    final dy = otherPos.dy - projectilePos.dy;
    final distanceSquared = dx * dx + dy * dy;

    // Use elongated hitbox for projectiles
    final radiusX = projectileSize * 0.6; // Wider horizontally
    final radiusY = projectileSize * 0.4; // Narrower vertically

    // Elliptical collision check
    return (dx * dx) / (radiusX * radiusX) + (dy * dy) / (radiusY * radiusY) <=
        1.0;
  }

  // Helper for triangle collision
  static bool _pointInTriangle(Offset p, Offset a, Offset b, Offset c) {
    final area = 0.5 *
        (-b.dy * c.dx +
            a.dy * (-b.dx + c.dx) +
            a.dx * (b.dy - c.dy) +
            b.dx * c.dy);
    final s = 1 /
        (2 * area) *
        (a.dy * c.dx -
            a.dx * c.dy +
            (c.dy - a.dy) * p.dx +
            (a.dx - c.dx) * p.dy);
    final t = 1 /
        (2 * area) *
        (a.dx * b.dy -
            a.dy * b.dx +
            (a.dy - b.dy) * p.dx +
            (b.dx - a.dx) * p.dy);
    return s >= 0 && t >= 0 && (1 - s - t) >= 0;
  }

  // Helper to get points around a circle for better collision detection
  static List<Offset> _getCirclePoints(Offset center, double radius) {
    final points = <Offset>[];
    const numPoints = 8;
    for (int i = 0; i < numPoints; i++) {
      final angle = 2 * math.pi * i / numPoints;
      points.add(Offset(
        center.dx + radius * math.cos(angle),
        center.dy + radius * math.sin(angle),
      ));
    }
    return points;
  }

  // Helper for checking collision with angled rectangles (for boss wings)
  static bool _checkAngledRect(Offset point, double pointSize,
      Offset rectCenter, double width, double height, double angleDegrees) {
    final angle = angleDegrees * math.pi / 180.0;
    final cos = math.cos(-angle);
    final sin = math.sin(-angle);

    // Transform point to rectangle's local space
    final dx = point.dx - rectCenter.dx;
    final dy = point.dy - rectCenter.dy;
    final localX = dx * cos - dy * sin;
    final localY = dx * sin + dy * cos;

    // Check if point is inside rectangle
    return localX.abs() <= width / 2 + pointSize / 2 &&
        localY.abs() <= height / 2 + pointSize / 2;
  }
}
