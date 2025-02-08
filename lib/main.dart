import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'dart:io' show Platform;
import 'package:window_size/window_size.dart';
import 'dart:html' if (dart.library.io) 'dart:io' as device;

import 'screens/splash_screen.dart';
import 'utils/constants/ui_constants.dart';
import 'utils/constants/style_constants.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // Desktop window settings
  if (!kIsWeb && (Platform.isMacOS || Platform.isWindows || Platform.isLinux)) {
    setWindowTitle(UIConstants.appTitle);
    setWindowMinSize(
        const Size(UIConstants.minWindowWidth, UIConstants.minWindowHeight));
    setWindowMaxSize(Size.infinite);
    getCurrentScreen().then((screen) {
      if (screen != null) {
        setWindowFrame(
            Rect.fromLTWH(0, 0, screen.frame.width, screen.frame.height));
      }
    });
  }

  // Force landscape mode
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);

  // Hide system UI overlays
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: UIConstants.appTitle,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme:
            ColorScheme.fromSeed(seedColor: StyleConstants.primaryColor),
        useMaterial3: true,
      ),
      home: const SplashScreen(),
    );
  }
}
