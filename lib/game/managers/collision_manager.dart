import '../entities/enemy.dart';
import '../entities/projectile.dart';
import './entity_manager.dart';
import './game_state_manager.dart';
import '../../utils/constants/game/config.dart';

class CollisionManager {
  final EntityManager entityManager;
  final GameStateManager gameState;
  final GameConfig config;

  CollisionManager({
    required this.entityManager,
    required this.gameState,
    this.config = const GameConfig(),
  });

  void checkCollisions() {
    final projectilesToRemove = <Projectile>{};
    final enemiesToRemove = <Enemy>{};

    // Check projectile-enemy collisions
    for (var projectile in entityManager.projectiles) {
      for (var enemy in entityManager.enemies) {
        if ((projectile.position - enemy.position).distance <
            config.gameplay.collisionDistance) {
          enemy.health--;
          projectilesToRemove.add(projectile);
          if (enemy.health <= 0) {
            enemiesToRemove.add(enemy);
            gameState.incrementScore(config.gameplay.scorePerKill);
          }
          break;
        }
      }
    }

    // Check player-asteroid collisions
    bool playerHit = false;
    if (!gameState.isInvulnerable) {
      for (var asteroid in entityManager.asteroids) {
        if ((entityManager.player.position - asteroid.position).distance <
            config.gameplay.collisionDistance) {
          playerHit = true;
          break;
        }
      }

      // Check player-enemy collisions if not already hit
      if (!playerHit) {
        for (var enemy in entityManager.enemies) {
          if ((entityManager.player.position - enemy.position).distance <
              config.gameplay.collisionDistance) {
            playerHit = true;
            break;
          }
        }
      }
    }

    // Apply collision results
    for (var projectile in projectilesToRemove) {
      entityManager.removeProjectile(projectile);
    }
    for (var enemy in enemiesToRemove) {
      entityManager.removeEnemy(enemy);
    }
    if (playerHit) {
      gameState.handleCollision();
    }
  }
}
