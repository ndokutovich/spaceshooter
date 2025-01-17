import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class HighScore {
  final int score;
  final DateTime date;

  HighScore({required this.score, required this.date});

  Map<String, dynamic> toJson() => {
        'score': score,
        'date': date.toIso8601String(),
      };

  factory HighScore.fromJson(Map<String, dynamic> json) => HighScore(
        score: json['score'] as int,
        date: DateTime.parse(json['date'] as String),
      );
}

class HighScoreService {
  static const String _fileName = 'high_scores.json';
  static const int _maxScores = 5;

  static Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  static Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/$_fileName');
  }

  static Future<List<HighScore>> getHighScores() async {
    try {
      final file = await _localFile;
      if (!await file.exists()) return [];

      final contents = await file.readAsString();
      final List<dynamic> jsonList = json.decode(contents);
      return jsonList.map((json) => HighScore.fromJson(json)).toList()
        ..sort((a, b) => b.score.compareTo(a.score));
    } catch (e) {
      return [];
    }
  }

  static Future<void> addScore(int score) async {
    final scores = await getHighScores();
    final newScore = HighScore(score: score, date: DateTime.now());

    scores.add(newScore);
    scores.sort((a, b) => b.score.compareTo(a.score));

    if (scores.length > _maxScores) {
      scores.removeRange(_maxScores, scores.length);
    }

    final file = await _localFile;
    await file.writeAsString(json.encode(
      scores.map((score) => score.toJson()).toList(),
    ));
  }
}
