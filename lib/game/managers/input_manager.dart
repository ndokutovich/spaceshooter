import 'package:flutter/services.dart';
import '../controllers/player_controller.dart';
import '../entities/player_entity.dart';
import 'game_state_manager.dart';

class InputManager {
  final PlayerController playerController;
  final GameStateManager _gameState;
  final Size _screenSize;

  InputManager(
    PlayerEntity player,
    this._gameState,
    this._screenSize,
  ) : playerController = PlayerController(player: player);

  bool handleKeyEvent(KeyEvent event) {
    if (_gameState.isPaused) return false;
    return playerController.handleKeyEvent(event);
  }

  void update(double deltaTime) {
    if (_gameState.isPaused) return;
    playerController.handleKeyboardMovement(_screenSize);
    playerController.update(_screenSize, deltaTime);
  }
}
