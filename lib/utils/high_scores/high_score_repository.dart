import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'high_score_model.dart';

class HighScoreRepository {
  static const String _fileName = 'high_scores.json';

  static Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  static Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/$_fileName');
  }

  Future<List<HighScore>> loadHighScores() async {
    try {
      final file = await _localFile;
      if (!await file.exists()) return [];

      final contents = await file.readAsString();
      final List<dynamic> jsonList = json.decode(contents);
      return jsonList.map((json) => HighScore.fromJson(json)).toList();
    } catch (e) {
      return [];
    }
  }

  Future<void> saveHighScores(List<HighScore> scores) async {
    final file = await _localFile;
    await file.writeAsString(json.encode(
      scores.map((score) => score.toJson()).toList(),
    ));
  }
}
