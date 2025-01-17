import 'package:flutter/material.dart';
import '../../utils/app_constants.dart';

class HeartPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppConstants.enemyColor
      ..style = PaintingStyle.fill;

    final path = Path();
    path.moveTo(size.width / 2, size.height / 5);

    // Left curve
    path.cubicTo(size.width / 8, 0, -size.width / 4, size.height / 2,
        size.width / 2, size.height);

    // Right curve
    path.cubicTo(size.width * 1.25, size.height / 2, size.width * 0.875, 0,
        size.width / 2, size.height / 5);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(HeartPainter oldDelegate) => false;
}

class NovaCounterPainter extends CustomPainter {
  final String count;

  NovaCounterPainter(this.count);

  @override
  void paint(Canvas canvas, Size size) {
    // Draw background circle
    final bgPaint = Paint()
      ..color = AppConstants.primaryColor.withOpacity(0.3)
      ..style = PaintingStyle.fill;
    canvas.drawCircle(
        Offset(size.width / 2, size.height / 2), size.width / 2, bgPaint);

    // Draw text
    final textPainter = TextPainter(
      text: TextSpan(
        text: count,
        style: TextStyle(
          color: AppConstants.textColor,
          fontSize: size.height * 0.6,
          fontWeight: FontWeight.bold,
        ),
      ),
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();
    textPainter.paint(
      canvas,
      Offset(
        (size.width - textPainter.width) / 2,
        (size.height - textPainter.height) / 2,
      ),
    );
  }

  @override
  bool shouldRepaint(NovaCounterPainter oldDelegate) =>
      count != oldDelegate.count;
}
