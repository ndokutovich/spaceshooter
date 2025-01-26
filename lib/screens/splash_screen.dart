import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'main_menu.dart';
import '../utils/constants/ui_constants.dart';
import '../utils/constants/style_constants.dart';
import '../utils/constants/animation_constants.dart';

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
      duration: AnimationConstants.splashAnimationDuration,
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);
    _startSplashSequence();
  }

  void _startSplashSequence() async {
    await Future.delayed(AnimationConstants.splashDelayDuration);
    if (!mounted) return;

    await _controller.forward();
    await Future.delayed(AnimationConstants.splashAnimationDuration);
    if (!mounted) return;

    setState(() => _showingPlatform = false);
    _controller.reset();
    await _controller.forward();
    await Future.delayed(AnimationConstants.splashAnimationDuration);
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
        transitionDuration: AnimationConstants.menuTransitionDuration,
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
      backgroundColor: StyleConstants.backgroundColor,
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTapDown: (details) {
          if (details.kind == PointerDeviceKind.mouse ||
              details.kind == PointerDeviceKind.touch) {
            _skipAnimation();
          }
        },
        child: Center(
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: Text(
              _showingPlatform
                  ? UIConstants.splashTextPlatform
                  : UIConstants.splashTextStudio,
              style: TextStyle(
                color: StyleConstants.textColor,
                fontSize: StyleConstants.titleFontSize,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
