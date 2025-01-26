import 'package:flutter/material.dart';

class GameConstants {
  // Game mechanics
  static const int targetFPS = 60;
  static const double minSpeedMultiplier = 0.5;
  static const double maxSpeedMultiplier = 2.0;
  static const int scorePerKill = 100;
  static const Duration gameLoopDuration =
      Duration(milliseconds: 16); // ~60 FPS
  static const Duration invulnerabilityDuration = Duration(seconds: 2);

  // Window settings
  static const String appTitle = 'Space Shooter';
  static const double minWindowWidth = 1067;
  static const double minWindowHeight = 600;

  // Play area settings
  static const double playAreaPadding = 100.0;
  static const double borderWidth = 2.0;
  static const double collisionDistance = 30.0;

  // Asteroid settings
  static const int asteroidCount = 6;
  static const double asteroidSize = 50.0;
  static const double baseAsteroidSpeed = 1.0;
  static const double maxAsteroidSpeedVariation = 1.0;
  static const int baseAsteroidHealth = 3;
  static const int asteroidHealthIncreaseLevel = 2;

  // Bonus settings
  static const int bonusMultiplierValue = 2;
  static const int bonusGoldValue = 500;
  static const double bonusRotationStep = 0.05;
  static const double bonusDropRate = 0.3;
  static const double bonusSize = 30.0;

  // Colors
  static const Color backgroundColor = Colors.black;
  static const Color borderColor = Colors.white;
  static const Color overlayColor = Colors.black54;
}
