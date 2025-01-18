import 'package:flutter/services.dart';

class KeyBinding {
  final String action;
  final List<LogicalKeyboardKey> keys;
  final bool isEnabled;

  KeyBinding({
    required this.action,
    required this.keys,
    this.isEnabled = true,
  });

  KeyBinding copyWith({
    String? action,
    List<LogicalKeyboardKey>? keys,
    bool? isEnabled,
  }) {
    return KeyBinding(
      action: action ?? this.action,
      keys: keys ?? this.keys,
      isEnabled: isEnabled ?? this.isEnabled,
    );
  }

  String get keyText {
    return keys.map((key) => getKeyDisplayName(key)).join(' / ');
  }

  static String getKeyDisplayName(LogicalKeyboardKey key) {
    final keyLabel = key.keyLabel;
    if (keyLabel.isEmpty) {
      // Handle special keys
      switch (key.keyId) {
        case 0x00100000020: // Space
          return 'Space';
        case 0x00100000028: // Enter
          return 'Enter';
        case 0x00100000029: // Escape
          return 'Esc';
        case 0x0010000002C: // Arrow Right
          return '→';
        case 0x0010000002D: // Arrow Left
          return '←';
        case 0x0010000002E: // Arrow Down
          return '↓';
        case 0x0010000002F: // Arrow Up
          return '↑';
        default:
          return key.debugName ?? 'Unknown';
      }
    }
    return keyLabel.toUpperCase();
  }
}
