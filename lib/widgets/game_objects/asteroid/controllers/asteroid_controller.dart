import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../config/asteroid_visual_config.dart';

/// Controller for managing asteroid animations and visual state
class AsteroidController extends ChangeNotifier {
  double _rotation = 0.0;
  int _health = 3;
  late AsteroidVisualConfig _config;
  late AsteroidVisualConfig _currentConfig;

  /// Current rotation angle in radians
  double get rotation => _rotation;

  /// Current health value
  int get health => _health;

  /// Base visual configuration
  AsteroidVisualConfig get config => _config;

  /// Current visual configuration adjusted for damage
  AsteroidVisualConfig get currentConfig => _currentConfig;

  AsteroidController({
    AsteroidVisualConfig? config,
    int initialHealth = 3,
    double initialRotation = 0.0,
  }) {
    _health = initialHealth;
    _rotation = initialRotation;
    _config = config ?? const AsteroidVisualConfig();
    _currentConfig = _config.withDamage(_health);
  }

  /// Update rotation by the given delta
  void updateRotation(double delta) {
    _rotation = (_rotation + delta) % (2 * math.pi);
    notifyListeners();
  }

  /// Set health value and update visual configuration
  void setHealth(int value) {
    if (_health != value) {
      _health = value;
      _currentConfig = _config.withDamage(_health);
      notifyListeners();
    }
  }

  /// Update visual configuration
  void updateConfig(AsteroidVisualConfig newConfig) {
    _config = newConfig;
    _currentConfig = _config.withDamage(_health);
    notifyListeners();
  }
}
