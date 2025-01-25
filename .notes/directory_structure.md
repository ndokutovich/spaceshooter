# Flutter Game Project Structure

```
lib/
├── game/
│   ├── entities/
│   │   ├── asteroid.dart
│   │   ├── bonus_item.dart
│   │   ├── boss.dart
│   │   ├── enemy.dart
│   │   ├── player.dart
│   │   └── projectile.dart
│   ├── managers/
│   │   ├── bonus_manager.dart
│   │   ├── boss_manager.dart
│   │   ├── collision_manager.dart
│   │   ├── entity_manager.dart
│   │   ├── game_state_manager.dart
│   │   └── input_manager.dart
│   ├── screens/
│   │   └── game_screen.dart
│   ├── utils/
│   │   ├── constants.dart
│   │   └── painters.dart
│   └── widgets/
│       └── controls.dart
├── models/
├── screens/
│   └── main_menu.dart
├── utils/
│   ├── app_constants.dart
│   ├── collision_utils.dart
│   ├── high_scores.dart
│   └── transitions.dart
├── widgets/
│   ├── background.dart
│   ├── controls.dart
│   ├── game_logo.dart
│   ├── game_objects.dart
│   ├── game_objects/
│   │   ├── asteroid_painter.dart
│   │   ├── bonus_painter.dart
│   │   ├── boss_widget.dart
│   │   ├── game_object_widget.dart
│   │   ├── heart_painter.dart
│   │   ├── nova_counter_painter.dart
│   │   └── projectile_painter.dart
│   ├── menu_button.dart
│   ├── performance_overlay.dart
│   ├── round_space_button.dart
│   └── ship_skins.dart
├── main.dart
└── prompts.txt
```

## Analysis Plan for Similar Named Files

### Controls
1. `lib/widgets/controls.dart`
2. `lib/game/widgets/controls.dart`
- Need to check if these serve different purposes or can be merged

### Entity-Related Files
1. Entity & Painter Pairs:
   - `game/entities/asteroid.dart` & `widgets/game_objects/asteroid_painter.dart`
   - `game/entities/bonus_item.dart` & `widgets/game_objects/bonus_painter.dart`
   - `game/entities/projectile.dart` & `widgets/game_objects/projectile_painter.dart`
   - Need to verify separation of concerns is maintained

### Utils
1. Constants:
   - `game/utils/constants.dart`
   - `utils/app_constants.dart`
   - Need to check for overlapping constants and potential consolidation

### Widgets
1. Similar Widget Groups:
   - `widgets/game_objects/*`
   - `game/widgets/*`
   - Need to evaluate if this split makes sense

## Next Steps for Analysis

1. **Entity Files**
   - [x] Verify all entities are properly moved to game/entities
   - [x] Check for any remaining duplicate entity definitions
   - [ ] Review entity-painter relationships

2. **Widget Files**
   - [ ] Compare controls implementations
   - [ ] Review widget organization
   - [ ] Check for duplicate widget functionality

3. **Utils Files**
   - [ ] Compare constants files
   - [ ] Look for duplicate utility functions
   - [ ] Evaluate collision utils placement

4. **Manager Files**
   - [ ] Review manager responsibilities
   - [ ] Check for overlapping functionality
   - [ ] Verify proper separation of concerns

5. **Screen Files**
   - [ ] Check screen widget organization
   - [ ] Review navigation patterns
   - [ ] Look for shared screen components
