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
import '../../utils/constants/ui_constants.dart';

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
  int _novaBlastsRemaining = old_game_constants.GameConstants.initialNovaBlasts;
  int _lives = old_game_constants.GameConstants.initialLives;
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
          isResume ? UIConstants.countdownText1 : UIConstants.countdownText3;
    });

    if (isResume) {
      Future.delayed(UIConstants.countdownDuration, () {
        if (!mounted) return;
        setState(() {
          _countdownText = UIConstants.countdownTextGo;
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
      Future.delayed(UIConstants.countdownDuration, () {
        if (!mounted) return;
        setState(() => _countdownText = UIConstants.countdownText2);

        Future.delayed(UIConstants.countdownDuration, () {
          if (!mounted) return;
          setState(() => _countdownText = UIConstants.countdownText1);

          Future.delayed(UIConstants.countdownDuration, () {
            if (!mounted) return;
            setState(() {
              _countdownText = UIConstants.countdownTextGo;
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
          old_game_constants.GameConstants.playerSize,
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
            old_game_constants.GameConstants.playerSize,
            projectile.position,
            old_game_constants.GameConstants.projectileWidth,
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
          old_game_constants.GameConstants.bossSize,
          projectile.position,
          old_game_constants.GameConstants.projectileWidth,
        )) {
          _boss!.health -= projectile.damage;
          projectilesToRemove.add(projectile);
          if (_boss!.health <= 0) {
            _score += old_game_constants.GameConstants.bossScoreValue;
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
            old_game_constants.GameConstants.asteroidSize,
            projectile.position,
            old_game_constants.GameConstants.projectileWidth,
          )) {
            asteroid.health -= projectile.damage;
            projectilesToRemove.add(projectile);
            if (asteroid.health <= 0) {
              asteroidsToRemove.add(asteroid);
              _score += UIConstants.scoreIncrement;
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
              old_game_constants.GameConstants.enemySize,
              projectile.position,
              old_game_constants.GameConstants.projectileWidth,
            )) {
              enemy.health -= projectile.damage;
              projectilesToRemove.add(projectile);
              if (enemy.health <= 0) {
                enemiesToRemove.add(enemy);
                _score += UIConstants.scoreIncrement;
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
          old_game_constants.GameConstants.playerSize,
          enemy.position,
          old_game_constants.GameConstants.enemySize,
        )) {
          playerHit = true;
          break;
        }
      }

      if (!playerHit) {
        for (var asteroid in _asteroids) {
          if (CollisionUtils.checkPlayerCollision(
            _player.position,
            old_game_constants.GameConstants.playerSize,
            asteroid.position,
            old_game_constants.GameConstants.asteroidSize,
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
          _damageMultiplier *=
              old_game_constants.GameConstants.bonusMultiplierValue;
        });
        break;
      case BonusType.goldOre:
        setState(() {
          _score += old_game_constants.GameConstants.bonusGoldValue;
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
          _screenSize.height *
              old_game_constants.GameConstants.bossStartHeightRatio,
        ),
        speed: old_game_constants.GameConstants.bossSpeed,
        health: old_game_constants.GameConstants.bossHealth,
      );
    });
  }

  void _fireBossNova() {
    if (_boss == null) return;
    setState(() {
      for (double angle = 0;
          angle < 360;
          angle += old_game_constants.GameConstants.bossNovaAngleStep) {
        _projectiles.add(
          Projectile(
            position: _boss!.position,
            speed: old_game_constants.GameConstants.projectileSpeed *
                old_game_constants
                    .GameConstants.bossNovaProjectileSpeedMultiplier,
            isEnemy: true,
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
              color: UIConstants.borderColor.withOpacity(0.3),
            ),
          ),
          Positioned(
            right: _config.gameplay.playAreaPadding,
            top: 0,
            bottom: 0,
            child: Container(
              width: _config.gameplay.borderWidth,
              color: UIConstants.borderColor.withOpacity(0.3),
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
                    old_game_constants.GameConstants.projectileWidth / 2,
                top: projectile.position.dy -
                    old_game_constants.GameConstants.projectileHeight / 2,
                child: const ProjectileWidget(),
              )),
          ..._enemies.map((enemy) => Positioned(
                left: enemy.position.dx -
                    old_game_constants.GameConstants.enemySize / 2,
                top: enemy.position.dy -
                    old_game_constants.GameConstants.enemySize / 2,
                child: const EnemyWidget(),
              )),
          ..._asteroids.map((asteroid) => Positioned(
                left: asteroid.position.dx -
                    old_game_constants.GameConstants.asteroidSize / 2,
                top: asteroid.position.dy -
                    old_game_constants.GameConstants.asteroidSize / 2,
                child: AsteroidWidget(health: asteroid.health),
              )),

          // UI Elements
          SafeArea(
            child: Stack(
              children: [
                // Score and Level
                Positioned(
                  top: UIConstants.uiPadding,
                  left: UIConstants.uiPadding,
                  child: Text(
                    '${UIConstants.scoreText}$_score\n${UIConstants.levelText}$_level',
                    style: TextStyle(
                      color: UIConstants.textColor,
                      fontSize: old_game_constants.GameConstants.scoreTextSize,
                    ),
                  ),
                ),
                // Lives Counter
                Positioned(
                  top: UIConstants.uiPadding,
                  right:
                      UIConstants.uiPadding * UIConstants.uiPaddingMultiplier,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(width: UIConstants.uiElementSpacing),
                      GameObjectWidget(
                        painter: game_painters.HeartPainter(
                          color: UIConstants.playerColor,
                        ),
                        size: old_game_constants.GameConstants.livesIconSize,
                      ),
                      SizedBox(width: UIConstants.uiElementSpacing),
                      Text(
                        'x $_lives',
                        style: TextStyle(
                          color: UIConstants.enemyColor,
                          fontSize:
                              old_game_constants.GameConstants.livesTextSize,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                // Close button
                Positioned(
                  top: UIConstants.uiPadding,
                  right: UIConstants.uiPadding,
                  child: space_buttons.RoundSpaceButton(
                    text: UIConstants.pauseButtonText,
                    onPressed: _togglePause,
                    color: UIConstants.playerColor,
                    size: 40,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),

          // Controls - 5px from left screen edge with container for visibility
          Positioned(
            left: 5.0,
            bottom: UIConstants.uiPadding +
                old_game_constants.GameConstants.actionButtonSize,
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.white.withOpacity(0.2),
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
            bottom: UIConstants.uiPadding +
                old_game_constants.GameConstants.actionButtonSize,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                space_buttons.RoundSpaceButton(
                  text: _damageMultiplier > 1
                      ? '$_damageMultiplier×'
                      : UIConstants.fireText,
                  onPressed: _shoot,
                  color: UIConstants.enemyColor,
                  size: old_game_constants.GameConstants.actionButtonSize,
                ),
                SizedBox(height: UIConstants.actionButtonSpacing),
                space_buttons.RoundSpaceButton(
                  text: UIConstants.novaText,
                  onPressed: _fireNova,
                  color: UIConstants.projectileColor,
                  size: old_game_constants.GameConstants.actionButtonSize,
                  counterWidget: CustomPaint(
                    size: Size(old_game_constants.GameConstants.novaCounterSize,
                        old_game_constants.GameConstants.novaCounterSize),
                    painter: game_painters.NovaCounterPainter(
                      color: UIConstants.playerColor,
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
              color: Colors.black
                  .withOpacity(old_game_constants.GameConstants.overlayOpacity),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      UIConstants.gameOverText,
                      style: TextStyle(
                        color: UIConstants.enemyColor,
                        fontSize:
                            old_game_constants.GameConstants.gameOverTextSize,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                        height:
                            old_game_constants.GameConstants.gameOverSpacing),
                    Text(
                      '${UIConstants.scoreText}$_score',
                      style: TextStyle(
                        color: UIConstants.textColor,
                        fontSize: old_game_constants
                            .GameConstants.scoreDisplayTextSize,
                      ),
                    ),
                    SizedBox(
                        height:
                            old_game_constants.GameConstants.gameOverSpacing),
                    MenuButton(
                      text: UIConstants.mainMenuText,
                      onPressed: () {
                        Navigator.of(context).pop();
                        Navigator.of(context).pushReplacement(
                          FadeSlideTransition(page: const MainMenu()),
                        );
                      },
                      width: _screenSize.width *
                          old_game_constants.GameConstants.menuButtonWidthRatio,
                      height: _screenSize.height *
                          old_game_constants
                              .GameConstants.menuButtonHeightRatio,
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
              color: Colors.black
                  .withOpacity(old_game_constants.GameConstants.overlayOpacity),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      UIConstants.pausedText,
                      style: TextStyle(
                        color: UIConstants.playerColor,
                        fontSize:
                            old_game_constants.GameConstants.gameOverTextSize,
                        fontWeight: FontWeight.bold,
                        shadows: [
                          Shadow(
                            color: UIConstants.playerColor.withOpacity(0.5),
                            blurRadius: 10,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                        height:
                            old_game_constants.GameConstants.gameOverSpacing),
                    MenuButton(
                      text: UIConstants.resumeText,
                      onPressed: _togglePause,
                      width: _screenSize.width *
                          old_game_constants.GameConstants.menuButtonWidthRatio,
                      height: _screenSize.height *
                          old_game_constants
                              .GameConstants.menuButtonHeightRatio,
                    ),
                    SizedBox(
                        height: _screenSize.height *
                            old_game_constants
                                .GameConstants.menuButtonSpacingRatio),
                    MenuButton(
                      text: UIConstants.mainMenuText,
                      onPressed: () {
                        Navigator.of(context).pop();
                        Navigator.of(context).pushReplacement(
                          FadeSlideTransition(page: const MainMenu()),
                        );
                      },
                      width: _screenSize.width *
                          old_game_constants.GameConstants.menuButtonWidthRatio,
                      height: _screenSize.height *
                          old_game_constants
                              .GameConstants.menuButtonHeightRatio,
                    ),
                    SizedBox(
                        height: _screenSize.height *
                            old_game_constants
                                .GameConstants.menuButtonSpacingRatio),
                    MenuButton(
                      text: UIConstants.menuExitText,
                      onPressed: () => SystemNavigator.pop(),
                      width: _screenSize.width *
                          old_game_constants.GameConstants.menuButtonWidthRatio,
                      height: _screenSize.height *
                          old_game_constants
                              .GameConstants.menuButtonHeightRatio,
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
              color: Colors.black54,
              child: Center(
                child: Text(
                  _countdownText,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: UIConstants.playerColor,
                    fontSize: UIConstants.countdownTextSize,
                    fontWeight: FontWeight.bold,
                    shadows: [
                      Shadow(
                        color: UIConstants.playerColor.withOpacity(0.5),
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
              right: UIConstants.uiPadding,
              top: UIConstants.uiPadding,
              child: GameObjectWidget(
                painter: game_painters.NovaCounterPainter(
                  color: UIConstants.playerColor,
                  count: _novaBlastsRemaining.toString(),
                ),
                size: old_game_constants.GameConstants.novaCounterDisplaySize,
              ),
            ),

          // Boss
          if (_boss != null)
            Positioned(
              left: _boss!.position.dx -
                  old_game_constants.GameConstants.bossSize / 2,
              top: _boss!.position.dy -
                  old_game_constants.GameConstants.bossSize / 2,
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
