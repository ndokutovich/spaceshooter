import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'dart:math' as math;

import '../../widgets/controls.dart';
import '../../widgets/menu_button.dart';
import '../entities/player.dart';
import '../entities/enemy.dart';
import '../entities/projectile.dart';
import '../entities/asteroid.dart';
import '../../utils/app_constants.dart';
import '../../widgets/background.dart';
import '../utils/constants.dart';
import '../utils/painters.dart' as game_painters;
import '../../utils/high_scores.dart';
import '../../widgets/game_objects.dart';
import '../../entities/bonus_item.dart';
import '../../widgets/round_space_button.dart' as space_buttons;

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> with TickerProviderStateMixin {
  final Player _player = Player();
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
  int _novaBlastsRemaining = GameConstants.initialNovaBlasts;
  int _lives = GameConstants.initialLives;
  bool _isInvulnerable = false;
  final Set<LogicalKeyboardKey> _pressedKeys = {};
  List<BonusItem> _bonusItems = [];
  int _damageMultiplier = 1;

  void _startCountdown({bool isResume = false}) {
    setState(() {
      _isCountingDown = true;
      _countdownText =
          isResume ? AppConstants.countdownText1 : AppConstants.countdownText3;
    });

    if (isResume) {
      Future.delayed(AppConstants.countdownDuration, () {
        if (!mounted) return;
        setState(() {
          _countdownText = AppConstants.countdownTextGo;
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
      Future.delayed(AppConstants.countdownDuration, () {
        if (!mounted) return;
        setState(() => _countdownText = AppConstants.countdownText2);

        Future.delayed(AppConstants.countdownDuration, () {
          if (!mounted) return;
          setState(() => _countdownText = AppConstants.countdownText1);

          Future.delayed(AppConstants.countdownDuration, () {
            if (!mounted) return;
            setState(() {
              _countdownText = AppConstants.countdownTextGo;
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
    HardwareKeyboard.instance.addHandler(_handleKeyEvent);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _screenSize = MediaQuery.of(context).size;
      _player.position = Offset(
        _screenSize.width / 2,
        _screenSize.height * GameConstants.playerStartHeightRatio,
      );
      _startCountdown();
    });
    _keyboardMoveTimer = Timer.periodic(AppConstants.gameLoopDuration, (_) {
      _handleKeyboardMovement();
    });
  }

  void _startGame() {
    _spawnEnemies();
    _spawnAsteroids();
    _gameLoop = Timer.periodic(
      AppConstants.gameLoopDuration,
      _update,
    );
  }

  bool _handleKeyEvent(KeyEvent event) {
    if (event is KeyDownEvent) {
      _pressedKeys.add(event.logicalKey);

      if (event.logicalKey == LogicalKeyboardKey.space &&
          !_isGameOver &&
          !_isPaused) {
        _fireNova();
        return true;
      } else if (event.logicalKey == LogicalKeyboardKey.keyF && !_isPaused) {
        _shoot();
      } else if (event.logicalKey == LogicalKeyboardKey.escape) {
        _togglePause();
      }
    } else if (event is KeyUpEvent) {
      _pressedKeys.remove(event.logicalKey);
    }
    return false;
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
      AppConstants.gameLoopDuration,
      _update,
    );
    _keyboardMoveTimer = Timer.periodic(AppConstants.gameLoopDuration, (_) {
      _handleKeyboardMovement();
    });
  }

  void _handleKeyboardMovement() {
    if (_pressedKeys.isEmpty || _isPaused) return;

    double dx = 0;
    double dy = 0;

    if (_pressedKeys.contains(LogicalKeyboardKey.keyW) ||
        _pressedKeys.contains(LogicalKeyboardKey.arrowUp)) {
      dy -= GameConstants.playerSpeed;
    }
    if (_pressedKeys.contains(LogicalKeyboardKey.keyS) ||
        _pressedKeys.contains(LogicalKeyboardKey.arrowDown)) {
      dy += GameConstants.playerSpeed;
    }
    if (_pressedKeys.contains(LogicalKeyboardKey.keyA) ||
        _pressedKeys.contains(LogicalKeyboardKey.arrowLeft)) {
      dx -= GameConstants.playerSpeed;
    }
    if (_pressedKeys.contains(LogicalKeyboardKey.keyD) ||
        _pressedKeys.contains(LogicalKeyboardKey.arrowRight)) {
      dx += GameConstants.playerSpeed;
    }

    if (dx != 0 || dy != 0) {
      setState(() {
        _player.move(Offset(dx, dy), _screenSize);
      });
    }
  }

  void _handleJoystickMove(Offset delta) {
    if (_isPaused) return;

    _moveTimer?.cancel();
    if (delta != Offset.zero) {
      _moveTimer = Timer.periodic(const Duration(milliseconds: 16), (timer) {
        setState(() {
          _player.move(delta, _screenSize);
        });
      });
    } else {
      _moveTimer = null;
    }
  }

  void _spawnEnemies() {
    _enemies.clear();
    final random = math.Random();
    for (int i = 0; i < GameConstants.enemyCount; i++) {
      _enemies.add(
        Enemy(
          position: Offset(
            GameConstants.playAreaPadding +
                random.nextDouble() *
                    (_screenSize.width - 2 * GameConstants.playAreaPadding),
            random.nextDouble() *
                _screenSize.height *
                GameConstants.enemySpawnHeightRatio,
          ),
          speed: GameConstants.baseEnemySpeed +
              _level * GameConstants.enemyLevelSpeedIncrease,
          health: GameConstants.baseEnemyHealth +
              (_level ~/ GameConstants.enemyHealthIncreaseLevel),
        ),
      );
    }
  }

  void _spawnAsteroids() {
    _asteroids.clear();
    final random = math.Random();
    for (int i = 0; i < GameConstants.asteroidCount; i++) {
      _asteroids.add(
        Asteroid(
          position: Offset(
            GameConstants.playAreaPadding +
                random.nextDouble() *
                    (_screenSize.width - 2 * GameConstants.playAreaPadding),
            random.nextDouble() *
                _screenSize.height *
                GameConstants.enemySpawnHeightRatio,
          ),
          speed: GameConstants.baseAsteroidSpeed +
              random.nextDouble() * GameConstants.maxAsteroidSpeedVariation,
          health: GameConstants.baseAsteroidHealth +
              (_level ~/ GameConstants.asteroidHealthIncreaseLevel),
        ),
      );
    }
  }

  void _shoot() {
    if (_isPaused || _isGameOver || _isCountingDown) return;
    HapticFeedback.mediumImpact();
    setState(() {
      _projectiles.add(
        Projectile(
          position:
              _player.position.translate(0, -GameConstants.projectileOffset),
          speed: GameConstants.projectileSpeed,
          isEnemy: false,
          angle: -90,
          damage: _damageMultiplier,
        ),
      );
    });
  }

  void _fireNova() {
    if (_isPaused) return;
    if (_novaBlastsRemaining > 0) {
      HapticFeedback.heavyImpact();
      setState(() {
        for (double angle = 0; angle < 360; angle += 45) {
          _projectiles.add(
            Projectile(
              position: _player.position,
              speed: GameConstants.projectileSpeed,
              isEnemy: false,
              angle: angle,
            ),
          );
        }
        _novaBlastsRemaining--;
      });
    }
  }

  void _handleCollision() {
    if (!_isInvulnerable) {
      setState(() {
        _lives--;
        if (_lives <= 0) {
          _gameOver();
        } else {
          _isInvulnerable = true;
          Future.delayed(AppConstants.invulnerabilityDuration, () {
            if (mounted) {
              setState(() {
                _isInvulnerable = false;
              });
            }
          });
        }
      });
    }
  }

  void _checkCollisions() {
    // Check projectile collisions
    List<Projectile> projectilesToRemove = [];
    List<Enemy> enemiesToRemove = [];
    List<Asteroid> asteroidsToRemove = [];

    for (var projectile in _projectiles) {
      // Check asteroid hits first
      for (var asteroid in _asteroids) {
        if ((projectile.position - asteroid.position).distance <
            GameConstants.collisionDistance) {
          asteroid.health -= projectile.damage;
          projectilesToRemove.add(projectile);
          if (asteroid.health <= 0) {
            asteroidsToRemove.add(asteroid);
            _score += AppConstants.scoreIncrement;
            _handleAsteroidDestroyed(asteroid.position);
          }
          break;
        }
      }

      // If projectile hasn't hit an asteroid, check enemy hits
      if (!projectilesToRemove.contains(projectile)) {
        for (var enemy in _enemies) {
          if ((projectile.position - enemy.position).distance <
              GameConstants.collisionDistance) {
            enemy.health -= projectile.damage;
            projectilesToRemove.add(projectile);
            if (enemy.health <= 0) {
              enemiesToRemove.add(enemy);
              _score += AppConstants.scoreIncrement;
              _handleEnemyDestroyed(enemy.position);
            }
            break;
          }
        }
      }
    }

    bool playerHit = false;

    for (var asteroid in _asteroids) {
      if ((_player.position - asteroid.position).distance <
          GameConstants.collisionDistance) {
        playerHit = true;
        break;
      }
    }

    if (!playerHit) {
      for (var enemy in _enemies) {
        if ((_player.position - enemy.position).distance <
            GameConstants.collisionDistance) {
          playerHit = true;
          break;
        }
      }
    }

    _projectiles.removeWhere((p) => projectilesToRemove.contains(p));
    _enemies.removeWhere((e) => enemiesToRemove.contains(e));
    _asteroids.removeWhere((a) => asteroidsToRemove.contains(a));

    if (playerHit) {
      _handleCollision();
    }
  }

  void _update(Timer timer) {
    if (_isGameOver || _isPaused || _isCountingDown) return;

    // Update bonus items rotation
    for (var bonus in _bonusItems) {
      setState(() {
        final newBonus = BonusItem(
          type: bonus.type,
          position: bonus.position,
          rotation: bonus.rotation + 0.05,
          size: bonus.size,
        );
        _bonusItems[_bonusItems.indexOf(bonus)] = newBonus;
      });
    }

    // Check for bonus item collection
    final playerRect = Rect.fromCenter(
      center: _player.position,
      width: AppConstants.playerSize,
      height: AppConstants.playerSize,
    );

    _bonusItems.toList().forEach((bonus) {
      final bonusRect = Rect.fromCenter(
        center: bonus.position,
        width: bonus.size,
        height: bonus.size,
      );

      if (playerRect.overlaps(bonusRect)) {
        setState(() {
          _bonusItems.remove(bonus);
          _collectBonus(bonus.type);
        });
      }
    });

    setState(() {
      for (var projectile in _projectiles) {
        projectile.update();
      }
      _projectiles.removeWhere((projectile) =>
          projectile.position.dy < 0 ||
          projectile.position.dy > _screenSize.height ||
          projectile.position.dx < GameConstants.playAreaPadding ||
          projectile.position.dx >
              _screenSize.width - GameConstants.playAreaPadding);

      for (var enemy in _enemies) {
        enemy.update(_screenSize);
      }

      for (var asteroid in _asteroids) {
        asteroid.update(_screenSize);
      }

      _checkCollisions();

      if (_enemies.isEmpty) {
        _level++;
        _spawnEnemies();
        _spawnAsteroids();
      }
    });
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
          _damageMultiplier *= 2; // Stack multipliers
        });
        break;
      case BonusType.goldOre:
        setState(() {
          _score += 500;
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
            left: GameConstants.playAreaPadding,
            top: 0,
            bottom: 0,
            child: Container(
              width: GameConstants.borderWidth,
              color: AppConstants.borderColor.withOpacity(0.3),
            ),
          ),
          Positioned(
            right: GameConstants.playAreaPadding,
            top: 0,
            bottom: 0,
            child: Container(
              width: GameConstants.borderWidth,
              color: AppConstants.borderColor.withOpacity(0.3),
            ),
          ),

          // Player
          Positioned(
            left: _player.position.dx - GameConstants.playerSize / 2,
            top: _player.position.dy - GameConstants.playerSize / 2,
            child: Opacity(
              opacity: _isInvulnerable ? 0.5 : 1.0,
              child: const PlayerWidget(),
            ),
          ),

          // Game objects
          ..._projectiles.map((projectile) => Positioned(
                left:
                    projectile.position.dx - GameConstants.projectileWidth / 2,
                top:
                    projectile.position.dy - GameConstants.projectileHeight / 2,
                child: const ProjectileWidget(),
              )),
          ..._enemies.map((enemy) => Positioned(
                left: enemy.position.dx - GameConstants.enemySize / 2,
                top: enemy.position.dy - GameConstants.enemySize / 2,
                child: const EnemyWidget(),
              )),
          ..._asteroids.map((asteroid) => Positioned(
                left: asteroid.position.dx - GameConstants.asteroidSize / 2,
                top: asteroid.position.dy - GameConstants.asteroidSize / 2,
                child: AsteroidWidget(health: asteroid.health),
              )),

          // UI Elements
          SafeArea(
            child: Stack(
              children: [
                // Score and Level
                Positioned(
                  top: AppConstants.uiPadding,
                  left: AppConstants.uiPadding,
                  child: Text(
                    '${AppConstants.scoreText}$_score\n${AppConstants.levelText}$_level',
                    style: TextStyle(
                      color: AppConstants.textColor,
                      fontSize: GameConstants.scoreTextSize,
                    ),
                  ),
                ),
                // Lives Counter
                Positioned(
                  top: AppConstants.uiPadding,
                  right:
                      AppConstants.uiPadding * AppConstants.uiPaddingMultiplier,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(width: AppConstants.uiElementSpacing),
                      CustomPaint(
                        size: Size(GameConstants.livesIconSize,
                            GameConstants.livesIconSize),
                        painter: game_painters.HeartPainter(
                          color: AppConstants.playerColor,
                        ),
                      ),
                      SizedBox(width: AppConstants.uiElementSpacing),
                      Text(
                        'x $_lives',
                        style: TextStyle(
                          color: AppConstants.enemyColor,
                          fontSize: GameConstants.livesTextSize,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                // Close button
                Positioned(
                  top: AppConstants.uiPadding,
                  right: AppConstants.uiPadding,
                  child: space_buttons.RoundSpaceButton(
                    text: AppConstants.pauseButtonText,
                    onPressed: _togglePause,
                    color: AppConstants.playerColor,
                    size: 40,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),

          // Controls
          Positioned(
            left: AppConstants.uiPadding,
            bottom: AppConstants.uiPadding,
            child: JoystickController(
              onMove: _handleJoystickMove,
            ),
          ),

          // Action buttons
          Positioned(
            right: AppConstants.uiPadding,
            bottom: AppConstants.uiPadding,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                space_buttons.RoundSpaceButton(
                  text: _damageMultiplier > 1
                      ? '${_damageMultiplier}×'
                      : AppConstants.fireText,
                  onPressed: _shoot,
                  color: AppConstants.enemyColor,
                  size: 70,
                ),
                SizedBox(height: AppConstants.actionButtonSpacing),
                space_buttons.RoundSpaceButton(
                  text: AppConstants.novaText,
                  onPressed: _fireNova,
                  color: AppConstants.projectileColor,
                  size: 70,
                  counterWidget: CustomPaint(
                    size: const Size(30, 30),
                    painter: game_painters.NovaCounterPainter(
                      color: AppConstants.playerColor,
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
              color: Colors.black54,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      AppConstants.gameOverText,
                      style: TextStyle(
                        color: AppConstants.enemyColor,
                        fontSize: GameConstants.gameOverTextSize,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: GameConstants.gameOverSpacing),
                    Text(
                      '${AppConstants.scoreText}$_score',
                      style: TextStyle(
                        color: AppConstants.textColor,
                        fontSize: GameConstants.scoreDisplayTextSize,
                      ),
                    ),
                    SizedBox(height: GameConstants.gameOverSpacing),
                    SpaceButton(
                      text: AppConstants.mainMenuText,
                      onPressed: () => Navigator.of(context).pop(),
                      width: AppConstants.menuButtonWidth,
                      height: AppConstants.menuButtonHeight,
                      fontSize: AppConstants.titleFontSize * 0.5,
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
              color: Colors.black54,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      AppConstants.pausedText,
                      style: TextStyle(
                        color: AppConstants.playerColor,
                        fontSize: GameConstants.gameOverTextSize,
                        fontWeight: FontWeight.bold,
                        shadows: [
                          Shadow(
                            color: AppConstants.playerColor.withOpacity(0.5),
                            blurRadius: 10,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: GameConstants.gameOverSpacing),
                    MenuButton(
                      text: AppConstants.resumeText,
                      onPressed: _togglePause,
                    ),
                    SizedBox(height: AppConstants.menuButtonSpacing),
                    MenuButton(
                      text: AppConstants.mainMenuText,
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                    SizedBox(height: AppConstants.menuButtonSpacing),
                    MenuButton(
                      text: AppConstants.menuExitText,
                      onPressed: () => SystemNavigator.pop(),
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
                  style: TextStyle(
                    color: AppConstants.playerColor,
                    fontSize: AppConstants.countdownTextSize,
                    fontWeight: FontWeight.bold,
                    shadows: [
                      Shadow(
                        color: AppConstants.playerColor.withOpacity(0.5),
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

          // Health display
          Positioned(
            left: 20,
            top: 20,
            child: Row(
              children: List.generate(
                _lives,
                (index) => Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: GameObjectWidget(
                    painter: game_painters.HeartPainter(
                      color: AppConstants.playerColor,
                    ),
                    size: 30,
                  ),
                ),
              ),
            ),
          ),

          // Nova counter
          if (_novaBlastsRemaining > 0)
            Positioned(
              right: 20,
              top: 20,
              child: GameObjectWidget(
                painter: game_painters.NovaCounterPainter(
                  color: AppConstants.playerColor,
                  count: _novaBlastsRemaining.toString(),
                ),
                size: 40,
              ),
            ),
        ],
      ),
    );
  }
}
