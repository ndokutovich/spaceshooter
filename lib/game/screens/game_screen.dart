import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'dart:math' as math;

import '../entities/player.dart';
import '../entities/enemy.dart';
import '../entities/projectile.dart';
import '../entities/asteroid.dart';
import '../utils/constants.dart';
import '../../widgets/controls.dart';
import '../widgets/background.dart';
import '../../utils/app_constants.dart';
import '../../widgets/game_objects.dart';

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
  late Size _screenSize;
  int _novaBlastsRemaining = GameConstants.initialNovaBlasts;
  int _lives = GameConstants.initialLives;
  bool _isInvulnerable = false;
  final Set<LogicalKeyboardKey> _pressedKeys = {};

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
      _startGame();
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

      if (event.logicalKey == LogicalKeyboardKey.space && !_isGameOver) {
        _fireNova();
        return true; // Consume the space event
      } else if (event.logicalKey == LogicalKeyboardKey.keyF) {
        _shoot();
      } else if (event.logicalKey == LogicalKeyboardKey.escape) {
        Navigator.of(context).pop();
      }
    } else if (event is KeyUpEvent) {
      _pressedKeys.remove(event.logicalKey);
    }
    return false;
  }

  void _handleKeyboardMovement() {
    if (_pressedKeys.isEmpty) return;

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
          health: 1 + (_level ~/ GameConstants.enemyHealthIncreaseLevel),
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
        ),
      );
    }
  }

  void _shoot() {
    HapticFeedback.mediumImpact();
    setState(() {
      _projectiles.add(
        Projectile(
            position:
                _player.position.translate(0, -GameConstants.projectileOffset),
            speed: GameConstants.projectileSpeed,
            isEnemy: false,
            angle: -90),
      );
    });
  }

  void _fireNova() {
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
    final projectilesToRemove = <Projectile>{};
    final enemiesToRemove = <Enemy>{};

    for (var projectile in _projectiles) {
      for (var enemy in _enemies) {
        if ((projectile.position - enemy.position).distance <
            GameConstants.collisionDistance) {
          enemy.health--;
          projectilesToRemove.add(projectile);
          if (enemy.health <= 0) {
            enemiesToRemove.add(enemy);
            _score += 100;
          }
          break;
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

    if (playerHit) {
      _handleCollision();
    }
  }

  void _update(Timer timer) {
    if (_isGameOver) return;

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
              color: AppConstants.borderColor
                  .withValues(red: 255, green: 255, blue: 255, alpha: 77),
            ),
          ),
          Positioned(
            right: GameConstants.playAreaPadding,
            top: 0,
            bottom: 0,
            child: Container(
              width: GameConstants.borderWidth,
              color: AppConstants.borderColor
                  .withValues(red: 255, green: 255, blue: 255, alpha: 77),
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
                child: const AsteroidWidget(),
              )),

          // UI Elements
          SafeArea(
            child: Stack(
              children: [
                // Score and Level
                Positioned(
                  top: GameConstants.uiPadding,
                  left: GameConstants.uiPadding,
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
                  top: GameConstants.uiPadding,
                  right: GameConstants.uiPadding * 5,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CustomPaint(
                        painter: HeartPainter(color: AppConstants.enemyColor),
                        size: Size(GameConstants.livesIconSize,
                            GameConstants.livesIconSize),
                      ),
                      SizedBox(width: GameConstants.uiElementSpacing),
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
                  top: GameConstants.uiPadding,
                  right: GameConstants.uiPadding,
                  child: IconButton(
                    icon: Icon(Icons.close, color: AppConstants.textColor),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ),
              ],
            ),
          ),

          // Controls
          Positioned(
            left: GameConstants.uiPadding / 2,
            bottom: GameConstants.uiPadding,
            child: JoystickController(
              onMove: _handleJoystickMove,
            ),
          ),

          // Action buttons
          Positioned(
            right: GameConstants.uiPadding / 2,
            bottom: GameConstants.uiPadding,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ActionButton(
                  onPressed: _shoot,
                  label: AppConstants.fireText,
                  color: AppConstants.enemyColor,
                ),
                SizedBox(height: AppConstants.actionButtonSpacing),
                ActionButton(
                  onPressed: _fireNova,
                  label: AppConstants.novaText,
                  color: AppConstants.projectileColor,
                  counterWidget: CustomPaint(
                    painter: NovaCounterPainter(
                      color: AppConstants.projectileColor,
                      count: '$_novaBlastsRemaining',
                    ),
                    size: const Size(30, 30),
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
                    ElevatedButton(
                      onPressed: () => Navigator.of(context).pop(),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppConstants.primaryColor,
                        padding: EdgeInsets.symmetric(
                          horizontal: GameConstants.gameOverButtonPaddingH,
                          vertical: GameConstants.gameOverButtonPaddingV,
                        ),
                      ),
                      child: Text(
                        AppConstants.mainMenuText,
                        style: TextStyle(fontSize: GameConstants.scoreTextSize),
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
