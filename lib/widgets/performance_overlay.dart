import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import '../utils/constants/style_constants.dart';

class GamePerformanceOverlay extends StatefulWidget {
  const GamePerformanceOverlay({super.key});

  @override
  State<GamePerformanceOverlay> createState() => _GamePerformanceOverlayState();
}

class _GamePerformanceOverlayState extends State<GamePerformanceOverlay>
    with SingleTickerProviderStateMixin {
  double _fps = 0;
  double _frameTime = 0;
  int _frameCount = 0;
  late DateTime _lastUpdate;
  late Ticker _ticker;

  @override
  void initState() {
    super.initState();
    _lastUpdate = DateTime.now();
    _ticker = createTicker(_onTick)..start();
  }

  void _onTick(Duration elapsed) {
    _frameCount++;
    final now = DateTime.now();
    final diff = now.difference(_lastUpdate);

    if (diff.inMilliseconds >= 1000) {
      setState(() {
        _fps = _frameCount * 1000 / diff.inMilliseconds;
        _frameTime = diff.inMicroseconds / _frameCount / 1000; // Convert to ms
        _frameCount = 0;
        _lastUpdate = now;
      });
    }
  }

  @override
  void dispose() {
    _ticker.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 10,
      right: 10,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: StyleConstants.overlayColor,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: StyleConstants.playerColor.withOpacity(StyleConstants.opacityLow),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              'FPS: ${_fps.toStringAsFixed(1)}',
              style: TextStyle(
                color: _fps >= 55
                    ? Colors.green
                    : (_fps >= 30 ? Colors.yellow : Colors.red),
                fontSize: StyleConstants.bodyFontSize,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Frame Time: ${_frameTime.toStringAsFixed(1)}ms',
              style: TextStyle(
                color: StyleConstants.textColor.withOpacity(StyleConstants.opacityMedium),
                fontSize: StyleConstants.bodyFontSize * 0.8,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
