# Code Duplication Analysis and Resolution Plan

## 1. Constants Duplication (SSHOTER-073.1)

### Current Issues
- Multiple constant files with overlapping definitions:
  - `lib/utils/constants/player_constants.dart`
  - `lib/utils/constants/gameplay_constants.dart`
  - `lib/game/utils/constants.dart`

### Resolution Plan
1. **Analysis Phase**
   - Map all constants and their usage
   - Identify overlapping definitions
   - Categorize constants by domain (player, gameplay, UI, etc.)

2. **New Structure**
   ```
   lib/utils/constants/
   ├── game/
   │   ├── player_config.dart     # Player-specific configurations
   │   ├── gameplay_config.dart   # Core gameplay settings
   │   └── difficulty_config.dart # Difficulty-related settings
   ├── ui/
   │   ├── style_config.dart      # UI styling constants
   │   └── animation_config.dart  # Animation-related constants
   └── config.dart               # Exports all configurations
   ```

3. **Migration Strategy**
   - Create new configuration classes with proper documentation
   - Implement gradual migration to avoid breaking changes
   - Use deprecation warnings for old constants
   - Remove old constant files after full migration

## 2. Player Implementation Duplication (SSHOTER-073.2)

### Current Issues
- Split implementation across:
  - `lib/game/ships/player_ship.dart`
  - `lib/game/entities/player.dart`
  - `lib/widgets/ships/player_ship_widget.dart`

### Resolution Plan
1. **New Architecture**
   ```
   lib/game/player/
   ├── models/
   │   └── player_state.dart      # Player state data
   ├── controllers/
   │   ├── player_controller.dart # Core player logic
   │   └── movement_controller.dart# Movement handling
   ├── views/
   │   └── player_view.dart       # Visual representation
   └── player.dart               # Public API
   ```

2. **Implementation Strategy**
   - Implement PlayerController with single responsibility
   - Move visual logic to PlayerView
   - Use PlayerState for data management
   - Create clear interfaces between components

## 3. Movement Logic Duplication (SSHOTER-073.3)

### Current Issues
- Duplicated movement handling in:
  - GameScreen._handlePlayerMovement
  - InputManager.handleKeyboardMovement
  - Player.move
  - PlayerShip.move

### Resolution Plan
1. **New Movement System**
   ```
   lib/game/core/movement/
   ├── controllers/
   │   └── movement_controller.dart
   ├── models/
   │   ├── movement_state.dart
   │   └── movement_config.dart
   └── movement_system.dart
   ```

2. **Implementation Strategy**
   - Create unified MovementController
   - Implement movement state management
   - Use composition over inheritance
   - Provide clean API for movement handling

## 4. Game Constants Usage (SSHOTER-073.4)

### Current Issues
- Mixed usage between:
  - old_game_constants.GameConstants
  - GameplayConstants

### Resolution Plan
1. **Standardization Strategy**
   - Audit all constant usages
   - Create mapping between old and new constants
   - Implement new constants system
   - Use static analysis to ensure consistency

## Implementation Order

1. Start with Constants Consolidation (073.1)
   - This affects all other components
   - Provides foundation for other changes

2. Movement System Consolidation (073.3)
   - Required for player implementation
   - More isolated, easier to implement

3. Player Implementation Unification (073.2)
   - Depends on constants and movement
   - Core gameplay component

4. Game Constants Standardization (073.4)
   - Final cleanup phase
   - Ensures consistency across codebase

## Success Criteria

- No duplicate constant definitions
- Single source of truth for player logic
- Unified movement system
- Consistent constant usage throughout the code
- Improved maintainability and readability
- Reduced code complexity
- Better test coverage
- Clear documentation

## Notes

- Each task should be completed with corresponding tests
- Changes should be backward compatible where possible
- Documentation should be updated alongside changes
- Code reviews should focus on preventing new duplications 