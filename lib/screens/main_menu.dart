import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../widgets/menu_button.dart';
import '../widgets/background.dart';
import '../widgets/game_logo.dart';
import '../utils/app_constants.dart';
import '../utils/transitions.dart';
import 'options_screen.dart';
import 'high_scores_screen.dart';
import '../game/screens/game_screen.dart';

class MainMenu extends StatelessWidget {
  const MainMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          StarBackground(screenSize: screenSize),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const GameLogo(size: 400),
                SizedBox(height: AppConstants.menuButtonSpacing * 2),
                MenuButton(
                  text: AppConstants.menuPlayText,
                  onPressed: () {
                    Navigator.of(context).push(
                      FadeSlideTransition(page: const GameScreen()),
                    );
                  },
                ),
                SizedBox(height: AppConstants.menuButtonSpacing),
                MenuButton(
                  text: AppConstants.menuOptionsText,
                  onPressed: () {
                    Navigator.of(context).push(
                      FadeSlideTransition(page: const OptionsScreen()),
                    );
                  },
                ),
                SizedBox(height: AppConstants.menuButtonSpacing),
                MenuButton(
                  text: AppConstants.menuHighScoresText,
                  onPressed: () {
                    Navigator.of(context).push(
                      FadeSlideTransition(page: const HighScoresScreen()),
                    );
                  },
                ),
                SizedBox(height: AppConstants.menuButtonSpacing),
                MenuButton(
                  text: AppConstants.menuExitText,
                  onPressed: () => SystemNavigator.pop(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
