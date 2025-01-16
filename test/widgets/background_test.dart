import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:space_shooter/widgets/background.dart';

void main() {
  group('Star Tests', () {
    test('Star initializes with correct values', () {
      final star = Star(
        position: const Offset(100, 100),
        size: 2.0,
        opacity: 0.8,
        twinkleSpeed: 1.0,
        maxBrightness: 0.9,
      );

      expect(star.position, const Offset(100, 100));
      expect(star.size, 2.0);
      expect(star.opacity, 0.8);
      expect(star.twinkleSpeed, 1.0);
      expect(star.maxBrightness, 0.9);
    });

    test('Star defaults opacity to 1.0', () {
      final star = Star(
        position: const Offset(0, 0),
        size: 1.0,
        twinkleSpeed: 1.0,
        maxBrightness: 1.0,
      );

      expect(star.opacity, 1.0);
    });
  });

  group('StarBackground Tests', () {
    testWidgets('StarBackground initializes with correct size', (tester) async {
      const screenSize = Size(800, 600);

      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: StarBackground(screenSize: screenSize),
        ),
      ));

      final starBackground = find.byType(StarBackground);
      expect(starBackground, findsOneWidget);

      final widget = tester.widget<StarBackground>(starBackground);
      expect(widget.screenSize, screenSize);
    });

    testWidgets('StarBackground creates and renders', (tester) async {
      await tester.pumpWidget(const MaterialApp(
        home: Scaffold(
          body: StarBackground(screenSize: Size(800, 600)),
        ),
      ));

      await tester.pump(const Duration(milliseconds: 100));
      expect(find.byType(StarBackground), findsOneWidget);
    });

    testWidgets('StarBackground animates over time', (tester) async {
      await tester.pumpWidget(const MaterialApp(
        home: Scaffold(
          body: StarBackground(screenSize: Size(800, 600)),
        ),
      ));

      // Initial state
      await tester.pump();
      final initialWidget = find.byType(StarBackground);
      expect(initialWidget, findsOneWidget);

      // After animation
      await tester.pump(const Duration(milliseconds: 500));
      final animatedWidget = find.byType(StarBackground);
      expect(animatedWidget, findsOneWidget);
    });
  });

  group('StarPainter Tests', () {
    test('StarPainter shouldRepaint always returns true', () {
      final stars = [
        Star(
          position: const Offset(0, 0),
          size: 1.0,
          twinkleSpeed: 1.0,
          maxBrightness: 1.0,
        ),
      ];

      final painter1 = StarPainter(stars);
      final painter2 = StarPainter(stars);

      expect(painter1.shouldRepaint(painter2), isTrue);
    });
  });
}
