import 'package:flutter/material.dart';
import '../../utils/constants/gameplay_constants.dart';
import '../../utils/constants/animation_constants.dart';
import '../../utils/high_scores.dart';

class GameStateManager extends ChangeNotifier {
  int _score = 0;
  int _level = 1;
  int _lives = GameplayConstants.initialLives;
  bool _isGameOver = false;
  bool _isInvulnerable = false;
  int _novaBlastsRemaining = GameplayConstants.initialNovaBlasts;

  // Getters
  int get score => _score;
  int get level => _level;
  int get lives => _lives;
  bool get isGameOver => _isGameOver;
  bool get isInvulnerable => _isInvulnerable;
  int get novaBlastsRemaining => _novaBlastsRemaining;

  void incrementScore() {
    _score += GameplayConstants.scoreIncrement;
    notifyListeners();
  }

  void incrementLevel() {
    _level++;
    notifyListeners();
  }

  void useNovaBlast() {
    if (_novaBlastsRemaining > 0) {
      _novaBlastsRemaining--;
      notifyListeners();
    }
  }

  void handleCollision() {
    if (!_isInvulnerable) {
      _lives--;
      if (_lives <= 0) {
        gameOver();
      } else {
        _isInvulnerable = true;
        Future.delayed(AnimationConstants.invulnerabilityDuration, () {
          _isInvulnerable = false;
          notifyListeners();
        });
      }
      notifyListeners();
    }
  }

  void gameOver() {
    _isGameOver = true;
    HighScoreService.addScore(_score);
    notifyListeners();
  }

  void reset() {
    _score = 0;
    _level = 1;
    _lives = GameplayConstants.initialLives;
    _isGameOver = false;
    _isInvulnerable = false;
    _novaBlastsRemaining = GameplayConstants.initialNovaBlasts;
    notifyListeners();
  }
}
