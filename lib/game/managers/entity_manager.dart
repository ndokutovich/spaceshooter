import 'dart:math';
import 'package:flutter/material.dart';
import '../entities/player_entity.dart';
import '../entities/enemy.dart';
import '../entities/projectile.dart';
import '../entities/asteroid.dart';
import '../../utils/constants/game/config.dart';

class EntityManager {
  final PlayerEntity player;
  final List<Enemy> enemies = [];
  final List<Projectile> projectiles = [];
  final List<Asteroid> asteroids = [];
  final GameConfig config;

  EntityManager({
    required this.player,
    this.config = const GameConfig(),
  });

  void updateEntities(Size screenSize, double deltaTime) {
    // Update player
    player.update(screenSize, deltaTime);

    // Update projectiles
    for (var projectile in projectiles) {
      projectile.update();
    }
    projectiles.removeWhere((projectile) =>
        projectile.position.dy < 0 ||
        projectile.position.dy > screenSize.height ||
        projectile.position.dx < config.gameplay.playAreaPadding ||
        projectile.position.dx >
            screenSize.width - config.gameplay.playAreaPadding);

    // Update enemies
    for (var enemy in enemies) {
      enemy.update(screenSize);
    }

    // Update asteroids
    for (var asteroid in asteroids) {
      asteroid.update(screenSize);
    }
  }

  void spawnEnemies(Size screenSize, int level) {
    enemies.clear();
    final random = Random();

    for (int i = 0; i < config.gameplay.asteroids.count; i++) {
      enemies.add(
        Enemy(
          position: Offset(
            config.gameplay.playAreaPadding +
                random.nextDouble() *
                    (screenSize.width - 2 * config.gameplay.playAreaPadding),
            random.nextDouble() *
                screenSize.height *
                0.3, // Default spawn height ratio
          ),
          speed: 2.0 + // Default base speed
              (level - 1) * config.gameplay.difficulty.levelSpeedIncrease,
          health:
              1 + (level - 1) ~/ config.gameplay.difficulty.healthIncreaseLevel,
        ),
      );
    }
  }

  void spawnAsteroids(Size screenSize, int level) {
    asteroids.clear();
    final random = Random();

    for (int i = 0; i < config.gameplay.asteroids.count; i++) {
      asteroids.add(
        Asteroid(
          position: Offset(
            config.gameplay.playAreaPadding +
                random.nextDouble() *
                    (screenSize.width - 2 * config.gameplay.playAreaPadding),
            random.nextDouble() *
                screenSize.height *
                0.3, // Default spawn height ratio
          ),
          speed: config.gameplay.asteroids.baseSpeed +
              random.nextDouble() * config.gameplay.asteroids.maxSpeedVariation,
        ),
      );
    }
  }

  void addProjectile(Projectile projectile) {
    projectiles.add(projectile);
  }

  void removeProjectile(Projectile projectile) {
    projectiles.remove(projectile);
  }

  void removeEnemy(Enemy enemy) {
    enemies.remove(enemy);
  }

  void removeAsteroid(Asteroid asteroid) {
    asteroids.remove(asteroid);
  }

  void addEnemies(List<Enemy> newEnemies) {
    enemies.addAll(newEnemies);
  }
}
