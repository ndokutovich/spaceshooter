import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/services.dart';
import 'package:space_shooter/widgets/controls.dart';

void main() {
  group('JoystickController Tests', () {
    testWidgets('JoystickController initializes correctly', (tester) async {
      Offset? moveOffset;

      await tester.pumpWidget(MaterialApp(
        home: JoystickController(
          onMove: (offset) => moveOffset = offset,
        ),
      ));

      final joystickFinder = find.byType(JoystickController);
      expect(joystickFinder, findsOneWidget);
    });

    testWidgets('JoystickController responds to pan gestures', (tester) async {
      Offset? moveOffset;

      await tester.pumpWidget(MaterialApp(
        home: JoystickController(
          onMove: (offset) => moveOffset = offset,
        ),
      ));

      final gesture = await tester.startGesture(const Offset(40.0, 40.0));
      await gesture.moveBy(const Offset(20.0, 0.0));
      await tester.pump();

      expect(moveOffset, isNotNull);
      expect(moveOffset!.dx, isNot(0));
    });
  });

  group('ActionButton Tests', () {
    testWidgets('ActionButton displays label correctly', (tester) async {
      const label = 'Test';
      var pressed = false;

      await tester.pumpWidget(MaterialApp(
        home: ActionButton(
          onPressed: () => pressed = true,
          label: label,
          color: Colors.blue,
        ),
      ));

      expect(find.text(label), findsOneWidget);
    });

    testWidgets('ActionButton displays counter when provided', (tester) async {
      const label = 'Test';
      const counter = '5';

      await tester.pumpWidget(MaterialApp(
        home: ActionButton(
          onPressed: () {},
          label: label,
          color: Colors.blue,
          counter: counter,
        ),
      ));

      expect(find.text(counter), findsOneWidget);
    });

    testWidgets('ActionButton triggers onPressed when tapped', (tester) async {
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
  });
}
