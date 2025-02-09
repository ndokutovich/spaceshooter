import 'package:flutter/material.dart';

import '../../utils/constants/style_constants.dart';
import '../../utils/constants/ui_constants.dart';

class MiscTab extends StatelessWidget {
  final double volume;
  final Function(double) onVolumeChanged;

  const MiscTab({
    super.key,
    required this.volume,
    required this.onVolumeChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(UIConstants.uiPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            UIConstants.volumeText,
            style: TextStyle(
              color: StyleConstants.playerColor,
              fontSize: StyleConstants.bodyFontSize * 1.25,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: UIConstants.uiElementSpacing * 2),
          Container(
            decoration: BoxDecoration(
              color: Colors.black26,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: StyleConstants.playerColor
                    .withOpacity(StyleConstants.opacityLow),
              ),
            ),
            padding: const EdgeInsets.symmetric(
              horizontal: UIConstants.uiPadding * 0.8,
              vertical: UIConstants.uiPadding * 0.4,
            ),
            child: Row(
              children: [
                Icon(
                  Icons.volume_up,
                  color: StyleConstants.playerColor,
                ),
                const SizedBox(width: UIConstants.uiElementSpacing * 2),
                Expanded(
                  child: SliderTheme(
                    data: SliderThemeData(
                      activeTrackColor: StyleConstants.playerColor,
                      inactiveTrackColor: StyleConstants.playerColor
                          .withOpacity(StyleConstants.opacityLow),
                      thumbColor: StyleConstants.playerColor,
                      overlayColor: StyleConstants.playerColor
                          .withOpacity(StyleConstants.opacityVeryLow),
                      trackHeight: 4,
                    ),
                    child: Slider(
                      value: volume,
                      onChanged: onVolumeChanged,
                    ),
                  ),
                ),
                const SizedBox(width: UIConstants.uiElementSpacing * 2),
                Text(
                  '${(volume * 100).round()}%',
                  style: TextStyle(
                    color: StyleConstants.textColor,
                    fontSize: StyleConstants.bodyFontSize,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
