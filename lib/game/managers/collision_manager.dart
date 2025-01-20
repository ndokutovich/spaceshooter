import '../entities/enemy.dart';
import '../entities/projectile.dart';
import './entity_manager.dart';
import './game_state_manager.dart';
import '../../utils/constants/gameplay_constants.dart';

class CollisionManager {
  final EntityManager entityManager;
  final GameStateManager gameState;

  CollisionManager({
    required this.entityManager,
    required this.gameState,
  });

  void checkCollisions() {
    final projectilesToRemove = <Projectile>{};
    final enemiesToRemove = <Enemy>{};

    // Check projectile-enemy collisions
    for (var projectile in entityManager.projectiles) {
      for (var enemy in entityManager.enemies) {
        if ((projectile.position - enemy.position).distance <
            GameplayConstants.collisionDistance) {
          enemy.health--;
          projectilesToRemove.add(projectile);
          if (enemy.health <= 0) {
            enemiesToRemove.add(enemy);
            gameState.incrementScore(GameplayConstants.scorePerKill);
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
            GameplayConstants.collisionDistance) {
          playerHit = true;
          break;
        }
      }

      // Check player-enemy collisions if not already hit
      if (!playerHit) {
        for (var enemy in entityManager.enemies) {
          if ((entityManager.player.position - enemy.position).distance <
              GameplayConstants.collisionDistance) {
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
