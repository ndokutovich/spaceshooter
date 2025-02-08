import 'package:flutter/material.dart';
import 'dart:math';
import '../../utils/constants/game/player_config.dart';
import 'projectile.dart';

/// Represents the player entity in the game.
/// This class is responsible for managing the player's state and behavior.
class PlayerEntity {
  /// Current position of the player
  Offset position;

  /// Current velocity of the player
  Offset velocity = Offset.zero;

  /// Current rotation angle in radians
  double rotation = 0;

  /// Whether the player is currently invulnerable
  bool isInvulnerable = false;

  /// Whether the player is currently accelerating
  bool isAccelerating = false;

  /// Current health of the player
  int health;

  /// Current number of lives
  int lives;

  /// Current number of nova blasts available
  int novaBlasts;

  /// Player configuration
  final PlayerConfig config;

  /// Creates a new player entity with the given configuration
  PlayerEntity({
    this.position = const Offset(0, 0),
    this.config = const PlayerConfig(),
  })  : health = 100, // Default health value
        lives = config.initialLives,
        novaBlasts = 3; // Default nova blast count

  /// Updates the player's state based on the current game state
  void update(Size screenSize, double deltaTime) {
    // Apply acceleration if the player is accelerating
    if (isAccelerating) {
      final acceleration = Offset(
        -sin(rotation) * config.acceleration * deltaTime,
        -cos(rotation) * config.acceleration * deltaTime,
      );
      velocity += acceleration;
    } else {
      // Apply deceleration
      velocity *= (1 - config.deceleration * deltaTime);
    }

    // Clamp velocity to max speed
    final speed = velocity.distance;
    if (speed > config.maxSpeed) {
      velocity = velocity * (config.maxSpeed / speed);
    }

    // Update position
    position += velocity;

    // Clamp position to screen bounds
    position = Offset(
      position.dx.clamp(
        config.startHeightRatio,
        screenSize.width - config.startHeightRatio,
      ),
      position.dy.clamp(0, screenSize.height),
    );
  }

  /// Moves the player by the given delta
  void move(Offset delta, Size screenSize) {
    position += delta * config.speed;
    position = Offset(
      position.dx.clamp(
        config.startHeightRatio,
        screenSize.width - config.startHeightRatio,
      ),
      position.dy.clamp(0, screenSize.height),
    );
  }

  /// Rotates the player by the given delta
  void rotate(double delta) {
    rotation = (rotation + delta * config.rotationSpeed) % (2 * pi);
  }

  /// Creates a projectile from the player's current position
  Projectile shoot() {
    return Projectile(
      position: Offset(
        position.dx - sin(rotation) * config.primaryWeapon.offset,
        position.dy - cos(rotation) * config.primaryWeapon.offset,
      ),
      speed: config.primaryWeapon.speed,
      damage: 1, // Default damage value
      isEnemy: false,
    );
  }

  /// Creates a nova blast projectile pattern
  List<Projectile> useNovaBlast() {
    if (novaBlasts <= 0) return [];

    novaBlasts--;
    final projectiles = <Projectile>[];
    final angleStep = 2 * pi / 12; // Default to 12 projectiles

    for (var i = 0; i < 12; i++) {
      final angle = i * angleStep;
      projectiles.add(
        Projectile(
          position: position,
          speed: 8.0, // Default speed value
          damage: 2, // Default damage value
          isEnemy: false,
          angle: angle,
        ),
      );
    }

    return projectiles;
  }

  /// Applies damage to the player
  void takeDamage(int damage) {
    if (isInvulnerable) return;
    health -= damage;
    if (health <= 0) {
      lives--;
      if (lives > 0) {
        health = 100; // Default health value
        isInvulnerable = true;
      }
    }
  }

  /// Regenerates health over time
  void regenerateHealth(double deltaTime) {
    if (health < 100) {
      // Default max health value
      health += (config.healthRegenRate * deltaTime).floor();
      if (health > 100) {
        // Default max health value
        health = 100;
      }
    }
  }

  /// Adds a nova blast to the player's inventory
  void addNovaBlast() {
    if (novaBlasts < 5) {
      // Default max nova blast count
      novaBlasts++;
    }
  }

  /// Returns true if the player is dead (no lives remaining)
  bool get isDead => lives <= 0;
}
