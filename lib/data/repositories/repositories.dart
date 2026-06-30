import 'package:hive/hive.dart';
import '../models/series_model.dart';
import '../models/subject_model.dart';
import '../models/course_model.dart';
import '../models/quiz_model.dart';
import '../models/favorite_model.dart';
import '../../core/constants/app_constants.dart';

/// Repository for Series data
class SeriesRepository {
  List<SeriesModel> getAllSeries() => SeriesModel.defaultSeries;

  SeriesModel? getSeriesById(String id) =>
      SeriesModel.defaultSeries.where((s) => s.id == id).firstOrNull;

  List<SeriesModel> getSeriesByCategory(String category) =>
      SeriesModel.defaultSeries.where((s) => s.category == category).toList();
}

/// Repository for Subject data
class SubjectRepository {
  List<SubjectModel> getAllSubjects() => SubjectModel.defaultSubjects;

  SubjectModel? getSubjectById(String id) =>
      SubjectModel.defaultSubjects.where((s) => s.id == id).firstOrNull;

  List<SubjectModel> getSubjectsBySeries(String seriesId) =>
      SubjectModel.defaultSubjects
          .where((s) => s.seriesIds.contains(seriesId))
          .toList();
}

/// Repository for Course data
class CourseRepository {
  Box get _box => Hive.box(AppConstants.coursesBox);

  /// Get all courses
  List<CourseModel> getAllCourses() => _box.values
      .where((v) => v is CourseModel)
      .cast<CourseModel>()
      .toList();

  /// Get courses by subject
  List<CourseModel> getCoursesBySubject(String subjectId) => _box.values
      .whereType<CourseModel>()
      .where((c) => c.subjectId == subjectId)
      .toList()
    ..sort((a, b) => a.orderIndex.compareTo(b.orderIndex));

  /// Get single course
  CourseModel? getCourseById(String id) {
    final val = _box.get(id);
    return val is CourseModel ? val : null;
  }

  /// Mark course as consulted
  Future<void> markConsulted(String courseId) async {
    final course = getCourseById(courseId);
    if (course != null) {
      course.lastConsulted = DateTime.now();
      await course.save();
    }
  }

  /// Mark course as completed
  Future<void> markCompleted(String courseId, bool completed) async {
    final course = getCourseById(courseId);
    if (course != null) {
      course.isCompleted = completed;
      await course.save();
    }
  }

  /// Get recently consulted courses
  List<CourseModel> getRecentCourses({int limit = 5}) {
    final courses = getAllCourses()
      ..sort((a, b) => b.lastConsulted.compareTo(a.lastConsulted));
    return courses
        .where((c) => c.lastConsulted.isAfter(DateTime(2001)))
        .take(limit)
        .toList();
  }

  /// Get all exercises
  List<ExerciseModel> getAllExercises() => _box.values
      .whereType<ExerciseModel>()
      .toList();

  /// Get exercises by subject
  List<ExerciseModel> getExercisesBySubject(String subjectId) => _box.values
      .whereType<ExerciseModel>()
      .where((e) => e.subjectId == subjectId)
      .toList();

  /// Get exercise by ID
  ExerciseModel? getExerciseById(String id) {
    final val = _box.get('ex_$id');
    return val is ExerciseModel ? val : null;
  }

  /// Get BAC subjects by series
  List<BacSubjectModel> getBacSubjectsBySeries(String seriesId) => _box.values
      .whereType<BacSubjectModel>()
      .where((b) => b.seriesId == seriesId)
      .toList()
    ..sort((a, b) => b.year.compareTo(a.year));

  /// Get BAC subject by ID
  BacSubjectModel? getBacSubjectById(String id) {
    final val = _box.get('bac_$id');
    return val is BacSubjectModel ? val : null;
  }

  /// Search across all content
  List<dynamic> search(String query) {
    if (query.trim().isEmpty) return [];
    final q = query.toLowerCase();
    final results = <dynamic>[];

    results.addAll(getAllCourses()
        .where((c) =>
            c.title.toLowerCase().contains(q) ||
            c.summary.toLowerCase().contains(q) ||
            c.tags.any((t) => t.toLowerCase().contains(q)))
        .take(5));

    results.addAll(getAllExercises()
        .where((e) =>
            e.title.toLowerCase().contains(q) ||
            e.statement.toLowerCase().contains(q))
        .take(3));

    return results;
  }
}

/// Repository for Quiz data
class QuizRepository {
  Box<QuizModel> get _quizBox => Hive.box<QuizModel>(AppConstants.quizzesBox);
  Box<QuizResult> get _resultBox =>
      Hive.box<QuizResult>(AppConstants.quizResultsBox);

  List<QuizModel> getAllQuizzes() => _quizBox.values.toList();

  List<QuizModel> getQuizzesBySubject(String subjectId) => _quizBox.values
      .where((q) => q.subjectId == subjectId)
      .toList();

  List<QuizModel> getQuizzesBySeries(String seriesId) => _quizBox.values
      .where((q) => q.seriesIds.contains(seriesId))
      .toList();

  QuizModel? getQuizById(String id) => _quizBox.get(id);

  Future<void> saveQuizResult(QuizResult result) async {
    await _resultBox.put(result.id, result);

    // Update quiz stats
    final quiz = getQuizById(result.quizId);
    if (quiz != null) {
      quiz.timesPlayed++;
      if (result.percentage > quiz.bestScore) {
        quiz.bestScore = result.percentage;
      }
      await quiz.save();
    }
  }

  List<QuizResult> getAllResults() => _resultBox.values.toList()
    ..sort((a, b) => b.completedAt.compareTo(a.completedAt));

  List<QuizResult> getResultsBySubject(String subjectId) =>
      _resultBox.values
          .where((r) => r.subjectId == subjectId)
          .toList()
        ..sort((a, b) => b.completedAt.compareTo(a.completedAt));

  double getAverageScore() {
    final results = getAllResults();
    if (results.isEmpty) return 0;
    return results.map((r) => r.percentage).reduce((a, b) => a + b) /
        results.length;
  }

  int getTotalQuizzesTaken() => _resultBox.length;

  int getTotalTimeTaken() =>
      _resultBox.values.fold(0, (sum, r) => sum + r.timeTakenSeconds);
}

/// Repository for Favorites
class FavoriteRepository {
  Box<FavoriteModel> get _box =>
      Hive.box<FavoriteModel>(AppConstants.favoritesBox);

  List<FavoriteModel> getAllFavorites() => _box.values.toList()
    ..sort((a, b) => b.savedAt.compareTo(a.savedAt));

  bool isFavorite(String itemId) => _box.containsKey(itemId);

  Future<void> addFavorite(FavoriteModel fav) async {
    await _box.put(fav.itemId, fav);
  }

  Future<void> removeFavorite(String itemId) async {
    await _box.delete(itemId);
  }

  Future<void> toggleFavorite(FavoriteModel fav) async {
    if (isFavorite(fav.itemId)) {
      await removeFavorite(fav.itemId);
    } else {
      await addFavorite(fav);
    }
  }
}

/// Repository for Progress tracking
class ProgressRepository {
  Box<ProgressModel> get _box =>
      Hive.box<ProgressModel>(AppConstants.progressBox);

  ProgressModel getProgress(String subjectId) =>
      _box.get(subjectId) ??
      ProgressModel(
        subjectId: subjectId,
        totalCourses: 5,
        totalExercises: 3,
      );

  Future<void> updateProgress(ProgressModel progress) async {
    await _box.put(progress.subjectId, progress);
  }

  double getOverallProgress() {
    if (_box.isEmpty) return 0;
    final total =
        _box.values.map((p) => p.overallProgress).reduce((a, b) => a + b);
    return total / _box.length;
  }

  int getTotalStudyMinutes() =>
      _box.values.fold(0, (sum, p) => sum + p.studyMinutes);
}
