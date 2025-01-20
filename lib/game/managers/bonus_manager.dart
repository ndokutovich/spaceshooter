import 'dart:math';
import 'package:flutter/material.dart';
import '../../utils/constants/gameplay_constants.dart';
import '../entities/bonus_item.dart';
import 'game_state_manager.dart';

class BonusManager {
  final List<BonusItem> _bonusItems = [];
  final GameStateManager _gameState;
  final Random _random = Random();

  BonusManager(this._gameState);

  List<BonusItem> get bonusItems => List.unmodifiable(_bonusItems);

  void update() {
    for (var i = 0; i < _bonusItems.length; i++) {
      final bonus = _bonusItems[i];
      _bonusItems[i] = BonusItem(
        type: bonus.type,
        position: bonus.position,
        rotation: bonus.rotation + GameplayConstants.bonusRotationStep,
        size: bonus.size,
      );
    }
  }

  void collectBonus(BonusType type) {
    switch (type) {
      case BonusType.damageMultiplier:
        _gameState.multiplyDamage(GameplayConstants.bonusMultiplierValue);
        break;
      case BonusType.goldOre:
        _gameState.incrementScore(GameplayConstants.bonusGoldValue);
        break;
    }
  }

  void handleEnemyDestroyed(Offset position) {
    if (_shouldDropBonus()) {
      _bonusItems.add(BonusItem(
        type:
            _random.nextBool() ? BonusType.damageMultiplier : BonusType.goldOre,
        position: position,
        rotation: 0,
        size: GameplayConstants.bonusSize,
      ));
    }
  }

  bool _shouldDropBonus() {
    return _random.nextDouble() < GameplayConstants.bonusDropRate;
  }

  void removeBonus(BonusItem bonus) {
    _bonusItems.remove(bonus);
  }

  void reset() {
    _bonusItems.clear();
  }
}
