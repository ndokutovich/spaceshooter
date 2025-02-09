import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../../../../entities/bonus_item.dart';
import '../config/bonus_visual_config.dart';

/// Controller for managing bonus item animations and visual state
class BonusController extends ChangeNotifier {
  double _rotation = 0.0;
  late BonusType _type;
  late BonusVisualConfig _config;

  /// Current rotation angle in radians
  double get rotation => _rotation;

  /// Current bonus type
  BonusType get type => _type;

  /// Current visual configuration
  BonusVisualConfig get config => _config;

  BonusController({
    required BonusType type,
    double initialRotation = 0.0,
  }) {
    _type = type;
    _rotation = initialRotation;
    _config = BonusVisualConfig.forType(type);
  }

  /// Update rotation by the given delta
  void updateRotation(double delta) {
    _rotation = (_rotation + delta) % (2 * math.pi);
    notifyListeners();
  }

  /// Update bonus type and corresponding visual configuration
  void updateType(BonusType newType) {
    if (_type != newType) {
      _type = newType;
      _config = BonusVisualConfig.forType(newType);
      notifyListeners();
    }
  }

  /// Update visual configuration
  void updateConfig(BonusVisualConfig newConfig) {
    _config = newConfig;
    notifyListeners();
  }
}
