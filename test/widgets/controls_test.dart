import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:space_shooter/widgets/controls.dart';

void main() {
  group('JoystickController Tests', () {
    late Offset moveOffset;

    setUp(() {
      moveOffset = Offset.zero;
    });

    testWidgets('JoystickController initializes correctly', (tester) async {
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: JoystickController(
            onMove: (offset) => moveOffset = offset,
          ),
        ),
      ));

      final joystickFinder = find.byType(JoystickController);
      expect(joystickFinder, findsOneWidget);
      expect(moveOffset, Offset.zero);
    });

    testWidgets('JoystickController handles pan start', (tester) async {
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: JoystickController(
            onMove: (offset) => moveOffset = offset,
            key: const Key('joystick_controller'),
          ),
        ),
      ));

      // Find the actual joystick position using descendant finder
      final joystickFinder = find.descendant(
        of: find.byKey(const Key('joystick_controller')),
        matching: find.byType(CustomPaint),
      );
      final joystickPosition = tester.getCenter(joystickFinder);

      // Start gesture at joystick center
      final gesture = await tester.startGesture(joystickPosition);
      await tester.pump();

      // Move slightly to trigger movement
      await gesture.moveBy(const Offset(10.0, 0.0));
      await tester.pump();

      expect(moveOffset, isNot(Offset.zero));
      await gesture.up();
    });

    testWidgets('JoystickController handles pan update', (tester) async {
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: JoystickController(
            onMove: (offset) => moveOffset = offset,
            key: const Key('joystick_controller'),
          ),
        ),
      ));

      final joystickFinder = find.descendant(
        of: find.byKey(const Key('joystick_controller')),
        matching: find.byType(CustomPaint),
      );
      final joystickPosition = tester.getCenter(joystickFinder);

      final gesture = await tester.startGesture(joystickPosition);
      await tester.pump();
      await gesture.moveBy(const Offset(20.0, 0.0));
      await tester.pump();

      expect(moveOffset.dx, isNot(0));
      await gesture.up();
    });

    testWidgets('JoystickController handles pan end', (tester) async {
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: JoystickController(
            onMove: (offset) => moveOffset = offset,
            key: const Key('joystick_controller'),
          ),
        ),
      ));

      final joystickFinder = find.descendant(
        of: find.byKey(const Key('joystick_controller')),
        matching: find.byType(CustomPaint),
      );
      final joystickPosition = tester.getCenter(joystickFinder);

      final gesture = await tester.startGesture(joystickPosition);
      await tester.pump();
      await gesture.up();
      await tester.pump();

      expect(moveOffset, Offset.zero);
    });

    testWidgets('JoystickController handles movement beyond radius',
        (tester) async {
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: JoystickController(
            onMove: (offset) => moveOffset = offset,
            key: const Key('joystick_controller'),
          ),
        ),
      ));

      final joystickFinder = find.descendant(
        of: find.byKey(const Key('joystick_controller')),
        matching: find.byType(CustomPaint),
      );
      final joystickPosition = tester.getCenter(joystickFinder);

      final gesture = await tester.startGesture(joystickPosition);
      await tester.pump();
      await gesture.moveBy(const Offset(100.0, 0.0));
      await tester.pump();

      expect(moveOffset.dx.abs(), lessThanOrEqualTo(5.0)); // Max speed
      await gesture.up();
    });

    testWidgets('JoystickController updates speed based on distance',
        (tester) async {
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: JoystickController(
            onMove: (offset) => moveOffset = offset,
            key: const Key('joystick_controller'),
          ),
        ),
      ));

      final joystickFinder = find.descendant(
        of: find.byKey(const Key('joystick_controller')),
        matching: find.byType(CustomPaint),
      );
      final joystickPosition = tester.getCenter(joystickFinder);

      final gesture = await tester.startGesture(joystickPosition);
      await tester.pump();

      // Test small movement
      await gesture.moveBy(const Offset(10.0, 0.0));
      await tester.pump();
      final smallSpeed = moveOffset.dx.abs();

      // Test larger movement
      await gesture.moveBy(const Offset(20.0, 0.0));
      await tester.pump();
      final largerSpeed = moveOffset.dx.abs();

      expect(largerSpeed, greaterThan(smallSpeed));
      await gesture.up();
    });
  });

  group('JoystickPainter Tests', () {
    test('JoystickPainter shouldRepaint returns true for different positions',
        () {
      final painter1 = JoystickPainter(
        stickPosition: const Offset(0, 0),
        stickRadius: 20,
        baseRadius: 40,
      );

      final painter2 = JoystickPainter(
        stickPosition: const Offset(10, 10),
        stickRadius: 20,
        baseRadius: 40,
      );

      expect(painter1.shouldRepaint(painter2), isTrue);
    });

    test('JoystickPainter shouldRepaint returns false for same positions', () {
      final painter1 = JoystickPainter(
        stickPosition: const Offset(0, 0),
        stickRadius: 20,
        baseRadius: 40,
      );

      final painter2 = JoystickPainter(
        stickPosition: const Offset(0, 0),
        stickRadius: 20,
        baseRadius: 40,
      );

      expect(painter1.shouldRepaint(painter2), isFalse);
    });

    testWidgets('JoystickPainter renders correctly', (tester) async {
      const key = Key('joystick_painter');
      await tester.pumpWidget(
        MaterialApp(
          home: Center(
            child: CustomPaint(
              key: key,
              painter: JoystickPainter(
                stickPosition: const Offset(0, 0),
                stickRadius: 20,
                baseRadius: 40,
              ),
              size: const Size(80, 80),
            ),
          ),
        ),
      );

      expect(find.byKey(key), findsOneWidget);

      final customPaint = tester.widget<CustomPaint>(find.byKey(key));
      final painter = customPaint.painter as JoystickPainter;

      expect(painter.stickPosition, const Offset(0, 0));
      expect(painter.stickRadius, 20.0);
      expect(painter.baseRadius, 40.0);
    });

    testWidgets('JoystickPainter updates with new position', (tester) async {
      const key = Key('joystick_painter');
      const initialPosition = Offset(0, 0);
      const newPosition = Offset(20, 20);

      await tester.pumpWidget(
        MaterialApp(
          home: Center(
            child: CustomPaint(
              key: key,
              painter: JoystickPainter(
                stickPosition: initialPosition,
                stickRadius: 20,
                baseRadius: 40,
              ),
              size: const Size(80, 80),
            ),
          ),
        ),
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Center(
            child: CustomPaint(
              key: key,
              painter: JoystickPainter(
                stickPosition: newPosition,
                stickRadius: 20,
                baseRadius: 40,
              ),
              size: const Size(80, 80),
            ),
          ),
        ),
      );

      final customPaint = tester.widget<CustomPaint>(find.byKey(key));
      final painter = customPaint.painter as JoystickPainter;

      expect(painter.stickPosition, newPosition);
    });

    testWidgets('JoystickPainter handles zero position', (tester) async {
      const key = Key('joystick_painter');
      await tester.pumpWidget(
        MaterialApp(
          home: Center(
            child: CustomPaint(
              key: key,
              painter: JoystickPainter(
                stickPosition: Offset.zero,
                stickRadius: 20,
                baseRadius: 40,
              ),
              size: const Size(80, 80),
            ),
          ),
        ),
      );

      final customPaint = tester.widget<CustomPaint>(find.byKey(key));
      final painter = customPaint.painter as JoystickPainter;

      expect(painter.stickPosition, Offset.zero);
      expect(find.byKey(key), findsOneWidget);
    });
  });

  group('ActionButton Tests', () {
    testWidgets('ActionButton displays label correctly', (tester) async {
      const label = 'Test';

      await tester.pumpWidget(MaterialApp(
        home: ActionButton(
          onPressed: () {},
          label: label,
          color: Colors.blue,
        ),
      ));

      expect(find.text(label), findsOneWidget);
    });

    testWidgets('ActionButton displays counter widget when provided',
        (tester) async {
      const label = 'Test';
      final counterWidget = Container(
        key: const Key('counter_widget'),
        width: 20,
        height: 20,
        color: Colors.red,
      );

      await tester.pumpWidget(MaterialApp(
        home: ActionButton(
          onPressed: () {},
          label: label,
          color: Colors.blue,
          counterWidget: counterWidget,
        ),
      ));

      expect(find.byKey(const Key('counter_widget')), findsOneWidget);
    });

    testWidgets('ActionButton displays counter text when provided',
        (tester) async {
      const label = 'Test';
      const counterText = '5';

      await tester.pumpWidget(MaterialApp(
        home: ActionButton(
          onPressed: () {},
          label: label,
          color: Colors.blue,
          counterText: counterText,
        ),
      ));

      expect(find.text(counterText), findsOneWidget);
    });

    testWidgets('ActionButton triggers onPressed with haptic feedback',
        (tester) async {
      var pressed = false;

      await tester.pumpWidget(MaterialApp(
        home: ActionButton(
          onPressed: () => pressed = true,
          label: 'Test',
          color: Colors.blue,
        ),
      ));

      await tester.tap(find.byType(ActionButton));
      expect(pressed, isTrue);
    });

    testWidgets('ActionButton layout structure is correct', (tester) async {
      const label = 'Test';
      const counterText = '5';

      await tester.pumpWidget(MaterialApp(
        home: ActionButton(
          onPressed: () {},
          label: label,
          color: Colors.blue,
          counterText: counterText,
        ),
      ));

      expect(find.byType(GestureDetector), findsOneWidget);
      expect(find.byType(Column), findsOneWidget);
      expect(find.text(label), findsOneWidget);
      expect(find.text(counterText), findsOneWidget);
    });

    testWidgets('ActionButton applies correct styling', (tester) async {
      const label = 'Test';
      const color = Colors.blue;

      await tester.pumpWidget(MaterialApp(
        home: ActionButton(
          onPressed: () {},
          label: label,
          color: color,
        ),
      ));

      final container = tester.widget<Container>(
        find.descendant(
          of: find.byType(ActionButton),
          matching: find.byType(Container),
        ),
      );

      final decoration = container.decoration as BoxDecoration;
      expect(decoration.border?.top.color, equals(color));
      expect(decoration.borderRadius, isNotNull);
    });
  });
}
