import 'package:flutter/material.dart';
import '../../utils/app_constants.dart';

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
      padding: const EdgeInsets.all(AppConstants.uiPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppConstants.volumeText,
            style: TextStyle(
              color: AppConstants.playerColor,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Container(
            decoration: BoxDecoration(
              color: Colors.black26,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: AppConstants.playerColor.withOpacity(0.3),
              ),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: [
                Icon(
                  Icons.volume_up,
                  color: AppConstants.playerColor,
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: SliderTheme(
                    data: SliderThemeData(
                      activeTrackColor: AppConstants.playerColor,
                      inactiveTrackColor:
                          AppConstants.playerColor.withOpacity(0.3),
                      thumbColor: AppConstants.playerColor,
                      overlayColor: AppConstants.playerColor.withOpacity(0.1),
                      trackHeight: 4,
                    ),
                    child: Slider(
                      value: volume,
                      onChanged: onVolumeChanged,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Text(
                  '${(volume * 100).round()}%',
                  style: TextStyle(
                    color: AppConstants.textColor,
                    fontSize: 16,
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
