# Space Shooter Game

A modern space shooter game built with Flutter, featuring smooth animations, engaging gameplay mechanics, and cross-platform support.

## Features

- 🎮 Intuitive touch and keyboard controls
- 🚀 Multiple enemy types with unique behaviors
- 💥 Dynamic visual effects and animations
- 🎯 Progressive difficulty system
- 🏆 High score tracking
- 🎨 Beautiful, modern UI design
- 💾 Local save system
- 🌟 Special power-ups and bonuses
- 🎵 Sound effects and background music

## Platform Support

| Platform | Status | Minimum Version |
|----------|--------|-----------------|
| Android  | ✅     | Android 5.0 (API 21) |
| iOS      | ✅     | iOS 11.0 |
| Web      | ✅     | Modern browsers |
| Windows  | ✅     | Windows 10 |
| macOS    | ✅     | macOS 10.14 |
| Linux    | ✅     | Ubuntu 18.04 |

## Requirements

- Flutter SDK 3.16.0 or higher
- Dart SDK 3.2.0 or higher
- For desktop development:
  - Windows: Visual Studio 2019 or later with C++ development tools
  - macOS: Xcode 14.0 or later
  - Linux: Clang, CMake, GTK development headers
- For mobile development:
  - Android: Android Studio with Android SDK
  - iOS: Xcode 14.0 or later, CocoaPods

## Getting Started

1. Clone the repository:
   ```bash
   git clone https://github.com/yourusername/space-shooter.git
   cd space-shooter
   ```

2. Install dependencies:
   ```bash
   flutter pub get
   ```

3. Run the app:
   ```bash
   flutter run
   ```

## Build Instructions

### Android
```bash
flutter build apk --release
# or for app bundle
flutter build appbundle --release
```

### iOS
```bash
flutter build ios --release
# Then archive using Xcode
```

### Web
```bash
flutter build web --release
```

### Desktop
```bash
# Windows
flutter build windows --release

# macOS
flutter build macos --release

# Linux
flutter build linux --release
```

## Development Setup

1. Install Flutter by following the [official installation guide](https://flutter.dev/docs/get-started/install)
2. Set up your preferred IDE (VS Code or Android Studio) with Flutter and Dart plugins
3. Configure platform-specific development tools:
   - For Android: Install Android Studio and Android SDK
   - For iOS: Install Xcode and CocoaPods
   - For desktop: Install the required platform-specific dependencies

## Project Structure

```
lib/
├── game/
│   ├── entities/      # Game entity classes
│   ├── managers/      # Game state management
│   ├── utils/         # Utility functions
│   └── widgets/       # Game-specific widgets
├── models/            # Data models
├── screens/           # App screens
├── utils/            # Common utilities
│   └── constants/    # Game constants
├── widgets/          # Reusable widgets
└── main.dart         # App entry point
```

## Controls

### Mobile
- Tap and drag to move the player ship
- Tap buttons for special actions
- Two-finger tap for pause

### Desktop/Web
- Arrow keys or WASD for movement
- Space for primary weapon
- E for special ability
- ESC for pause

## Contributing

We welcome contributions! Please see our [Contributing Guidelines](CONTRIBUTING.md) for details.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Acknowledgments

- Flutter team for the amazing framework
- Our contributors and supporters
- Game asset creators (see [CREDITS.md](CREDITS.md))

## Support

For support, please:
1. Check the [FAQ](docs/FAQ.md)
2. Search existing [Issues](https://github.com/yourusername/space-shooter/issues)
3. Create a new issue if needed

## Stay Connected

- Follow us on Twitter [@SpaceShooterGame](https://twitter.com/SpaceShooterGame)
- Join our [Discord community](https://discord.gg/spaceshooter)
- Visit our [website](https://spaceshooter.game)
