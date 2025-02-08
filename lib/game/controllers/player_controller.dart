import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import '../entities/player_entity.dart';
import '../entities/projectile.dart';

/// Controller class for managing player input and game logic
class PlayerController {
  /// The player entity being controlled
  final PlayerEntity player;

  /// Set of currently pressed keys
  final Set<LogicalKeyboardKey> _pressedKeys = {};

  /// Timer for tracking invulnerability duration
  DateTime? _invulnerabilityStartTime;

  /// Creates a new player controller
  PlayerController({
    required this.player,
  });

  /// Handles keyboard events
  bool handleKeyEvent(KeyEvent event) {
    if (event is KeyDownEvent) {
      _pressedKeys.add(event.logicalKey);
      return _handleKeyPress(event.logicalKey);
    } else if (event is KeyUpEvent) {
      _pressedKeys.remove(event.logicalKey);
      if (event.logicalKey == LogicalKeyboardKey.arrowUp ||
          event.logicalKey == LogicalKeyboardKey.keyW) {
        player.isAccelerating = false;
      }
    }
    return false;
  }

  /// Handles key press events
  bool _handleKeyPress(LogicalKeyboardKey key) {
    if (key == LogicalKeyboardKey.space) {
      player.shoot();
      return true;
    } else if (key == LogicalKeyboardKey.keyN) {
      player.useNovaBlast();
      return true;
    } else if (key == LogicalKeyboardKey.arrowUp ||
        key == LogicalKeyboardKey.keyW) {
      player.isAccelerating = true;
      return true;
    }
    return false;
  }

  /// Updates player movement based on keyboard input
  void handleKeyboardMovement(Size screenSize) {
    double dx = 0;
    double dy = 0;

    if (_pressedKeys.contains(LogicalKeyboardKey.arrowLeft) ||
        _pressedKeys.contains(LogicalKeyboardKey.keyA)) {
      player.rotate(-1);
    }
    if (_pressedKeys.contains(LogicalKeyboardKey.arrowRight) ||
        _pressedKeys.contains(LogicalKeyboardKey.keyD)) {
      player.rotate(1);
    }
    if (_pressedKeys.contains(LogicalKeyboardKey.arrowUp) ||
        _pressedKeys.contains(LogicalKeyboardKey.keyW)) {
      player.isAccelerating = true;
    } else {
      player.isAccelerating = false;
    }

    if (dx != 0 || dy != 0) {
      player.move(Offset(dx, dy), screenSize);
    }
  }

  /// Updates the player's state
  void update(Size screenSize, double deltaTime) {
    player.update(screenSize, deltaTime);
    _updateInvulnerability(deltaTime);
    player.regenerateHealth(deltaTime);
  }

  /// Updates the player's invulnerability state
  void _updateInvulnerability(double deltaTime) {
    if (player.isInvulnerable) {
      if (_invulnerabilityStartTime == null) {
        _invulnerabilityStartTime = DateTime.now();
      } else {
        final duration = DateTime.now().difference(_invulnerabilityStartTime!);
        if (duration.inMilliseconds >=
            player.config.invulnerabilityDuration * 1000) {
          player.isInvulnerable = false;
          _invulnerabilityStartTime = null;
        }
      }
    }
  }

  /// Makes the player invulnerable for a short duration
  void makeInvulnerable() {
    player.isInvulnerable = true;
    _invulnerabilityStartTime = DateTime.now();
  }

  /// Resets the player's state
  void reset() {
    player.isInvulnerable = false;
    player.isAccelerating = false;
    player.velocity = Offset.zero;
    player.rotation = 0;
    _pressedKeys.clear();
    _invulnerabilityStartTime = null;
  }
}
