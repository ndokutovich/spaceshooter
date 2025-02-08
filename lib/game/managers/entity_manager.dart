import 'dart:math';
import 'package:flutter/material.dart';
import '../../utils/constants/asteroid_constants.dart';
import '../entities/player.dart';
import '../entities/enemy.dart';
import '../entities/projectile.dart';
import '../entities/asteroid.dart';
import '../../utils/constants/gameplay_constants.dart';
import '../../utils/constants/enemy_constants.dart';

class EntityManager {
  final Player player;
  final List<Enemy> enemies = [];
  final List<Projectile> projectiles = [];
  final List<Asteroid> asteroids = [];

  EntityManager({required this.player});

  void updateEntities(Size screenSize) {
    // Update projectiles
    for (var projectile in projectiles) {
      projectile.update();
    }
    projectiles.removeWhere((projectile) =>
        projectile.position.dy < 0 ||
        projectile.position.dy > screenSize.height ||
        projectile.position.dx < GameplayConstants.playAreaPadding ||
        projectile.position.dx >
            screenSize.width - GameplayConstants.playAreaPadding);

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

    for (int i = 0; i < EnemyConstants.count; i++) {
      enemies.add(
        Enemy(
          position: Offset(
            GameplayConstants.playAreaPadding +
                random.nextDouble() *
                    (screenSize.width - 2 * GameplayConstants.playAreaPadding),
            random.nextDouble() *
                screenSize.height *
                EnemyConstants.spawnHeightRatio,
          ),
          speed: EnemyConstants.baseSpeed +
              (level - 1) * EnemyConstants.levelSpeedIncrease,
          health: 1 + (level - 1) ~/ EnemyConstants.healthIncreaseLevel,
        ),
      );
    }
  }

  void spawnAsteroids(Size screenSize) {
    asteroids.clear();
    final random = Random();

    for (int i = 0; i < AsteroidConstants.count; i++) {
      asteroids.add(
        Asteroid(
          position: Offset(
            GameplayConstants.playAreaPadding +
                random.nextDouble() *
                    (screenSize.width - 2 * GameplayConstants.playAreaPadding),
            random.nextDouble() *
                screenSize.height *
                EnemyConstants.spawnHeightRatio,
          ),
          speed: AsteroidConstants.baseSpeed +
              random.nextDouble() * AsteroidConstants.maxSpeedVariation,
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

  void addEnemies(List<Enemy> newEnemies) {
    enemies.addAll(newEnemies);
  }
}
