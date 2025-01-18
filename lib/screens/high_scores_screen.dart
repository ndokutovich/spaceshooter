import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../utils/high_scores.dart';
import '../utils/app_constants.dart';
import '../widgets/menu_button.dart';

class HighScoresScreen extends StatelessWidget {
  const HighScoresScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: SpaceButton(
          text: '←',
          onPressed: () => Navigator.of(context).pop(),
          width: AppConstants.highScoresBackButtonSize,
          height: AppConstants.highScoresBackButtonSize,
          fontSize: AppConstants.highScoresBackButtonFontSize,
        ),
        title: Text(
          'High Scores',
          style: TextStyle(
            color: AppConstants.textColor,
            fontSize: AppConstants.highScoresTitleSize,
            fontWeight: FontWeight.bold,
            shadows: const [
              Shadow(
                color: AppConstants.playerColor,
                blurRadius: AppConstants.logoBlurRadius,
              ),
            ],
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Top Scores',
              style: TextStyle(
                color: AppConstants.textColor,
                fontSize: AppConstants.highScoresSubtitleSize,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: AppConstants.menuButtonSpacing * 2),
            FutureBuilder<List<HighScore>>(
              future: HighScoreService.getHighScores(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                }

                final scores = snapshot.data ?? [];
                if (scores.isEmpty) {
                  return const Text(
                    'No scores yet!',
                    style: TextStyle(
                      color: AppConstants.textColor,
                      fontSize: AppConstants.highScoresSubtitleSize,
                    ),
                  );
                }

                return Container(
                  padding: EdgeInsets.all(AppConstants.highScoresPadding),
                  decoration: BoxDecoration(
                    color: AppConstants.playerColor
                        .withOpacity(AppConstants.opacityUltraLow),
                    borderRadius: BorderRadius.circular(
                        AppConstants.highScoresBorderRadius),
                    border: Border.all(
                      color: AppConstants.playerColor
                          .withOpacity(AppConstants.opacityVeryLow),
                      width: AppConstants.highScoresBorderWidth,
                    ),
                  ),
                  child: DataTable(
                    columnSpacing: AppConstants.highScoresColumnSpacing,
                    columns: const [
                      DataColumn(
                        label: Text(
                          'Rank',
                          style: TextStyle(
                            color: AppConstants.textColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          'Score',
                          style: TextStyle(
                            color: AppConstants.textColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          'Date',
                          style: TextStyle(
                            color: AppConstants.textColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                    rows: List.generate(scores.length, (index) {
                      final score = scores[index];
                      final dateFormat = DateFormat('MMM d, y');
                      return DataRow(
                        cells: [
                          DataCell(
                            Text(
                              '${index + 1}',
                              style: const TextStyle(
                                color: AppConstants.textColor,
                              ),
                            ),
                          ),
                          DataCell(
                            Text(
                              '${score.score}',
                              style: const TextStyle(
                                color: AppConstants.textColor,
                              ),
                            ),
                          ),
                          DataCell(
                            Text(
                              dateFormat.format(score.date),
                              style: const TextStyle(
                                color: AppConstants.textColor,
                              ),
                            ),
                          ),
                        ],
                      );
                    }),
                  ),
                );
              },
            ),
            const SizedBox(height: AppConstants.menuButtonSpacing * 2),
            MenuButton(
              text: AppConstants.backText,
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        ),
      ),
    );
  }
}
