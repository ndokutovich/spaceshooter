import 'package:flutter/services.dart';
import '../../utils/constants/game/config.dart';
import '../entities/player.dart';
import 'game_state_manager.dart';

class InputManager {
  final Set<LogicalKeyboardKey> _pressedKeys = {};
  final Player _player;
  final GameStateManager _gameState;
  final Size _screenSize;
  final PlayerConfig config;

  InputManager(this._player, this._gameState, this._screenSize,
      {this.config = const PlayerConfig()});

  bool handleKeyEvent(KeyEvent event) {
    if (_gameState.isPaused) return false;

    if (event is KeyDownEvent) {
      _pressedKeys.add(event.logicalKey);
      return _handleKeyPress(event.logicalKey);
    } else if (event is KeyUpEvent) {
      _pressedKeys.remove(event.logicalKey);
    }
    return false;
  }

  bool _handleKeyPress(LogicalKeyboardKey key) {
    if (key == LogicalKeyboardKey.space) {
      _player.shoot();
      return true;
    } else if (key == LogicalKeyboardKey.keyN) {
      _player.useNovaBlast();
      return true;
    }
    return false;
  }

  void handleKeyboardMovement() {
    if (_pressedKeys.isEmpty || _gameState.isPaused) return;

    double dx = 0;
    double dy = 0;

    if (_pressedKeys.contains(LogicalKeyboardKey.arrowLeft) ||
        _pressedKeys.contains(LogicalKeyboardKey.keyA)) {
      dx -= config.speed;
    }
    if (_pressedKeys.contains(LogicalKeyboardKey.arrowRight) ||
        _pressedKeys.contains(LogicalKeyboardKey.keyD)) {
      dx += config.speed;
    }
    if (_pressedKeys.contains(LogicalKeyboardKey.arrowUp) ||
        _pressedKeys.contains(LogicalKeyboardKey.keyW)) {
      dy -= config.speed;
    }
    if (_pressedKeys.contains(LogicalKeyboardKey.arrowDown) ||
        _pressedKeys.contains(LogicalKeyboardKey.keyS)) {
      dy += config.speed;
    }

    if (dx != 0 || dy != 0) {
      _player.move(Offset(dx, dy), _screenSize);
    }
  }

  void handleJoystickMove(Offset delta) {
    if (_gameState.isPaused) return;
    _player.move(delta * config.speed, _screenSize);
  }

  void reset() {
    _pressedKeys.clear();
  }
}
