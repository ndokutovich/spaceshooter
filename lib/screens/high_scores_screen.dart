import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../utils/high_scores.dart';
import '../utils/constants/ui_constants.dart';
import '../utils/constants/style_constants.dart';
import '../widgets/menu_button.dart';

class HighScoresScreen extends StatelessWidget {
  const HighScoresScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final buttonWidth = screenSize.width * 0.35;
    final buttonHeight = screenSize.height * 0.08;
    final buttonSpacing = screenSize.height * 0.02;

    return Scaffold(
      backgroundColor: StyleConstants.backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: MenuButton(
          text: '←',
          onPressed: () => Navigator.of(context).pop(),
          width: buttonHeight,
          height: buttonHeight,
        ),
        title: Text(
          UIConstants.menuHighScoresText,
          style: TextStyle(
            color: StyleConstants.textColor,
            fontSize: StyleConstants.titleFontSize,
            fontWeight: FontWeight.bold,
            shadows: [
              Shadow(
                color: StyleConstants.playerColor,
                blurRadius: StyleConstants.logoBlurRadius,
              ),
            ],
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Top Scores',
              style: TextStyle(
                color: StyleConstants.textColor,
                fontSize: StyleConstants.subtitleFontSize,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: UIConstants.menuButtonSpacing * 2),
            FutureBuilder<List<HighScore>>(
              future: HighScoreService.getHighScores(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                }

                final scores = snapshot.data ?? [];
                if (scores.isEmpty) {
                  return Text(
                    'No scores yet!',
                    style: TextStyle(
                      color: StyleConstants.textColor,
                      fontSize: StyleConstants.subtitleFontSize,
                    ),
                  );
                }

                return Container(
                  padding: EdgeInsets.all(UIConstants.highScoresPadding),
                  decoration: BoxDecoration(
                    color: StyleConstants.playerColor
                        .withOpacity(StyleConstants.opacityUltraLow),
                    borderRadius: BorderRadius.circular(
                        UIConstants.highScoresBorderRadius),
                    border: Border.all(
                      color: StyleConstants.playerColor
                          .withOpacity(StyleConstants.opacityVeryLow),
                      width: UIConstants.highScoresBorderWidth,
                    ),
                  ),
                  child: DataTable(
                    columnSpacing: UIConstants.highScoresColumnSpacing,
                    columns: [
                      DataColumn(
                        label: Text(
                          'Rank',
                          style: TextStyle(
                            color: StyleConstants.textColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          'Score',
                          style: TextStyle(
                            color: StyleConstants.textColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          'Date',
                          style: TextStyle(
                            color: StyleConstants.textColor,
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
                              style: TextStyle(
                                color: StyleConstants.textColor,
                              ),
                            ),
                          ),
                          DataCell(
                            Text(
                              '${score.score}',
                              style: TextStyle(
                                color: StyleConstants.textColor,
                              ),
                            ),
                          ),
                          DataCell(
                            Text(
                              dateFormat.format(score.date),
                              style: TextStyle(
                                color: StyleConstants.textColor,
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
            SizedBox(height: buttonSpacing * 2),
            MenuButton(
              text: UIConstants.backText,
              onPressed: () => Navigator.of(context).pop(),
              width: buttonWidth,
              height: buttonHeight,
            ),
          ],
        ),
      ),
    );
  }
}
