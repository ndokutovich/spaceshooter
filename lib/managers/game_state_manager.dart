import 'package:flutter/material.dart';
import '../../utils/constants/animation_constants.dart';
import '../../utils/constants/player_constants.dart';
import '../../utils/high_scores.dart';

class GameStateManager extends ChangeNotifier {
  int _score = 0;
  int _level = 1;
  int _lives = PlayerConstants.initialLives;
  bool _isGameOver = false;
  bool _isInvulnerable = false;
  int _novaBlastsRemaining = PlayerConstants.initialNovaBlasts;
  int _damageMultiplier = 1;
  bool _isPaused = false;
  bool _isCountingDown = false;
  String _countdownText = '';

  // Getters
  int get score => _score;
  int get level => _level;
  int get lives => _lives;
  bool get isGameOver => _isGameOver;
  bool get isInvulnerable => _isInvulnerable;
  int get novaBlastsRemaining => _novaBlastsRemaining;
  int get damageMultiplier => _damageMultiplier;
  bool get isPaused => _isPaused;
  bool get isCountingDown => _isCountingDown;
  String get countdownText => _countdownText;

  void incrementScore(int amount) {
    _score += amount;
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

  void multiplyDamage(int multiplier) {
    _damageMultiplier *= multiplier;
    notifyListeners();
  }

  void setPaused(bool paused) {
    _isPaused = paused;
    notifyListeners();
  }

  void setCountdown(bool counting, [String text = '']) {
    _isCountingDown = counting;
    _countdownText = text;
    notifyListeners();
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
    _lives = PlayerConstants.initialLives;
    _isGameOver = false;
    _isInvulnerable = false;
    _novaBlastsRemaining = PlayerConstants.initialNovaBlasts;
    _damageMultiplier = 1;
    _isPaused = false;
    _isCountingDown = false;
    _countdownText = '';
    notifyListeners();
  }
}
