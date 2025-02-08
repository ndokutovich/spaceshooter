# Task List

## Completed Tasks
- [x] SSHOTER-001: Compare and analyze controls.dart files in widgets and game/widgets for potential merge
  - Analysis Notes:
    1. Both files contain JoystickController and ActionButton
    2. Game version has more optimized movement calculations
    3. Game version uses CustomPaint for joystick rendering
    4. Widget version uses Container-based rendering
    5. Different approaches to haptic feedback
    6. Different size constants and styling
    7. Recommendation: Merge into game version with configurable options
  - Subtasks:
    - [x] SSHOTER-001.1: Create configurable version of game controls in lib/widgets/controls.dart
    - [x] SSHOTER-001.2: Update all references to use new controls
    - [x] SSHOTER-001.3: Remove duplicate controls file

## In Progress Tasks
- [~] SSHOTER-020: Analyze and consolidate app_constants.dart and game/utils/constants.dart
  - Analysis Notes:
    1. Current Structure:
       - app_constants.dart: General app-wide constants
       - game/utils/constants.dart: Game-specific constants
       - utils/constants/: Specialized constant files
    2. Issues Found:
       - Duplicate constants between files (e.g., playerSize, actionButtonSize)
       - Mixed concerns in app_constants.dart (UI, game, animations)
       - Inconsistent organization (some in specialized files, some mixed)
    3. Recommendations:
       - Move all constants to utils/constants/
       - Create clear separation of concerns
       - Eliminate duplicates
       - Use consistent naming and organization
  - Subtasks:
    - [x] SSHOTER-020.1: Create new constant file structure
      - [x] Create game_constants.dart for game mechanics
      - [x] Create player_constants.dart for player settings
      - [x] Create enemy_constants.dart for enemy/boss settings
      - [x] Move UI constants to ui_constants.dart
    - [x] SSHOTER-020.2: Migrate constants to new files
      - [x] Move remaining constants from app_constants.dart
      - [x] Move remaining constants from game/utils/constants.dart
      - [x] Resolve duplicate constants
      - [x] Update values to match latest requirements
    - [~] SSHOTER-020.3: Update imports in all files
      - [x] Remove duplicate constants between files
      - [x] Search for constant usages
      - [x] Update import statements
        - [x] main_menu.dart
        - [x] options_screen.dart
        - [x] high_scores_screen.dart
        - [x] splash_screen.dart
        - [x] menu_button.dart
        - [x] performance_overlay.dart
        - [x] game_logo.dart
        - [x] controls_tab.dart
        - [x] misc_tab.dart
        - [x] game_screen.dart
      - [x] Test all changes
    - [x] SSHOTER-020.4: Remove old constant files

## Pending Tasks
- [~] SSHOTER-002: Analyze game_objects folder structure and organization
  - Subtasks:
    - [x] SSHOTER-002.1: Create base painter class for game objects
    - [x] SSHOTER-002.2: Update barrel file exports
    - [x] SSHOTER-002.3: Refactor boss_widget.dart (postponed)
      - [x] SSHOTER-002.3.1: Extract common painting utilities to BaseGamePainter
      - [x] SSHOTER-002.3.2: Split BossPainter into component painters
        - [x] Create BossShieldPainter
        - [x] Create BossBodyPainter
        - [x] Create BossLaunchPadPainter
        - [x] Create BossEnergyCircuitPainter
        - [x] Create BossCorePainter
        - [x] Create BossHealthBarPainter
        - [x] Create barrel file for component exports
      - [x] SSHOTER-002.3.3: Create configuration objects for visual properties
        - [x] Create base configuration class
        - [x] Create shield configuration
        - [x] Create body configuration
        - [x] Create launch pad configuration
        - [x] Create energy circuit configuration
        - [x] Create core configuration
        - [x] Create health bar configuration
      - [x] SSHOTER-002.3.4: Implement caching for complex paths and gradients
        - [x] Create PainterCacheMixin
        - [x] Create CachedGamePainter base class
      - [x] SSHOTER-002.3.5: Extract magic numbers to constants
        - [x] Create BossPainterConstants class
        - [x] Extract shield constants
        - [x] Extract body constants
        - [x] Extract launch pad constants
        - [x] Extract energy circuit constants
        - [x] Extract core constants
        - [x] Extract health bar constants
        - [x] Extract shared constants (gradients, opacity, glow, animation)

- [x] SSHOTER-003: Review and optimize widget exports in game_objects.dart barrel file
  - [x] Create game_objects.dart barrel file
  - [x] Organize exports by category
    - [x] Base classes and utilities
    - [x] Boss-related exports
    - [x] Game object painters
  - [x] Add documentation comments

- [x] SSHOTER-010: Analyze and optimize asteroid entity-painter relationship
  - [x] SSHOTER-010.1: Create asteroid visual configuration
    - [x] Create AsteroidVisualConfig class
    - [x] Extract color constants
    - [x] Extract size and shape constants
    - [x] Extract damage effect constants
  - [x] SSHOTER-010.2: Update AsteroidPainter to use CachedGamePainter
    - [x] Extend CachedGamePainter
    - [x] Implement caching for paths and paints
    - [x] Update shouldRepaint method
  - [x] SSHOTER-010.3: Optimize entity-painter relationship
    - [x] Create AsteroidController for animation logic
    - [x] Move rotation logic to controller
    - [x] Update widget to use controller

- [x] SSHOTER-011: Analyze and optimize bonus_item entity-painter relationship
  - [x] SSHOTER-011.1: Create bonus item visual configuration
    - [x] Create BonusVisualConfig class
    - [x] Extract color constants
    - [x] Extract size and glow constants
    - [x] Extract sparkle effect constants
  - [x] SSHOTER-011.2: Update BonusPainter to use CachedGamePainter
    - [x] Extend CachedGamePainter
    - [x] Implement caching for paths and paints
    - [x] Update shouldRepaint method
  - [x] SSHOTER-011.3: Optimize entity-painter relationship
    - [x] Create BonusController for animation logic
    - [x] Move rotation logic to controller
    - [x] Update widget to use controller

- [ ] SSHOTER-012: Analyze and optimize projectile entity-painter relationship
- [ ] SSHOTER-013: Create shared interfaces for entity-painter relationships
- [ ] SSHOTER-021: Review and optimize collision utils organization
- [ ] SSHOTER-022: Create specialized constant files based on functionality

## Controls & Widgets
- [ ] SSHOTER-002: Analyze game_objects folder structure and organization
- [ ] SSHOTER-003: Review and optimize widget exports in game_objects.dart barrel file

## Entity-Painter Relationships
- [ ] SSHOTER-010: Analyze and optimize asteroid entity-painter relationship
- [ ] SSHOTER-011: Analyze and optimize bonus_item entity-painter relationship
- [ ] SSHOTER-012: Analyze and optimize projectile entity-painter relationship
- [ ] SSHOTER-013: Create shared interfaces for entity-painter relationships

## Utils & Constants
- [ ] SSHOTER-020: Analyze and consolidate app_constants.dart and game/utils/constants.dart
- [ ] SSHOTER-021: Review and optimize collision utils organization
- [ ] SSHOTER-022: Create specialized constant files based on functionality

## Game Managers
- [ ] SSHOTER-030: Review and optimize entity_manager.dart
- [ ] SSHOTER-031: Review and optimize collision_manager.dart
- [ ] SSHOTER-032: Review and optimize game_state_manager.dart
- [ ] SSHOTER-033: Review and optimize input_manager.dart
- [ ] SSHOTER-034: Review and optimize boss_manager.dart
- [ ] SSHOTER-035: Review and optimize bonus_manager.dart

## Screen Organization
- [ ] SSHOTER-040: Review and optimize game_screen.dart structure
- [ ] SSHOTER-041: Review and optimize main_menu.dart structure
- [ ] SSHOTER-042: Extract shared screen components

## Testing & Documentation
- [ ] SSHOTER-050: Create test plan for game entities
- [ ] SSHOTER-051: Create test plan for game managers
- [ ] SSHOTER-052: Create test plan for widgets
- [x] SSHOTER-053: Add documentation for project structure
  - [x] SSHOTER-053.1: Create comprehensive README.md
    - [x] Project overview and features
    - [x] Platform support and requirements
    - [x] Build and run instructions
    - [x] Development setup guide
    - [x] Project structure explanation
  - [x] SSHOTER-053.2: Add LICENSE file
  - [x] SSHOTER-053.3: Create CONTRIBUTING.md
  - [x] SSHOTER-053.4: Add code of conduct
  - [x] SSHOTER-054: Implement SVG assets for game objects
    - [x] SSHOTER-054.1: Create player ship SVG
    - [x] SSHOTER-054.2: Create PlayerShipWidget
    - [x] SSHOTER-054.3: Add SVG support to project

## Performance & Optimization
- [ ] SSHOTER-060: Review and optimize game loop performance
- [ ] SSHOTER-061: Review and optimize widget rebuilds
- [ ] SSHOTER-062: Review and optimize asset loading

## Code Quality
- [ ] SSHOTER-070: Implement consistent error handling
- [ ] SSHOTER-071: Review and fix any circular dependencies
- [ ] SSHOTER-072: Implement consistent naming conventions
- [ ] SSHOTER-073: Remove code duplication and consolidate implementations
  - [x] SSHOTER-073.1 Migrate constants to new configuration system
    - [x] SSHOTER-073.1.1 Migrate player constants
    - [x] SSHOTER-073.1.2 Migrate gameplay constants
    - [x] SSHOTER-073.1.3 Migrate UI constants
    - [x] SSHOTER-073.1.4 Migrate animation constants
    - [x] SSHOTER-073.1.5 Migrate enemy constants
  - [~] SSHOTER-073.2 Remove deprecated constant files and unify player implementation
    - [x] SSHOTER-073.2.1 Remove deprecated constant files
    - [ ] SSHOTER-073.2.2 Create unified player implementation
      - [ ] Create PlayerEntity class
      - [ ] Create PlayerController class
      - [ ] Create PlayerView class
      - [ ] Update all references to use new player implementation
    - [ ] SSHOTER-073.2.3 Remove old player implementation files

## Task Status Legend
- [ ] Not Started
- [x] Completed
- [~] In Progress
- [!] Blocked
- [?] Needs Discussion

## Notes
1. Each task should be completed in isolation unless specifically noted
2. Follow the commit message format: "type(scope): SSHOTER-xxx brief description"
3. Always test before marking a task as complete
4. Document any dependencies between tasks
5. Update this file as tasks are completed or new tasks are identified 