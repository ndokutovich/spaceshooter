import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../widgets/menu_button.dart';
import '../widgets/background.dart';
import '../widgets/game_logo.dart';
import '../utils/constants/ui_constants.dart';
import '../utils/constants/style_constants.dart';
import '../utils/transitions.dart';
import 'options_screen.dart';
import 'high_scores_screen.dart';
import '../game/screens/game_screen.dart';

class MainMenu extends StatelessWidget {
  const MainMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final logoSize = screenSize.width * 0.35; // 35% of screen width
    final buttonWidth = screenSize.width * 0.35; // 35% of screen width
    final buttonHeight = screenSize.height * 0.08; // 8% of screen height
    final buttonSpacing = screenSize.height * 0.02; // 2% of screen height

    return Scaffold(
      backgroundColor: StyleConstants.backgroundColor,
      body: Stack(
        children: [
          StarBackground(screenSize: screenSize),
          SafeArea(
            child: Center(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(
                  vertical: screenSize.height * 0.03, // 3% vertical padding
                  horizontal: screenSize.width * 0.02, // 2% horizontal padding
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GameLogo(size: logoSize),
                    SizedBox(height: buttonSpacing * 2),
                    MenuButton(
                      text: UIConstants.menuPlayText,
                      onPressed: () {
                        Navigator.of(context).push(
                          FadeSlideTransition(page: const GameScreen()),
                        );
                      },
                      width: buttonWidth,
                      height: buttonHeight,
                    ),
                    SizedBox(height: buttonSpacing),
                    MenuButton(
                      text: UIConstants.menuOptionsText,
                      onPressed: () {
                        Navigator.of(context).push(
                          FadeSlideTransition(page: const OptionsScreen()),
                        );
                      },
                      width: buttonWidth,
                      height: buttonHeight,
                    ),
                    SizedBox(height: buttonSpacing),
                    MenuButton(
                      text: UIConstants.menuHighScoresText,
                      onPressed: () {
                        Navigator.of(context).push(
                          FadeSlideTransition(page: const HighScoresScreen()),
                        );
                      },
                      width: buttonWidth,
                      height: buttonHeight,
                    ),
                    SizedBox(height: buttonSpacing),
                    MenuButton(
                      text: UIConstants.menuExitText,
                      onPressed: () => SystemNavigator.pop(),
                      width: buttonWidth,
                      height: buttonHeight,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
