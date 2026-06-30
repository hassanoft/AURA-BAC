import 'package:hive/hive.dart';

part 'course_model.g.dart';

/// Course (Cours) model
@HiveType(typeId: 2)
class CourseModel extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String subjectId;

  @HiveField(2)
  final String title;

  @HiveField(3)
  final String summary;

  @HiveField(4)
  final String content;

  @HiveField(5)
  final String chapter;

  @HiveField(6)
  final int orderIndex;

  @HiveField(7)
  final List<String> tags;

  @HiveField(8)
  final String difficulty;

  @HiveField(9)
  final int estimatedMinutes;

  @HiveField(10)
  DateTime lastConsulted;

  @HiveField(11)
  bool isCompleted;

  @HiveField(12)
  final List<String> tips;

  CourseModel({
    required this.id,
    required this.subjectId,
    required this.title,
    required this.summary,
    required this.content,
    required this.chapter,
    required this.orderIndex,
    required this.tags,
    required this.difficulty,
    required this.estimatedMinutes,
    required this.tips,
    DateTime? lastConsulted,
    this.isCompleted = false,
  }) : lastConsulted = lastConsulted ?? DateTime(2000);
}

/// Exercise model
@HiveType(typeId: 9)
class ExerciseModel extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String subjectId;

  @HiveField(2)
  final String courseId;

  @HiveField(3)
  final String title;

  @HiveField(4)
  final String statement;

  @HiveField(5)
  final String solution;

  @HiveField(6)
  final String difficulty;

  @HiveField(7)
  final List<String> steps;

  @HiveField(8)
  final int points;

  @HiveField(9)
  bool isCompleted;

  ExerciseModel({
    required this.id,
    required this.subjectId,
    required this.courseId,
    required this.title,
    required this.statement,
    required this.solution,
    required this.difficulty,
    required this.steps,
    required this.points,
    this.isCompleted = false,
  });
}

/// BAC Subject (Sujet BAC) model
@HiveType(typeId: 10)
class BacSubjectModel extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String subjectId;

  @HiveField(2)
  final String seriesId;

  @HiveField(3)
  final int year;

  @HiveField(4)
  final String title;

  @HiveField(5)
  final String content;

  @HiveField(6)
  final String correction;

  @HiveField(7)
  final String session; // Session 1, Session 2

  BacSubjectModel({
    required this.id,
    required this.subjectId,
    required this.seriesId,
    required this.year,
    required this.title,
    required this.content,
    required this.correction,
    required this.session,
  });
}
