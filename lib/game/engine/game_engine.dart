import 'dart:async';
import 'package:flutter/material.dart';
import '../../utils/constants/animation_constants.dart';
import '../managers/collision_manager.dart';
import '../managers/game_state_manager.dart';
import '../managers/entity_manager.dart';

class GameEngine {
  final GameStateManager gameState;
  final CollisionManager collisionManager;
  final EntityManager entityManager;
  Timer? _gameLoop;
  Size screenSize;

  GameEngine({
    required this.screenSize,
    required this.gameState,
    required this.collisionManager,
    required this.entityManager,
  });

  void start() {
    _gameLoop = Timer.periodic(
      AnimationConstants.gameLoopDuration,
      _update,
    );
  }

  void stop() {
    _gameLoop?.cancel();
  }

  void _update(Timer timer) {
    if (gameState.isGameOver) {
      stop();
      return;
    }

    // Update all entities
    entityManager.updateEntities(screenSize);

    // Check collisions
    collisionManager.checkCollisions();

    // Check win condition
    if (entityManager.enemies.isEmpty) {
      gameState.incrementLevel();
      entityManager.spawnEnemies(screenSize, gameState.level);
      entityManager.spawnAsteroids(screenSize);
    }
  }

  void dispose() {
    stop();
  }
}
