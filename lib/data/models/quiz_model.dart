import 'package:hive/hive.dart';

part 'quiz_model.g.dart';

/// Quiz Question model
@HiveType(typeId: 4)
class QuizQuestion extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String question;

  @HiveField(2)
  final List<String> options;

  @HiveField(3)
  final int correctIndex;

  @HiveField(4)
  final String explanation;

  @HiveField(5)
  final String difficulty;

  @HiveField(6)
  final int points;

  QuizQuestion({
    required this.id,
    required this.question,
    required this.options,
    required this.correctIndex,
    required this.explanation,
    required this.difficulty,
    this.points = 1,
  });
}

/// Quiz model
@HiveType(typeId: 3)
class QuizModel extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String subjectId;

  @HiveField(2)
  final String title;

  @HiveField(3)
  final String description;

  @HiveField(4)
  final List<QuizQuestion> questions;

  @HiveField(5)
  final String difficulty;

  @HiveField(6)
  final int timeLimitSeconds;

  @HiveField(7)
  final List<String> seriesIds;

  @HiveField(8)
  int timesPlayed;

  @HiveField(9)
  double bestScore;

  QuizModel({
    required this.id,
    required this.subjectId,
    required this.title,
    required this.description,
    required this.questions,
    required this.difficulty,
    required this.timeLimitSeconds,
    required this.seriesIds,
    this.timesPlayed = 0,
    this.bestScore = 0.0,
  });

  int get totalPoints => questions.fold(0, (sum, q) => sum + q.points);
}

/// Quiz Result model
@HiveType(typeId: 5)
class QuizResult extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String quizId;

  @HiveField(2)
  final String quizTitle;

  @HiveField(3)
  final String subjectId;

  @HiveField(4)
  final int score;

  @HiveField(5)
  final int totalPoints;

  @HiveField(6)
  final int correctAnswers;

  @HiveField(7)
  final int totalQuestions;

  @HiveField(8)
  final int timeTakenSeconds;

  @HiveField(9)
  final DateTime completedAt;

  @HiveField(10)
  final List<int> userAnswers;

  @HiveField(11)
  final String difficulty;

  QuizResult({
    required this.id,
    required this.quizId,
    required this.quizTitle,
    required this.subjectId,
    required this.score,
    required this.totalPoints,
    required this.correctAnswers,
    required this.totalQuestions,
    required this.timeTakenSeconds,
    required this.completedAt,
    required this.userAnswers,
    required this.difficulty,
  });

  double get percentage => totalPoints > 0 ? (score / totalPoints) * 100 : 0;

  String get grade {
    if (percentage >= 90) return 'Excellent';
    if (percentage >= 75) return 'Très bien';
    if (percentage >= 60) return 'Bien';
    if (percentage >= 50) return 'Passable';
    return 'À améliorer';
  }
}

/// Study Session model
@HiveType(typeId: 8)
class StudySession extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String subjectId;

  @HiveField(2)
  final DateTime date;

  @HiveField(3)
  final int durationMinutes;

  StudySession({
    required this.id,
    required this.subjectId,
    required this.date,
    required this.durationMinutes,
  });
}
