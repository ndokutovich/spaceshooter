import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:math' as math;
import 'dart:async';
import 'dart:io' show Platform;
import 'package:window_size/window_size.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  if (Platform.isMacOS || Platform.isWindows || Platform.isLinux) {
    setWindowTitle('Space Shooter');
    setWindowMinSize(const Size(800, 600));
    setWindowMaxSize(Size.infinite);
    getCurrentScreen().then((screen) {
      if (screen != null) {
        setWindowFrame(
            Rect.fromLTWH(0, 0, screen.frame.width, screen.frame.height));
      }
    });
  }

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Space Shooter',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  bool _showingPlatform = true;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);
    _startSplashSequence();
  }

  void _startSplashSequence() async {
    await Future.delayed(const Duration(seconds: 1));
    if (!mounted) return;

    await _controller.forward();
    await Future.delayed(const Duration(seconds: 2));
    if (!mounted) return;

    setState(() => _showingPlatform = false);
    _controller.reset();
    await _controller.forward();
    await Future.delayed(const Duration(seconds: 2));
    if (!mounted) return;

    _navigateToMainMenu();
  }

  void _skipAnimation() {
    _controller.stop();
    _navigateToMainMenu();
  }

  void _navigateToMainMenu() {
    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            const MainMenu(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(opacity: animation, child: child);
        },
        transitionDuration: const Duration(milliseconds: 500),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: GestureDetector(
        onTapDown: (_) => _skipAnimation(),
        child: Center(
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: Text(
              _showingPlatform ? 'Flutter Platform' : 'Developer Studio',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 48,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class MainMenu extends StatelessWidget {
  const MainMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Space Shooter',
              style: TextStyle(
                color: Colors.white,
                fontSize: 48,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 50),
            MenuButton(
              text: 'Play',
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const GameScreen()),
                );
              },
            ),
            const SizedBox(height: 20),
            MenuButton(
              text: 'Options',
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (context) => const OptionsScreen()),
                );
              },
            ),
            const SizedBox(height: 20),
            MenuButton(
              text: 'Exit',
              onPressed: () => SystemNavigator.pop(),
            ),
          ],
        ),
      ),
    );
  }
}

class MenuButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const MenuButton({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        minimumSize: const Size(200, 50),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
        ),
      ),
      child: Text(
        text,
        style: const TextStyle(fontSize: 20),
      ),
    );
  }
}

class OptionsScreen extends StatefulWidget {
  const OptionsScreen({super.key});

  @override
  State<OptionsScreen> createState() => _OptionsScreenState();
}

class _OptionsScreenState extends State<OptionsScreen> {
  double _volume = 0.5;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Options'),
        backgroundColor: Colors.deepPurple,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Game Volume',
              style: TextStyle(color: Colors.white, fontSize: 24),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: 300,
              child: Slider(
                value: _volume,
                onChanged: (value) {
                  setState(() => _volume = value);
                },
                activeColor: Colors.deepPurple,
                inactiveColor: Colors.deepPurple.withOpacity(0.3),
              ),
            ),
            const SizedBox(height: 40),
            MenuButton(
              text: 'Back',
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        ),
      ),
    );
  }
}

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
  int _score = 0;
  int _level = 1;
  bool _isGameOver = false;
  late Size _screenSize;
  int _novaBlastsRemaining = 2;
  int _lives = 3;
  bool _isInvulnerable = false;
  Timer? _moveTimer;
  final double _playAreaPadding = 60.0;

  @override
  void initState() {
    super.initState();
    RawKeyboard.instance.addListener(_handleKeyPress);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _screenSize = MediaQuery.of(context).size;
      _player.position = Offset(
        _screenSize.width / 2,
        _screenSize.height * 0.8,
      );
      _startGame();
    });
  }

  void _handleKeyPress(RawKeyEvent event) {
    if (event is RawKeyDownEvent) {
      if (event.logicalKey == LogicalKeyboardKey.space) {
        _fireNova();
      }
    }
  }

  void _fireNova() {
    if (_novaBlastsRemaining > 0) {
      HapticFeedback.heavyImpact();
      setState(() {
        for (int angle = 0; angle < 360; angle += 45) {
          final radians = angle * math.pi / 180;
          _projectiles.add(
            Projectile(
              position: _player.position,
              velocity: Offset(
                math.cos(radians) * 10,
                math.sin(radians) * 10,
              ),
            ),
          );
        }
        _novaBlastsRemaining--;
      });
    }
  }

  void _startGame() {
    _spawnEnemies();
    _spawnAsteroids();
    const fps = 60;
    _gameLoop = Timer.periodic(
      const Duration(milliseconds: 1000 ~/ fps),
      _update,
    );
  }

  void _spawnEnemies() {
    _enemies.clear();
    final random = math.Random();
    for (int i = 0; i < 10; i++) {
      _enemies.add(
        Enemy(
          position: Offset(
            _playAreaPadding +
                random.nextDouble() *
                    (_screenSize.width - 2 * _playAreaPadding),
            random.nextDouble() * _screenSize.height * 0.3,
          ),
          speed: 2.0 + _level * 0.5,
          health: 1 + (_level ~/ 2),
        ),
      );
    }
  }

  void _spawnAsteroids() {
    _asteroids.clear();
    final random = math.Random();
    for (int i = 0; i < 5; i++) {
      _asteroids.add(
        Asteroid(
          position: Offset(
            _playAreaPadding +
                random.nextDouble() *
                    (_screenSize.width - 2 * _playAreaPadding),
            random.nextDouble() * _screenSize.height * 0.3,
          ),
          speed: 1.0 + random.nextDouble() * 2.0,
        ),
      );
    }
  }

  void _update(Timer timer) {
    if (_isGameOver) return;

    setState(() {
      // Update projectiles with velocity-based movement
      for (var projectile in _projectiles) {
        projectile.update();
      }
      _projectiles.removeWhere((projectile) =>
          projectile.position.dy < 0 ||
          projectile.position.dy > _screenSize.height ||
          projectile.position.dx < 0 ||
          projectile.position.dx > _screenSize.width);

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

      // Check win condition
      if (_enemies.isEmpty) {
        _level++;
        _spawnEnemies();
        _spawnAsteroids();
      }
    });
  }

  void _handleCollision() {
    if (!_isInvulnerable) {
      setState(() {
        _lives--;
        if (_lives <= 0) {
          _gameOver();
        } else {
          // Add brief invulnerability
          _isInvulnerable = true;
          Future.delayed(const Duration(seconds: 2), () {
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
    // Create lists to track objects to be removed
    final projectilesToRemove = <Projectile>{};
    final enemiesToRemove = <Enemy>{};

    // Check projectile hits on enemies
    for (var projectile in _projectiles) {
      for (var enemy in _enemies) {
        if (_checkCollision(projectile.position, enemy.position)) {
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

    // Check player collision with asteroids and enemies
    bool playerHit = false;

    for (var asteroid in _asteroids) {
      if (_checkCollision(_player.position, asteroid.position)) {
        playerHit = true;
        break;
      }
    }

    if (!playerHit) {
      for (var enemy in _enemies) {
        if (_checkCollision(_player.position, enemy.position)) {
          playerHit = true;
          break;
        }
      }
    }

    // Apply removals after iteration is complete
    _projectiles.removeWhere((p) => projectilesToRemove.contains(p));
    _enemies.removeWhere((e) => enemiesToRemove.contains(e));

    if (playerHit) {
      _handleCollision();
    }
  }

  bool _checkCollision(Offset a, Offset b) {
    const hitDistance = 30.0;
    return (a - b).distance < hitDistance;
  }

  void _gameOver() {
    setState(() {
      _isGameOver = true;
    });
    _gameLoop?.cancel();
  }

  void _shoot() {
    HapticFeedback.mediumImpact();
    setState(() {
      _projectiles.add(
        Projectile(position: _player.position.translate(0, -20)),
      );
    });
  }

  void _handleJoystickMove(Offset delta) {
    _moveTimer?.cancel();
    if (delta != Offset.zero) {
      _moveTimer = Timer.periodic(const Duration(milliseconds: 16), (timer) {
        setState(() {
          final newPosition = _player.position + delta;
          // Constrain to play area
          _player.position = Offset(
            newPosition.dx
                .clamp(_playAreaPadding, _screenSize.width - _playAreaPadding),
            newPosition.dy.clamp(0, _screenSize.height),
          );
        });
      });
    } else {
      _moveTimer = null;
    }
  }

  @override
  void dispose() {
    RawKeyboard.instance.removeListener(_handleKeyPress);
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
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onPanUpdate: (details) {
              setState(() {
                _player.move(details.delta, _screenSize);
              });
            },
            onTapDown: (_) => _shoot(),
            child: Container(
              width: _screenSize.width,
              height: _screenSize.height,
            ),
          ),
          // Player with opacity for invulnerability effect
          Positioned(
            left: _player.position.dx - 25,
            top: _player.position.dy - 25,
            child: Opacity(
              opacity: _isInvulnerable ? 0.5 : 1.0,
              child: const PlayerWidget(),
            ),
          ),
          // Projectiles
          ..._projectiles.map((projectile) => Positioned(
                left: projectile.position.dx - 2,
                top: projectile.position.dy - 10,
                child: const ProjectileWidget(),
              )),
          // Enemies
          ..._enemies.map((enemy) => Positioned(
                left: enemy.position.dx - 20,
                top: enemy.position.dy - 20,
                child: const EnemyWidget(),
              )),
          // Asteroids
          ..._asteroids.map((asteroid) => Positioned(
                left: asteroid.position.dx - 25,
                top: asteroid.position.dy - 25,
                child: const AsteroidWidget(),
              )),
          // UI Elements in SafeArea
          SafeArea(
            child: Stack(
              children: [
                // Score and Level
                Positioned(
                  top: 20,
                  left: 20,
                  child: Text(
                    'Score: $_score\nLevel: $_level',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                ),
                // Lives Counter
                Positioned(
                  top: 20,
                  right: 100,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.favorite,
                        color: Colors.red,
                        size: 24,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'x $_lives',
                        style: const TextStyle(
                          color: Colors.red,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                // Close button
                Positioned(
                  top: 20,
                  right: 20,
                  child: IconButton(
                    icon: const Icon(Icons.close, color: Colors.white),
                    onPressed: () => Navigator.of(context).pop(),
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
                    const Text(
                      'Game Over',
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 48,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Score: $_score',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                      ),
                    ),
                    const SizedBox(height: 20),
                    MenuButton(
                      text: 'Main Menu',
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ],
                ),
              ),
            ),
          // Play area borders
          Positioned(
            left: _playAreaPadding,
            top: 0,
            bottom: 0,
            child: Container(
              width: 2,
              color: Colors.white.withOpacity(0.3),
            ),
          ),
          Positioned(
            right: _playAreaPadding,
            top: 0,
            bottom: 0,
            child: Container(
              width: 2,
              color: Colors.white.withOpacity(0.3),
            ),
          ),
          // Controls
          Positioned(
            left: 10,
            bottom: 20,
            child: JoystickController(
              onMove: _handleJoystickMove,
            ),
          ),
          // Action buttons
          Positioned(
            right: 10,
            bottom: 20,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ActionButton(
                  onPressed: _shoot,
                  label: 'Fire',
                  color: Colors.red,
                ),
                const SizedBox(height: 15),
                ActionButton(
                  onPressed: _fireNova,
                  label: 'Nova',
                  color: Colors.yellow,
                  counter: '$_novaBlastsRemaining',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class Player {
  Offset position = const Offset(0, 0);

  void move(Offset delta, Size screenSize) {
    position += delta;
    position = Offset(
      position.dx.clamp(25, screenSize.width - 25),
      position.dy.clamp(25, screenSize.height - 25),
    );
  }
}

class Enemy {
  Offset position;
  double speed;
  int health;

  Enemy({
    required this.position,
    required this.speed,
    required this.health,
  });

  void update(Size screenSize) {
    position = Offset(position.dx, position.dy + speed);
    if (position.dy > screenSize.height) {
      position = Offset(position.dx, -50);
    }
  }
}

class Projectile {
  Offset position;
  Offset velocity;
  static const double speed = 10.0;

  Projectile({
    required this.position,
    Offset? velocity,
  }) : velocity = velocity ?? const Offset(0, -speed);

  void update() {
    position += velocity;
  }
}

class Asteroid {
  Offset position;
  double speed;

  Asteroid({required this.position, required this.speed});

  void update(Size screenSize) {
    position = Offset(position.dx, position.dy + speed);
    if (position.dy > screenSize.height) {
      position = Offset(position.dx, -50);
    }
  }
}

class PlayerWidget extends StatelessWidget {
  const PlayerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.circular(25),
      ),
      child: const Icon(Icons.rocket, color: Colors.white),
    );
  }
}

class EnemyWidget extends StatelessWidget {
  const EnemyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: Colors.red,
        borderRadius: BorderRadius.circular(20),
      ),
      child: const Icon(Icons.android, color: Colors.white),
    );
  }
}

class ProjectileWidget extends StatelessWidget {
  const ProjectileWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 4,
      height: 20,
      color: Colors.yellow,
    );
  }
}

class AsteroidWidget extends StatelessWidget {
  const AsteroidWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 50,
      decoration: const BoxDecoration(
        color: Colors.grey,
        shape: BoxShape.circle,
      ),
    );
  }
}

class Star {
  Offset position;
  double size;
  double opacity;
  double twinkleSpeed;
  double maxBrightness;

  Star({
    required this.position,
    required this.size,
    this.opacity = 1.0,
    required this.twinkleSpeed,
    required this.maxBrightness,
  });
}

class StarBackground extends StatefulWidget {
  final Size screenSize;

  const StarBackground({
    super.key,
    required this.screenSize,
  });

  @override
  State<StarBackground> createState() => _StarBackgroundState();
}

class _StarBackgroundState extends State<StarBackground>
    with SingleTickerProviderStateMixin {
  late List<Star> stars;
  late AnimationController _controller;
  final random = math.Random();

  @override
  void initState() {
    super.initState();
    _initializeStars();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    )..repeat();
    _controller.addListener(_updateStars);
  }

  void _initializeStars() {
    // Create three layers of stars with different properties
    stars = [
      ...List.generate(50, (index) => _createStar(0.3)), // Distant stars
      ...List.generate(30, (index) => _createStar(0.6)), // Mid-range stars
      ...List.generate(20, (index) => _createStar(1.0)), // Close stars
    ];
  }

  Star _createStar(double brightnessMultiplier) {
    return Star(
      position: Offset(
        random.nextDouble() * widget.screenSize.width,
        random.nextDouble() * widget.screenSize.height,
      ),
      size: (0.5 + random.nextDouble() * 2) * brightnessMultiplier,
      twinkleSpeed: 0.3 + random.nextDouble() * 2,
      maxBrightness: 0.3 + (0.7 * brightnessMultiplier),
    );
  }

  void _updateStars() {
    setState(() {
      for (var star in stars) {
        // Create a smooth twinkling effect using sine waves
        star.opacity =
            (math.sin(_controller.value * math.pi * 2 * star.twinkleSpeed) +
                    1) /
                2 *
                star.maxBrightness;
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: widget.screenSize,
      painter: StarPainter(stars),
    );
  }
}

class StarPainter extends CustomPainter {
  final List<Star> stars;

  StarPainter(this.stars);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.white;

    for (var star in stars) {
      paint.color = Colors.white.withOpacity(star.opacity);
      canvas.drawCircle(star.position, star.size, paint);
    }
  }

  @override
  bool shouldRepaint(StarPainter oldDelegate) => true;
}

class JoystickController extends StatefulWidget {
  final Function(Offset) onMove;

  const JoystickController({
    super.key,
    required this.onMove,
  });

  @override
  State<JoystickController> createState() => _JoystickControllerState();
}

class _JoystickControllerState extends State<JoystickController> {
  Offset _stickPosition = Offset.zero;
  bool _isDragging = false;
  static const _stickRadius = 20.0;
  static const _baseRadius = 40.0;

  void _updateStick(Offset position) {
    final delta = position - Offset(_baseRadius, _baseRadius);
    if (delta.distance > _baseRadius) {
      _stickPosition = delta * (_baseRadius / delta.distance);
    } else {
      _stickPosition = delta;
    }
    HapticFeedback.lightImpact();
    widget.onMove(_stickPosition / _baseRadius * 5);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: _baseRadius * 2,
      height: _baseRadius * 2,
      child: GestureDetector(
        onPanStart: (details) {
          _isDragging = true;
          HapticFeedback.mediumImpact();
          final box = context.findRenderObject() as RenderBox;
          final localPosition = box.globalToLocal(details.globalPosition);
          _updateStick(localPosition);
        },
        onPanUpdate: (details) {
          if (_isDragging) {
            final box = context.findRenderObject() as RenderBox;
            final localPosition = box.globalToLocal(details.globalPosition);
            _updateStick(localPosition);
          }
        },
        onPanEnd: (_) {
          _isDragging = false;
          _stickPosition = Offset.zero;
          widget.onMove(Offset.zero);
          setState(() {});
        },
        child: CustomPaint(
          painter: JoystickPainter(
            stickPosition: _stickPosition,
            stickRadius: _stickRadius,
            baseRadius: _baseRadius,
          ),
        ),
      ),
    );
  }
}

class JoystickPainter extends CustomPainter {
  final Offset stickPosition;
  final double stickRadius;
  final double baseRadius;

  JoystickPainter({
    required this.stickPosition,
    required this.stickRadius,
    required this.baseRadius,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(baseRadius, baseRadius);

    // Draw base
    final basePaint = Paint()
      ..color = Colors.white.withOpacity(0.3)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    canvas.drawCircle(center, baseRadius, basePaint);

    // Draw stick
    final stickPaint = Paint()
      ..color = Colors.white.withOpacity(0.5)
      ..style = PaintingStyle.fill;
    canvas.drawCircle(center + stickPosition, stickRadius, stickPaint);
  }

  @override
  bool shouldRepaint(JoystickPainter oldDelegate) =>
      stickPosition != oldDelegate.stickPosition;
}

class ActionButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String label;
  final Color color;
  final String? counter;

  const ActionButton({
    super.key,
    required this.onPressed,
    required this.label,
    required this.color,
    this.counter,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) {
        HapticFeedback.heavyImpact();
        onPressed();
      },
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: color.withOpacity(0.5),
          shape: BoxShape.circle,
          border: Border.all(
            color: color,
            width: 2,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                label,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
              if (counter != null) ...[
                const SizedBox(height: 2),
                Text(
                  counter!,
                  style: TextStyle(
                    color: color,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
