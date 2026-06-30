import 'package:hive/hive.dart';

part 'favorite_model.g.dart';

/// Favorite item types
enum FavoriteType { course, exercise, bacSubject }

/// Favorite model
@HiveType(typeId: 6)
class FavoriteModel extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String itemId;

  @HiveField(2)
  final String itemTitle;

  @HiveField(3)
  final String subjectId;

  @HiveField(4)
  final String subjectName;

  @HiveField(5)
  final int typeIndex; // 0=course, 1=exercise, 2=bacSubject

  @HiveField(6)
  final DateTime savedAt;

  FavoriteModel({
    required this.id,
    required this.itemId,
    required this.itemTitle,
    required this.subjectId,
    required this.subjectName,
    required this.typeIndex,
    required this.savedAt,
  });

  FavoriteType get type => FavoriteType.values[typeIndex];
}

/// Progress model per subject
@HiveType(typeId: 7)
class ProgressModel extends HiveObject {
  @HiveField(0)
  final String subjectId;

  @HiveField(1)
  int coursesCompleted;

  @HiveField(2)
  int totalCourses;

  @HiveField(3)
  int exercisesCompleted;

  @HiveField(4)
  int totalExercises;

  @HiveField(5)
  int quizzesTaken;

  @HiveField(6)
  double averageScore;

  @HiveField(7)
  int studyMinutes;

  @HiveField(8)
  DateTime lastStudied;

  ProgressModel({
    required this.subjectId,
    this.coursesCompleted = 0,
    this.totalCourses = 0,
    this.exercisesCompleted = 0,
    this.totalExercises = 0,
    this.quizzesTaken = 0,
    this.averageScore = 0.0,
    this.studyMinutes = 0,
    DateTime? lastStudied,
  }) : lastStudied = lastStudied ?? DateTime.now();

  double get courseProgress =>
      totalCourses > 0 ? coursesCompleted / totalCourses : 0.0;

  double get exerciseProgress =>
      totalExercises > 0 ? exercisesCompleted / totalExercises : 0.0;

  double get overallProgress =>
      (courseProgress + exerciseProgress) / 2;
}
