import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'enemy.dart';
import '../../utils/constants/gameplay_constants.dart';

enum BossAttackType {
  nova,
  spawnShips,
}

class Boss {
  Offset position;
  double speed;
  int health;
  int maxHealth;
  Offset targetPosition;
  bool isMovingRight;
  DateTime? lastAttackTime;
  DateTime? lastMoveTime;
  static const attackCooldown = Duration(seconds: 3);
  static const postActionDelay = Duration(seconds: 2);
  static const aimDuration = Duration(seconds: 1);
  DateTime? aimStartTime;

  Boss({
    required this.position,
    this.speed = 3.0,
    this.health = 100,
  })  : maxHealth = health,
        targetPosition = position,
        isMovingRight = true;

  void update(Size screenSize, Offset playerPosition) {
    final now = DateTime.now();
    final canMove = lastAttackTime == null ||
        now.difference(lastAttackTime!) > postActionDelay;

    if (!canMove) return;

    // Update target position randomly if reached or enough time passed
    if ((position - targetPosition).distance < speed * 2 ||
        (lastMoveTime != null &&
            now.difference(lastMoveTime!) > const Duration(seconds: 3))) {
      final random = math.Random();
      targetPosition = Offset(
        random.nextDouble() *
                (screenSize.width - 2 * GameplayConstants.playAreaPadding) +
            GameplayConstants.playAreaPadding,
        random.nextDouble() * screenSize.height * 0.25 + // Only in top quarter
            screenSize.height * 0.05, // Minimum distance from top
      );
      lastMoveTime = now;
    }

    // Move towards target
    final dx = targetPosition.dx - position.dx;
    final dy = targetPosition.dy - position.dy;
    final distance = math.sqrt(dx * dx + dy * dy);

    // Normalize and apply speed
    final directionX = distance > 0 ? (dx / distance) * speed : 0;
    final directionY = distance > 0 ? (dy / distance) * speed : 0;
    isMovingRight = directionX > 0;

    position = Offset(
      (position.dx + directionX).clamp(
        GameplayConstants.playAreaPadding,
        screenSize.width - GameplayConstants.playAreaPadding,
      ),
      (position.dy + directionY).clamp(
        screenSize.height * 0.05,
        screenSize.height * 0.3,
      ),
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

  void takeDamage(int damage) {
    health -= damage;
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
