import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../game/screens/game_screen.dart';
import 'options_screen.dart';
import 'high_scores_screen.dart';
import '../widgets/menu_button.dart';
import '../widgets/game_logo.dart';
import '../utils/app_constants.dart';

class MainMenu extends StatelessWidget {
  const MainMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const GameLogo(size: 400),
            const SizedBox(height: AppConstants.menuButtonSpacing * 2.5),
            MenuButton(
              text: AppConstants.menuPlayText,
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const GameScreen()),
                );
              },
            ),
            const SizedBox(height: AppConstants.menuButtonSpacing),
            MenuButton(
              text: AppConstants.menuHighScoresText,
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (context) => const HighScoresScreen()),
                );
              },
            ),
            const SizedBox(height: AppConstants.menuButtonSpacing),
            MenuButton(
              text: AppConstants.menuOptionsText,
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (context) => const OptionsScreen()),
                );
              },
            ),
            const SizedBox(height: AppConstants.menuButtonSpacing),
            MenuButton(
              text: AppConstants.menuExitText,
              onPressed: () => SystemNavigator.pop(),
            ),
          ],
        ),
      ),
    );
  }
}
