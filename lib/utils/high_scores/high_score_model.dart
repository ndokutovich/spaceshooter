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
