import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'enemy.dart';
import '../utils/constants.dart';

enum BossAttackType {
  nova,
  spawnShips,
}

class Boss {
  Offset position;
  double speed;
  int health;
  int maxHealth;
  double targetX;
  bool isMovingRight;
  DateTime? lastAttackTime;
  static const attackCooldown = Duration(seconds: 3);
  static const aimDuration = Duration(seconds: 1);
  DateTime? aimStartTime;

  Boss({
    required this.position,
    this.speed = 3.0,
    this.health = 100,
  })  : maxHealth = health,
        targetX = position.dx,
        isMovingRight = true;

  void update(Size screenSize, Offset playerPosition) {
    // Update target position to match player's X coordinate
    targetX = playerPosition.dx;

    // Move towards target
    double dx = 0;
    if ((position.dx - targetX).abs() > speed) {
      dx = position.dx > targetX ? -speed : speed;
      isMovingRight = dx > 0;
    }

    position = Offset(
      (position.dx + dx).clamp(
        GameConstants.playAreaPadding + 100,
        screenSize.width - GameConstants.playAreaPadding - 100,
      ),
      position.dy,
    );
  }

  bool canAttack() {
    if (lastAttackTime == null) return true;
    return DateTime.now().difference(lastAttackTime!) >= attackCooldown;
  }

  bool isAiming() {
    if (aimStartTime == null) return false;
    return DateTime.now().difference(aimStartTime!) < aimDuration;
  }

  void startAiming() {
    aimStartTime = DateTime.now();
  }

  BossAttackType chooseAttack() {
    lastAttackTime = DateTime.now();
    return math.Random().nextBool()
        ? BossAttackType.nova
        : BossAttackType.spawnShips;
  }

  List<Enemy> spawnShips(Size screenSize) {
    return [
      Enemy(
        position: Offset(position.dx - 50, position.dy + 50),
        speed: 3.0,
        health: 2,
      ),
      Enemy(
        position: Offset(position.dx + 50, position.dy + 50),
        speed: 3.0,
        health: 2,
      ),
    ];
  }

  double get healthPercentage => health / maxHealth;
}
