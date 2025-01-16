import 'package:flutter/material.dart';
import '../widgets/menu_button.dart';
import '../utils/app_constants.dart';

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
        backgroundColor: AppConstants.primaryColor,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              AppConstants.volumeText,
              style: TextStyle(
                color: AppConstants.textColor,
                fontSize: 24,
              ),
            ),
            const SizedBox(height: AppConstants.menuButtonSpacing),
            SizedBox(
              width: AppConstants.volumeSliderWidth,
              child: Slider(
                value: _volume,
                onChanged: (value) {
                  setState(() => _volume = value);
                },
                activeColor: AppConstants.primaryColor,
                inactiveColor: AppConstants.primaryColor.withOpacity(0.3),
              ),
            ),
            const SizedBox(height: AppConstants.menuButtonSpacing * 2),
            MenuButton(
              text: AppConstants.backText,
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        ),
      ),
    );
  }
}
