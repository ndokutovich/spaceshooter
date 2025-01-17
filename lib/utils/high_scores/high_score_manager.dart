import 'high_score_model.dart';
import 'high_score_repository.dart';

class HighScoreManager {
  static const int _maxScores = 5;
  final HighScoreRepository _repository;

  HighScoreManager({HighScoreRepository? repository})
      : _repository = repository ?? HighScoreRepository();

  Future<List<HighScore>> getHighScores() async {
    final scores = await _repository.loadHighScores();
    scores.sort((a, b) => b.score.compareTo(a.score));
    return scores;
  }

  Future<void> addScore(int score) async {
    final scores = await getHighScores();
    final newScore = HighScore(score: score, date: DateTime.now());

    scores.add(newScore);
    scores.sort((a, b) => b.score.compareTo(a.score));

    if (scores.length > _maxScores) {
      scores.removeRange(_maxScores, scores.length);
    }

    await _repository.saveHighScores(scores);
  }
}
