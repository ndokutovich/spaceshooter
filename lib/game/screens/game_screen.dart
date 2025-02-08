import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'dart:math' as math;

import '../../widgets/controls.dart';
import '../../widgets/menu_button.dart';
import '../../widgets/performance_overlay.dart';
import '../../widgets/background.dart';
import '../../widgets/game_objects.dart';
import '../../widgets/round_space_button.dart' as space_buttons;
import '../../widgets/game_objects/heart_painter.dart';
import '../../widgets/game_objects/nova_counter_painter.dart';
import '../../widgets/game_objects/bonus_painter.dart';

import '../entities/player_entity.dart';
import '../entities/enemy.dart';
import '../entities/projectile.dart';
import '../entities/asteroid.dart';
import '../entities/boss.dart';
import '../entities/bonus_item.dart';

import '../controllers/player_controller.dart';
import '../views/player_view.dart';

import '../../utils/constants/game/config.dart';
import '../../utils/high_scores.dart';
import '../../utils/transitions.dart';
import '../../utils/collision_utils.dart';

import '../../screens/main_menu.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> with TickerProviderStateMixin {
  late final PlayerEntity _player;
  late final PlayerController _playerController;
  final List<Enemy> _enemies = [];
  final List<Projectile> _projectiles = [];
  final List<Asteroid> _asteroids = [];
  Timer? _gameLoop;
  Timer? _moveTimer;
  Timer? _keyboardMoveTimer;
  int _score = 0;
  int _level = 1;
  bool _isGameOver = false;
  bool _isPaused = false;
  bool _isCountingDown = false;
  String _countdownText = '';
  late Size _screenSize;
  int _novaBlastsRemaining = 0;
  int _lives = 0;
  bool _isInvulnerable = false;
  final Set<LogicalKeyboardKey> _pressedKeys = {};
  final List<BonusItem> _bonusItems = [];
  int _damageMultiplier = 1;
  Boss? _boss;
  bool _isBossFight = false;
  final GameConfig _config = const GameConfig();

  void _startCountdown({bool isResume = false}) {
    setState(() {
      _isCountingDown = true;
      _countdownText =
          isResume ? _config.ui.countdownText1 : _config.ui.countdownText3;
    });

    if (isResume) {
      Future.delayed(_config.gameplay.countdownDuration, () {
        if (!mounted) return;
        setState(() {
          _countdownText = _config.ui.countdownTextGo;
          Future.delayed(const Duration(milliseconds: 500), () {
            if (!mounted) return;
            setState(() {
              _isCountingDown = false;
              _countdownText = '';
              _resumeGame();
            });
          });
        });
      });
    } else {
      Future.delayed(_config.gameplay.countdownDuration, () {
        if (!mounted) return;
        setState(() => _countdownText = _config.ui.countdownText2);

        Future.delayed(_config.gameplay.countdownDuration, () {
          if (!mounted) return;
          setState(() => _countdownText = _config.ui.countdownText1);

          Future.delayed(_config.gameplay.countdownDuration, () {
            if (!mounted) return;
            setState(() {
              _countdownText = _config.ui.countdownTextGo;
              Future.delayed(const Duration(milliseconds: 500), () {
                if (!mounted) return;
                setState(() {
                  _isCountingDown = false;
                  _countdownText = '';
                  _startGame();
                });
              });
            });
          });
        });
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _player = PlayerEntity(config: _config.player);
    _playerController = PlayerController(player: _player);
    _novaBlastsRemaining = _config.player.nova.initialBlasts;
    _lives = _config.player.initialLives;
    HardwareKeyboard.instance.addHandler(_handleKeyEvent);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _screenSize = MediaQuery.of(context).size;
      _player.position = Offset(
        (_screenSize.width - 2 * _config.gameplay.playAreaPadding) / 2 +
            _config.gameplay.playAreaPadding,
        _screenSize.height * _config.player.startHeightRatio,
      );
      _startCountdown();
    });
    _keyboardMoveTimer = Timer.periodic(
      Duration(milliseconds: 1000 ~/ _config.gameplay.targetFPS),
      (_) {
        _playerController.handleKeyboardMovement(_screenSize);
      },
    );
  }

  void _startGame() {
    _spawnEnemies();
    _spawnAsteroids();
    _gameLoop = Timer.periodic(
      Duration(milliseconds: 1000 ~/ _config.gameplay.targetFPS),
      _update,
    );
  }

  bool _handleKeyEvent(KeyEvent event) {
    if (_isGameOver || _isPaused) return false;
    return _playerController.handleKeyEvent(event);
  }

  void _togglePause() {
    if (_isGameOver || _isCountingDown) return;

    setState(() {
      _isPaused = !_isPaused;
      if (_isPaused) {
        _gameLoop?.cancel();
        _moveTimer?.cancel();
        _keyboardMoveTimer?.cancel();
      } else {
        _startCountdown(isResume: true);
      }
    });
  }

  void _resumeGame() {
    _gameLoop = Timer.periodic(
      Duration(milliseconds: 1000 ~/ _config.gameplay.targetFPS),
      _update,
    );
    _keyboardMoveTimer = Timer.periodic(
      Duration(milliseconds: 1000 ~/ _config.gameplay.targetFPS),
      (_) {
        _playerController.handleKeyboardMovement(_screenSize);
      },
    );
  }

  void _handleJoystickMove(Offset movement) {
    if (_isPaused) return;
    setState(() {
      _player.move(movement * _config.player.speed, _screenSize);
    });
  }

  void _spawnEnemies() {
    _enemies.clear();
    final random = math.Random();
    for (int i = 0; i < _config.gameplay.asteroids.count; i++) {
      _enemies.add(
        Enemy(
          position: Offset(
            _config.gameplay.playAreaPadding +
                random.nextDouble() *
                    (_screenSize.width - 2 * _config.gameplay.playAreaPadding),
            random.nextDouble() *
                _screenSize.height *
                _config.player.startHeightRatio,
          ),
          speed: _config.gameplay.difficulty.levelSpeedIncrease * _level,
          health: 1 +
              (_level - 1) ~/ _config.gameplay.difficulty.healthIncreaseLevel,
        ),
      );
    }
  }

  void _spawnAsteroids() {
    _asteroids.clear();
    final random = math.Random();
    for (int i = 0; i < _config.gameplay.asteroids.count; i++) {
      _asteroids.add(
        Asteroid(
          position: Offset(
            _config.gameplay.playAreaPadding +
                random.nextDouble() *
                    (_screenSize.width - 2 * _config.gameplay.playAreaPadding),
            random.nextDouble() *
                _screenSize.height *
                _config.player.startHeightRatio,
          ),
          speed: _config.gameplay.asteroids.baseSpeed +
              random.nextDouble() *
                  _config.gameplay.asteroids.maxSpeedVariation,
        ),
      );
    }
  }

  void _update(Timer timer) {
    if (_isPaused) return;

    setState(() {
      // Update player
      _playerController.update(_screenSize, 1.0 / _config.gameplay.targetFPS);

      // Update projectiles
      for (var projectile in _projectiles) {
        projectile.update();
      }
      _projectiles.removeWhere((projectile) =>
          projectile.position.dy < 0 ||
          projectile.position.dy > _screenSize.height ||
          projectile.position.dx < _config.gameplay.playAreaPadding ||
          projectile.position.dx >
              _screenSize.width - _config.gameplay.playAreaPadding);

      // Update enemies
      for (var enemy in _enemies) {
        enemy.update(_screenSize);
      }

      // Update asteroids
      for (var asteroid in _asteroids) {
        asteroid.update(_screenSize);
      }

      // Check collisions
      _checkCollisions();
    });
  }

  void _checkCollisions() {
    final projectilesToRemove = <Projectile>{};
    final enemiesToRemove = <Enemy>{};
    final asteroidsToRemove = <Asteroid>{};
    final bonusesToRemove = <BonusItem>{};
    bool playerHit = false;

    // Check player bonus collection
    if (!_isGameOver) {
      for (var bonus in _bonusItems) {
        if (CollisionUtils.checkPlayerCollision(
          _player.position,
          _config.player.size,
          bonus.position,
          bonus.size,
        )) {
          bonusesToRemove.add(bonus);
          _collectBonus(bonus.type);
        }
      }
    }

    // Check projectile collisions
    for (var projectile in _projectiles) {
      if (projectile.isEnemy) {
        if (!_isInvulnerable && !playerHit) {
          if (CollisionUtils.checkPlayerCollision(
            _player.position,
            _config.player.size,
            projectile.position,
            _config.player.primaryWeapon.width,
          )) {
            projectilesToRemove.add(projectile);
            playerHit = true;
          }
        }
        continue;
      }

      // Check boss hits first
      if (_boss != null) {
        if (CollisionUtils.checkBossCollision(
          _boss!.position,
          _config.player.size * 2, // Boss size is double player size
          projectile.position,
          _config.player.primaryWeapon.width,
        )) {
          _boss!.health -= projectile.damage;
          projectilesToRemove.add(projectile);
          if (_boss!.health <= 0) {
            _score += (_config.gameplay.scorePerKill *
                    _config.gameplay.difficulty.bossScoreMultiplier)
                .toInt();
            _boss = null;
          }
          continue;
        }
      }

      // Check other collisions only if projectile hasn't hit boss
      if (!projectilesToRemove.contains(projectile)) {
        bool hit = false;

        // Check asteroid hits
        for (var asteroid in _asteroids) {
          if (CollisionUtils.checkAsteroidCollision(
            asteroid.position,
            _config.gameplay.asteroids.size,
            projectile.position,
            _config.player.primaryWeapon.width,
          )) {
            asteroid.health -= projectile.damage;
            projectilesToRemove.add(projectile);
            if (asteroid.health <= 0) {
              asteroidsToRemove.add(asteroid);
              _score += _config.gameplay.scorePerKill;
              _handleAsteroidDestroyed(asteroid.position);
            }
            hit = true;
            break;
          }
        }

        // Check enemy hits if no asteroid was hit
        if (!hit) {
          for (var enemy in _enemies) {
            if (CollisionUtils.checkEnemyCollision(
              enemy.position,
              _config.gameplay.asteroids.size,
              projectile.position,
              _config.player.primaryWeapon.width,
            )) {
              enemy.health -= projectile.damage;
              projectilesToRemove.add(projectile);
              if (enemy.health <= 0) {
                enemiesToRemove.add(enemy);
                _score += _config.gameplay.scorePerKill;
                _handleEnemyDestroyed(enemy.position);
              }
              break;
            }
          }
        }
      }
    }

    // Check direct collisions with player
    if (!_isInvulnerable && !playerHit) {
      for (var enemy in _enemies) {
        if (CollisionUtils.checkPlayerCollision(
          _player.position,
          _config.player.size,
          enemy.position,
          _config.gameplay.asteroids.size,
        )) {
          playerHit = true;
          break;
        }
      }

      if (!playerHit) {
        for (var asteroid in _asteroids) {
          if (CollisionUtils.checkPlayerCollision(
            _player.position,
            _config.player.size,
            asteroid.position,
            _config.gameplay.asteroids.size,
          )) {
            playerHit = true;
            break;
          }
        }
      }
    }

    // Apply all changes in a single setState
    if (projectilesToRemove.isNotEmpty ||
        enemiesToRemove.isNotEmpty ||
        asteroidsToRemove.isNotEmpty ||
        bonusesToRemove.isNotEmpty ||
        playerHit) {
      setState(() {
        _projectiles.removeWhere((p) => projectilesToRemove.contains(p));
        _enemies.removeWhere((e) => enemiesToRemove.contains(e));
        _asteroids.removeWhere((a) => asteroidsToRemove.contains(a));
        _bonusItems.removeWhere((b) => bonusesToRemove.contains(b));
        if (playerHit) _handleCollision();
      });
    }
  }

  void _gameOver() {
    setState(() {
      _isGameOver = true;
    });
    _gameLoop?.cancel();
    HighScoreService.addScore(_score);
  }

  void _collectBonus(BonusType type) {
    switch (type) {
      case BonusType.damageMultiplier:
        setState(() {
          _damageMultiplier *= _config.gameplay.bonuses.multiplierValue;
        });
        break;
      case BonusType.goldOre:
        setState(() {
          _score += _config.gameplay.bonuses.goldValue;
        });
        break;
    }
  }

  void _handleEnemyDestroyed(Offset position) {
    if (BonusItem.shouldDropBonus(BonusType.damageMultiplier)) {
      setState(() {
        _bonusItems.add(BonusItem(
          type: BonusType.damageMultiplier,
          position: position,
        ));
      });
    }
  }

  void _handleAsteroidDestroyed(Offset position) {
    if (BonusItem.shouldDropBonus(BonusType.goldOre)) {
      setState(() {
        _bonusItems.add(BonusItem(
          type: BonusType.goldOre,
          position: position,
        ));
      });
    }
  }

  void _startBossFight() {
    setState(() {
      _isBossFight = true;
      _boss = Boss(
        position: Offset(
          _screenSize.width / 2,
          _screenSize.height * _config.player.startHeightRatio,
        ),
        speed: _config.player.speed *
            _config.gameplay.difficulty.bossSpeedMultiplier,
        health: (_config.player.maxHealth *
                _config.gameplay.difficulty.bossHealthMultiplier)
            .toInt(),
      );
    });
  }

  void _fireBossNova() {
    if (_boss == null) return;
    setState(() {
      for (double angle = 0;
          angle < 360;
          angle += _config.gameplay.difficulty.bossNovaAngleStep) {
        _projectiles.add(
          Projectile(
            position: _boss!.position,
            speed: _config.player.primaryWeapon.speed *
                _config.gameplay.difficulty.bossNovaProjectileSpeedMultiplier,
            isEnemy: true,
            angle: angle,
          ),
        );
      }
    });
  }

  void _handleCollision() {
    if (_isInvulnerable) return;
    _lives--;
    if (_lives <= 0) {
      _gameOver();
    } else {
      setState(() {
        _isInvulnerable = true;
        Future.delayed(
            Duration(seconds: _config.player.invulnerabilityDuration.toInt()),
            () {
          if (mounted) {
            setState(() => _isInvulnerable = false);
          }
        });
      });
    }
  }

  void _shoot() {
    if (_isPaused || _isGameOver) return;
    setState(() {
      _projectiles.add(
        Projectile(
          position: _player.position,
          speed: _config.player.primaryWeapon.speed,
          damage: _damageMultiplier,
          isEnemy: false,
        ),
      );
    });
  }

  void _fireNova() {
    if (_isPaused || _isGameOver || _novaBlastsRemaining <= 0) return;
    setState(() {
      _novaBlastsRemaining--;
      for (double angle = 0; angle < 360; angle += 30) {
        _projectiles.add(
          Projectile(
            position: _player.position,
            speed: _config.player.primaryWeapon.speed * 1.5,
            damage: _damageMultiplier * 2,
            isEnemy: false,
            angle: angle,
          ),
        );
      }
    });
  }

  @override
  void dispose() {
    HardwareKeyboard.instance.removeHandler(_handleKeyEvent);
    _keyboardMoveTimer?.cancel();
    _gameLoop?.cancel();
    _moveTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _screenSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          StarBackground(screenSize: _screenSize),

          // Play area borders
          Positioned(
            left: _config.gameplay.playAreaPadding,
            top: 0,
            bottom: 0,
            child: Container(
              width: _config.gameplay.borderWidth,
              color: _config.ui.colors.borderColor
                  .withOpacity(_config.ui.opacity.low),
            ),
          ),
          Positioned(
            right: _config.gameplay.playAreaPadding,
            top: 0,
            bottom: 0,
            child: Container(
              width: _config.gameplay.borderWidth,
              color: _config.ui.colors.borderColor
                  .withOpacity(_config.ui.opacity.low),
            ),
          ),

          // Player
          Positioned(
            left: _player.position.dx - _config.player.size / 2,
            top: _player.position.dy - _config.player.size / 2,
            child: PlayerView(player: _player),
          ),

          // Game objects
          ..._projectiles.map((projectile) => Positioned(
                left: projectile.position.dx -
                    _config.player.primaryWeapon.width / 2,
                top: projectile.position.dy -
                    _config.player.primaryWeapon.height / 2,
                child: const ProjectileWidget(),
              )),
          ..._enemies.map((enemy) => Positioned(
                left: enemy.position.dx - _config.gameplay.asteroids.size / 2,
                top: enemy.position.dy - _config.gameplay.asteroids.size / 2,
                child: const EnemyWidget(),
              )),
          ..._asteroids.map((asteroid) => Positioned(
                left:
                    asteroid.position.dx - _config.gameplay.asteroids.size / 2,
                top: asteroid.position.dy - _config.gameplay.asteroids.size / 2,
                child: AsteroidWidget(health: asteroid.health),
              )),

          // UI Elements
          SafeArea(
            child: Stack(
              children: [
                // Score and Level
                Positioned(
                  top: _config.ui.uiPadding,
                  left: _config.ui.uiPadding,
                  child: Text(
                    'Score: $_score\nLevel: $_level',
                    style: TextStyle(
                      color: _config.ui.colors.textColor,
                      fontSize: _config.ui.textStyles.score,
                    ),
                  ),
                ),
                // Lives Counter
                Positioned(
                  top: _config.ui.uiPadding,
                  right: _config.ui.uiPadding * 2,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(width: _config.ui.uiElementSpacing),
                      GameObjectWidget(
                        painter: HeartPainter(
                          color: _config.ui.colors.playerColor,
                        ),
                        size: _config.player.livesIconSize,
                      ),
                      SizedBox(width: _config.ui.uiElementSpacing),
                      Text(
                        'x $_lives',
                        style: TextStyle(
                          color: _config.ui.colors.enemyColor,
                          fontSize: _config.ui.textStyles.lives,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                // Close button
                Positioned(
                  top: _config.ui.uiPadding,
                  right: _config.ui.uiPadding,
                  child: space_buttons.RoundSpaceButton(
                    text: 'Pause',
                    onPressed: _togglePause,
                    color: _config.ui.colors.playerColor,
                    size: _config.ui.actionButtonSize,
                    fontSize: _config.ui.textStyles.button,
                  ),
                ),
              ],
            ),
          ),

          // Controls - 5px from left screen edge with container for visibility
          Positioned(
            left: 5.0,
            bottom: _config.ui.uiPadding + _config.ui.actionButtonSize,
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: _config.ui.colors.borderColor
                      .withOpacity(_config.ui.opacity.veryLow),
                  width: 1,
                ),
              ),
              child: JoystickController(
                onMove: _handleJoystickMove,
              ),
            ),
          ),

          // Action buttons - 5px from right screen edge
          Positioned(
            right: 5.0,
            bottom: _config.ui.uiPadding + _config.ui.actionButtonSize,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                space_buttons.RoundSpaceButton(
                  text: _damageMultiplier > 1 ? '$_damageMultiplier×' : 'Fire',
                  onPressed: _shoot,
                  color: _config.ui.colors.enemyColor,
                  size: _config.ui.actionButtonSize,
                ),
                SizedBox(height: _config.ui.actionButtonSpacing),
                space_buttons.RoundSpaceButton(
                  text: 'Nova',
                  onPressed: _fireNova,
                  color: _config.ui.colors.projectileColor,
                  size: _config.ui.actionButtonSize,
                  counterWidget: CustomPaint(
                    size: Size(_config.player.novaCounterSize,
                        _config.player.novaCounterSize),
                    painter: NovaCounterPainter(
                      color: _config.ui.colors.playerColor,
                      count: _novaBlastsRemaining.toString(),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Game Over overlay
          if (_isGameOver)
            Container(
              width: _screenSize.width,
              height: _screenSize.height,
              color: Colors.black.withOpacity(_config.ui.opacity.medium),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Game Over',
                      style: TextStyle(
                        color: _config.ui.colors.enemyColor,
                        fontSize: _config.ui.textStyles.gameOver,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: _config.player.gameOverSpacing),
                    Text(
                      'Score: $_score',
                      style: TextStyle(
                        color: _config.ui.colors.textColor,
                        fontSize: _config.ui.textStyles.score,
                      ),
                    ),
                    SizedBox(height: _config.player.gameOverSpacing),
                    MenuButton(
                      text: 'Main Menu',
                      onPressed: () {
                        Navigator.of(context).pop();
                        Navigator.of(context).pushReplacement(
                          FadeSlideTransition(page: const MainMenu()),
                        );
                      },
                      width: _screenSize.width *
                          _config.player.menuButtonWidthRatio,
                      height: _screenSize.height *
                          _config.player.menuButtonHeightRatio,
                    ),
                  ],
                ),
              ),
            ),

          // Pause menu overlay
          if (_isPaused)
            Container(
              width: _screenSize.width,
              height: _screenSize.height,
              color: Colors.black.withOpacity(_config.ui.opacity.medium),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Paused',
                      style: TextStyle(
                        color: _config.ui.colors.playerColor,
                        fontSize: _config.ui.textStyles.gameOver,
                        fontWeight: FontWeight.bold,
                        shadows: [
                          Shadow(
                            color: _config.ui.colors.playerColor
                                .withOpacity(_config.ui.opacity.medium),
                            blurRadius: 10,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: _config.player.gameOverSpacing),
                    MenuButton(
                      text: 'Resume',
                      onPressed: _togglePause,
                      width: _screenSize.width *
                          _config.player.menuButtonWidthRatio,
                      height: _screenSize.height *
                          _config.player.menuButtonHeightRatio,
                    ),
                    SizedBox(
                        height: _screenSize.height *
                            _config.player.menuButtonSpacingRatio),
                    MenuButton(
                      text: 'Main Menu',
                      onPressed: () {
                        Navigator.of(context).pop();
                        Navigator.of(context).pushReplacement(
                          FadeSlideTransition(page: const MainMenu()),
                        );
                      },
                      width: _screenSize.width *
                          _config.player.menuButtonWidthRatio,
                      height: _screenSize.height *
                          _config.player.menuButtonHeightRatio,
                    ),
                    SizedBox(
                        height: _screenSize.height *
                            _config.player.menuButtonSpacingRatio),
                    MenuButton(
                      text: 'Exit',
                      onPressed: () => SystemNavigator.pop(),
                      width: _screenSize.width *
                          _config.player.menuButtonWidthRatio,
                      height: _screenSize.height *
                          _config.player.menuButtonHeightRatio,
                    ),
                  ],
                ),
              ),
            ),

          // Countdown overlay
          if (_isCountingDown)
            Container(
              width: _screenSize.width,
              height: _screenSize.height,
              color: Colors.black.withOpacity(_config.ui.opacity.medium),
              child: Center(
                child: Text(
                  _countdownText,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: _config.ui.colors.textColor,
                    fontSize: _config.ui.textStyles.countdown,
                    fontWeight: FontWeight.bold,
                    shadows: [
                      Shadow(
                        color: _config.ui.colors.textColor.withOpacity(0.5),
                        blurRadius: 20,
                      ),
                    ],
                  ),
                ),
              ),
            ),

          // Draw bonus items
          ..._bonusItems.map((bonus) => Positioned(
                left: bonus.position.dx - bonus.size / 2,
                top: bonus.position.dy - bonus.size / 2,
                child: GameObjectWidget(
                  painter: BonusPainter(
                    type: bonus.type,
                    rotation: bonus.rotation,
                  ),
                  size: bonus.size,
                ),
              )),

          // Nova counter
          if (_novaBlastsRemaining > 0)
            Positioned(
              right: _config.ui.uiPadding,
              top: _config.ui.uiPadding,
              child: GameObjectWidget(
                painter: NovaCounterPainter(
                  color: _config.ui.colors.playerColor,
                  count: _novaBlastsRemaining.toString(),
                ),
                size: _config.player.novaCounterDisplaySize,
              ),
            ),

          // Boss
          if (_boss != null)
            Positioned(
              left: _boss!.position.dx - _config.player.size / 2,
              top: _boss!.position.dy - _config.player.size / 2,
              child: BossWidget(
                healthPercentage: _boss!.healthPercentage,
                isMovingRight: _boss!.isMovingRight,
                isAiming: _boss!.isAiming(),
              ),
            ),

          // Add performance overlay
          const GamePerformanceOverlay(),
        ],
      ),
    );
  }
}
