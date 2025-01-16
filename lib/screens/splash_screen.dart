import 'package:flutter/material.dart';
import '../game/screens/game_screen.dart';
import 'main_menu.dart';

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
