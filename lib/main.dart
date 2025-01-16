import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:io' show Platform;
import 'package:window_size/window_size.dart';

import 'screens/splash_screen.dart';
import 'utils/app_constants.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  if (Platform.isMacOS || Platform.isWindows || Platform.isLinux) {
    setWindowTitle(AppConstants.appTitle);
    setWindowMinSize(
        const Size(AppConstants.minWindowWidth, AppConstants.minWindowHeight));
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
      title: AppConstants.appTitle,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: AppConstants.primaryColor),
        useMaterial3: true,
      ),
      home: const SplashScreen(),
    );
  }
}
