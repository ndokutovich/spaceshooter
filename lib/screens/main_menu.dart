import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../game/screens/game_screen.dart';
import 'options_screen.dart';
import '../widgets/menu_button.dart';
import '../utils/app_constants.dart';

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
              AppConstants.appTitle,
              style: TextStyle(
                color: AppConstants.textColor,
                fontSize: AppConstants.titleFontSize,
                fontWeight: FontWeight.bold,
              ),
            ),
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
