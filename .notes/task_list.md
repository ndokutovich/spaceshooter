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
      - [~] Update import statements
        - [x] main_menu.dart
        - [ ] options_screen.dart
        - [ ] high_scores_screen.dart
        - [ ] splash_screen.dart
        - [ ] menu_button.dart
        - [ ] performance_overlay.dart
        - [ ] game_logo.dart
        - [ ] controls_tab.dart
        - [ ] misc_tab.dart
        - [ ] game_screen.dart
      - [ ] Test all changes
    - [ ] SSHOTER-020.4: Remove old constant files

## Pending Tasks
- [~] SSHOTER-002: Analyze game_objects folder structure and organization
  - Subtasks:
    - [x] SSHOTER-002.1: Create base painter class for game objects
    - [x] SSHOTER-002.2: Update barrel file exports
    - [?] SSHOTER-002.3: Refactor boss_widget.dart (postponed)
      - [ ] SSHOTER-002.3.1: Extract common painting utilities to BaseGamePainter
      - [ ] SSHOTER-002.3.2: Split BossPainter into component painters
      - [ ] SSHOTER-002.3.3: Create configuration objects for visual properties
      - [ ] SSHOTER-002.3.4: Implement caching for complex paths and gradients
      - [ ] SSHOTER-002.3.5: Extract magic numbers to constants

- [ ] SSHOTER-003: Review and optimize widget exports in game_objects.dart barrel file
- [ ] SSHOTER-010: Analyze and optimize asteroid entity-painter relationship
- [ ] SSHOTER-011: Analyze and optimize bonus_item entity-painter relationship
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
- [ ] SSHOTER-053: Add documentation for project structure

## Performance & Optimization
- [ ] SSHOTER-060: Review and optimize game loop performance
- [ ] SSHOTER-061: Review and optimize widget rebuilds
- [ ] SSHOTER-062: Review and optimize asset loading

## Code Quality
- [ ] SSHOTER-070: Implement consistent error handling
- [ ] SSHOTER-071: Review and fix any circular dependencies
- [ ] SSHOTER-072: Implement consistent naming conventions

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