# Task List

## Controls & Widgets
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
- [~] SSHOTER-002: Analyze game_objects folder structure and organization
  - Analysis Notes:
    1. Current Structure:
       - Base widget: game_object_widget.dart (reusable CustomPaint wrapper)
       - Painters: *_painter.dart files for each game object
       - Special case: boss_widget.dart (much larger, complex widget)
    2. Issues Found:
       - boss_widget.dart doesn't follow painter pattern
       - Missing exports for boss_widget.dart in barrel file
       - No shared base painter class for common functionality
       - Inconsistent file sizes suggest potential refactoring needs
    3. Recommendations:
       - Create base painter class for shared functionality
       - Split boss_widget.dart into smaller components
       - Add missing exports to barrel file
       - Standardize painter implementations
  - Subtasks:
    - [x] SSHOTER-002.1: Create base painter class for game objects
    - [x] SSHOTER-002.2: Update barrel file exports
    - [?] SSHOTER-002.3: Refactor boss_widget.dart
      - [ ] SSHOTER-002.3.1: Extract common painting utilities to BaseGamePainter
      - [ ] SSHOTER-002.3.2: Split BossPainter into component painters (shield, body, etc.)
      - [ ] SSHOTER-002.3.3: Create configuration objects for visual properties
      - [ ] SSHOTER-002.3.4: Implement caching for complex paths and gradients
      - [ ] SSHOTER-002.3.5: Extract magic numbers to constants
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