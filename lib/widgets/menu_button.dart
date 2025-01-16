import 'package:flutter/material.dart';
import '../utils/app_constants.dart';

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
        backgroundColor: AppConstants.primaryColor,
        foregroundColor: AppConstants.textColor,
        minimumSize:
            const Size(AppConstants.menuButtonWidth, AppConstants.menuButtonHeight),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppConstants.menuButtonRadius),
        ),
      ),
      child: Text(
        text,
        style: const TextStyle(fontSize: 20),
      ),
    );
  }
}
