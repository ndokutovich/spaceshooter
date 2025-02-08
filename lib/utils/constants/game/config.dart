export 'base_config.dart';
export 'player_config.dart';
export 'gameplay_config.dart';
export 'ui_config.dart';

import 'base_config.dart';
import 'player_config.dart';
import 'gameplay_config.dart';
import 'ui_config.dart';

/// Main game configuration class that combines all settings
class GameConfig extends BaseGameConfig with JsonSerializable, Validatable {
  final PlayerConfig player;
  final GameplayConfig gameplay;
  final UIConfig ui;

  const GameConfig({
    this.player = const PlayerConfig(),
    this.gameplay = const GameplayConfig(),
    this.ui = const UIConfig(),
  });

  @override
  List<String> get validationErrors {
    final errors = <String>[];
    if (!player.validate()) {
      errors.addAll(player.validationErrors.map((e) => 'Player: $e'));
    }
    if (!gameplay.validate()) {
      errors.addAll(gameplay.validationErrors.map((e) => 'Gameplay: $e'));
    }
    if (!ui.validate()) {
      errors.addAll(ui.validationErrors.map((e) => 'UI: $e'));
    }
    return errors;
  }

  @override
  Map<String, dynamic> toJson() => {
        'player': player.toJson(),
        'gameplay': gameplay.toJson(),
        'ui': ui.toJson(),
      };

  factory GameConfig.fromJson(Map<String, dynamic> json) => GameConfig(
        player: PlayerConfig.fromJson(json['player'] as Map<String, dynamic>),
        gameplay:
            GameplayConfig.fromJson(json['gameplay'] as Map<String, dynamic>),
        ui: UIConfig.fromJson(json['ui'] as Map<String, dynamic>),
      );

  @override
  GameConfig copyWith({
    PlayerConfig? player,
    GameplayConfig? gameplay,
    UIConfig? ui,
  }) {
    return GameConfig(
      player: player ?? this.player,
      gameplay: gameplay ?? this.gameplay,
      ui: ui ?? this.ui,
    );
  }

  /// Creates a default configuration for testing
  factory GameConfig.test() => const GameConfig();

  /// Creates a configuration for easy difficulty
  factory GameConfig.easy() => const GameConfig(
        gameplay: GameplayConfig(
          difficulty: DifficultyConfig(
            levelSpeedIncrease: 0.3,
            healthIncreaseLevel: 5,
            bossSpeedMultiplier: 1.2,
            bossHealthMultiplier: 1.5,
            bossScoreMultiplier: 8,
          ),
        ),
      );

  /// Creates a configuration for hard difficulty
  factory GameConfig.hard() => const GameConfig(
        gameplay: GameplayConfig(
          difficulty: DifficultyConfig(
            levelSpeedIncrease: 0.7,
            healthIncreaseLevel: 2,
            bossSpeedMultiplier: 1.8,
            bossHealthMultiplier: 2.5,
            bossScoreMultiplier: 12,
          ),
        ),
      );
}
