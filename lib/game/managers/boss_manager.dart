import 'package:flutter/material.dart';
import '../../utils/constants/gameplay_constants.dart';
import '../entities/boss.dart';
import '../entities/enemy.dart';
import 'entity_manager.dart';
import 'game_state_manager.dart';

class BossManager {
  Boss? _boss;
  bool _isBossFight = false;
  final GameStateManager _gameState;
  final EntityManager _entityManager;
  final Size _screenSize;

  BossManager(this._gameState, this._entityManager, this._screenSize);

  Boss? get boss => _boss;
  bool get isBossFight => _isBossFight;

  void startBossFight() {
    _isBossFight = true;
    _boss = Boss(
      position: Offset(
        _screenSize.width / 2,
        _screenSize.height * GameplayConstants.enemySpawnHeightRatio,
      ),
      speed: GameplayConstants.baseEnemySpeed * 2,
      health: GameplayConstants.enemyCount * 2,
    );
  }

  void update() {
    if (_boss != null) {
      _boss!.update(_screenSize, _entityManager.player.position);
      _handleBossAttacks();
    }
  }

  void _handleBossAttacks() {
    if (_boss != null && _boss!.canAttack() && !_boss!.isAiming()) {
      _boss!.startAiming();
      Future.delayed(const Duration(seconds: 2), () {
        if (_boss != null) {
          final attackType = _boss!.chooseAttack();
          if (attackType == BossAttackType.nova) {
            _fireBossNova();
          } else {
            _spawnEnemyShips();
          }
        }
      });
    }
  }

  void _fireBossNova() {
    // Implementation for boss nova attack
  }

  void _spawnEnemyShips() {
    if (_boss != null) {
      final enemies = List.generate(3, (index) {
        final xOffset = (index - 1) * GameplayConstants.enemySize * 2;
        return Enemy(
          position: Offset(
            _boss!.position.dx + xOffset,
            _boss!.position.dy + GameplayConstants.enemySize,
          ),
          speed: GameplayConstants.baseEnemySpeed,
          health: 1,
        );
      });
      _entityManager.addEnemies(enemies);
    }
  }

  void handleBossDamage(int damage) {
    if (_boss != null) {
      _boss!.takeDamage(damage);
      if (_boss!.health <= 0) {
        _handleBossDefeat();
      }
    }
  }

  void _handleBossDefeat() {
    _isBossFight = false;
    _boss = null;
    _gameState.incrementLevel();
  }

  void reset() {
    _boss = null;
    _isBossFight = false;
  }
}
