import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../data/repositories/repositories.dart';
import '../data/models/series_model.dart';
import '../data/models/subject_model.dart';
import '../data/models/course_model.dart';
import '../data/models/quiz_model.dart';
import '../data/models/favorite_model.dart';
import '../core/constants/app_constants.dart';
import 'dart:math';

// ─── REPOSITORY PROVIDERS ────────────────────────────────────────────────────

final seriesRepositoryProvider = Provider<SeriesRepository>((ref) {
  return SeriesRepository();
});

final subjectRepositoryProvider = Provider<SubjectRepository>((ref) {
  return SubjectRepository();
});

final courseRepositoryProvider = Provider<CourseRepository>((ref) {
  return CourseRepository();
});

final quizRepositoryProvider = Provider<QuizRepository>((ref) {
  return QuizRepository();
});

final favoriteRepositoryProvider = Provider<FavoriteRepository>((ref) {
  return FavoriteRepository();
});

final progressRepositoryProvider = Provider<ProgressRepository>((ref) {
  return ProgressRepository();
});

// ─── THEME PROVIDER ──────────────────────────────────────────────────────────

class ThemeNotifier extends StateNotifier<ThemeMode> {
  ThemeNotifier() : super(ThemeMode.light);

  Future<void> loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final isDark = prefs.getBool(AppConstants.prefThemeMode) ?? false;
    state = isDark ? ThemeMode.dark : ThemeMode.light;
  }

  Future<void> toggleTheme() async {
    final newMode =
        state == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    state = newMode;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(
        AppConstants.prefThemeMode, newMode == ThemeMode.dark);
  }

  bool get isDark => state == ThemeMode.dark;
}

final themeProvider = StateNotifierProvider<ThemeNotifier, ThemeMode>((ref) {
  return ThemeNotifier()..loadTheme();
});

// ─── SERIES PROVIDERS ────────────────────────────────────────────────────────

final allSeriesProvider = Provider<List<SeriesModel>>((ref) {
  return ref.watch(seriesRepositoryProvider).getAllSeries();
});

final seriesByIdProvider =
    Provider.family<SeriesModel?, String>((ref, id) {
  return ref.watch(seriesRepositoryProvider).getSeriesById(id);
});

// ─── SUBJECT PROVIDERS ───────────────────────────────────────────────────────

final allSubjectsProvider = Provider<List<SubjectModel>>((ref) {
  return ref.watch(subjectRepositoryProvider).getAllSubjects();
});

final subjectsBySeriesProvider =
    Provider.family<List<SubjectModel>, String>((ref, seriesId) {
  return ref.watch(subjectRepositoryProvider).getSubjectsBySeries(seriesId);
});

final subjectByIdProvider =
    Provider.family<SubjectModel?, String>((ref, id) {
  return ref.watch(subjectRepositoryProvider).getSubjectById(id);
});

// ─── COURSE PROVIDERS ────────────────────────────────────────────────────────

final coursesBySubjectProvider =
    Provider.family<List<CourseModel>, String>((ref, subjectId) {
  return ref.watch(courseRepositoryProvider).getCoursesBySubject(subjectId);
});

final courseByIdProvider =
    Provider.family<CourseModel?, String>((ref, id) {
  return ref.watch(courseRepositoryProvider).getCourseById(id);
});

final recentCoursesProvider = Provider<List<CourseModel>>((ref) {
  return ref.watch(courseRepositoryProvider).getRecentCourses();
});

final exercisesBySubjectProvider =
    Provider.family<List<ExerciseModel>, String>((ref, subjectId) {
  return ref.watch(courseRepositoryProvider).getExercisesBySubject(subjectId);
});

final exerciseByIdProvider =
    Provider.family<ExerciseModel?, String>((ref, id) {
  return ref.watch(courseRepositoryProvider).getExerciseById(id);
});

final bacSubjectsBySeriesProvider =
    Provider.family<List<BacSubjectModel>, String>((ref, seriesId) {
  return ref
      .watch(courseRepositoryProvider)
      .getBacSubjectsBySeries(seriesId);
});

// ─── QUIZ PROVIDERS ──────────────────────────────────────────────────────────

final allQuizzesProvider = Provider<List<QuizModel>>((ref) {
  return ref.watch(quizRepositoryProvider).getAllQuizzes();
});

final quizzesBySubjectProvider =
    Provider.family<List<QuizModel>, String>((ref, subjectId) {
  return ref.watch(quizRepositoryProvider).getQuizzesBySubject(subjectId);
});

final quizByIdProvider =
    Provider.family<QuizModel?, String>((ref, id) {
  return ref.watch(quizRepositoryProvider).getQuizById(id);
});

final quizResultsProvider = Provider<List<QuizResult>>((ref) {
  return ref.watch(quizRepositoryProvider).getAllResults();
});

final averageScoreProvider = Provider<double>((ref) {
  return ref.watch(quizRepositoryProvider).getAverageScore();
});

final totalQuizzesProvider = Provider<int>((ref) {
  return ref.watch(quizRepositoryProvider).getTotalQuizzesTaken();
});

// ─── FAVORITE PROVIDERS ──────────────────────────────────────────────────────

class FavoriteNotifier extends StateNotifier<List<FavoriteModel>> {
  final FavoriteRepository _repo;

  FavoriteNotifier(this._repo) : super(_repo.getAllFavorites());

  bool isFavorite(String itemId) => _repo.isFavorite(itemId);

  Future<void> toggle(FavoriteModel fav) async {
    await _repo.toggleFavorite(fav);
    state = _repo.getAllFavorites();
  }
}

final favoriteNotifierProvider =
    StateNotifierProvider<FavoriteNotifier, List<FavoriteModel>>((ref) {
  return FavoriteNotifier(ref.watch(favoriteRepositoryProvider));
});

// ─── STATS PROVIDERS ─────────────────────────────────────────────────────────

final overallProgressProvider = Provider<double>((ref) {
  return ref.watch(progressRepositoryProvider).getOverallProgress();
});

final totalStudyMinutesProvider = Provider<int>((ref) {
  return ref.watch(progressRepositoryProvider).getTotalStudyMinutes();
});

// ─── MOTIVATIONAL QUOTE PROVIDER ─────────────────────────────────────────────

final dailyQuoteProvider = Provider<String>((ref) {
  final random = Random(DateTime.now().day);
  final quotes = AppConstants.motivationalQuotes;
  return quotes[random.nextInt(quotes.length)];
});

// ─── SEARCH PROVIDER ─────────────────────────────────────────────────────────

class SearchNotifier extends StateNotifier<String> {
  SearchNotifier() : super('');

  void updateQuery(String query) => state = query;
  void clear() => state = '';
}

final searchQueryProvider =
    StateNotifierProvider<SearchNotifier, String>((ref) {
  return SearchNotifier();
});

final searchResultsProvider = Provider<List<dynamic>>((ref) {
  final query = ref.watch(searchQueryProvider);
  if (query.isEmpty) return [];
  return ref.watch(courseRepositoryProvider).search(query);
});

// ─── NAVIGATION INDEX PROVIDER ───────────────────────────────────────────────

final bottomNavIndexProvider = StateProvider<int>((ref) => 0);

// ─── QUIZ STATE PROVIDER ─────────────────────────────────────────────────────

class QuizStateNotifier extends StateNotifier<QuizState> {
  final QuizRepository _repo;

  QuizStateNotifier(this._repo) : super(QuizState.initial());

  void startQuiz(QuizModel quiz) {
    state = QuizState(
      quiz: quiz,
      currentIndex: 0,
      userAnswers: List.filled(quiz.questions.length, -1),
      isCompleted: false,
      startTime: DateTime.now(),
    );
  }

  void answerQuestion(int answerIndex) {
    if (state.quiz == null) return;
    final answers = [...state.userAnswers];
    answers[state.currentIndex] = answerIndex;
    state = state.copyWith(userAnswers: answers);
  }

  void nextQuestion() {
    if (state.quiz == null) return;
    if (state.currentIndex < state.quiz!.questions.length - 1) {
      state = state.copyWith(currentIndex: state.currentIndex + 1);
    } else {
      _completeQuiz();
    }
  }

  void _completeQuiz() {
    state = state.copyWith(isCompleted: true);
  }

  Future<QuizResult> saveResult(String resultId) async {
    final quiz = state.quiz!;
    int score = 0;
    int correct = 0;
    for (int i = 0; i < quiz.questions.length; i++) {
      if (state.userAnswers[i] == quiz.questions[i].correctIndex) {
        score += quiz.questions[i].points;
        correct++;
      }
    }
    final elapsed =
        DateTime.now().difference(state.startTime).inSeconds;

    final result = QuizResult(
      id: resultId,
      quizId: quiz.id,
      quizTitle: quiz.title,
      subjectId: quiz.subjectId,
      score: score,
      totalPoints: quiz.totalPoints,
      correctAnswers: correct,
      totalQuestions: quiz.questions.length,
      timeTakenSeconds: elapsed,
      completedAt: DateTime.now(),
      userAnswers: state.userAnswers,
      difficulty: quiz.difficulty,
    );

    await _repo.saveQuizResult(result);
    return result;
  }
}

class QuizState {
  final QuizModel? quiz;
  final int currentIndex;
  final List<int> userAnswers;
  final bool isCompleted;
  final DateTime startTime;

  const QuizState({
    this.quiz,
    this.currentIndex = 0,
    this.userAnswers = const [],
    this.isCompleted = false,
    required this.startTime,
  });

  factory QuizState.initial() =>
      QuizState(startTime: DateTime.now());

  QuizState copyWith({
    QuizModel? quiz,
    int? currentIndex,
    List<int>? userAnswers,
    bool? isCompleted,
  }) {
    return QuizState(
      quiz: quiz ?? this.quiz,
      currentIndex: currentIndex ?? this.currentIndex,
      userAnswers: userAnswers ?? this.userAnswers,
      isCompleted: isCompleted ?? this.isCompleted,
      startTime: startTime,
    );
  }
}

final quizStateProvider =
    StateNotifierProvider<QuizStateNotifier, QuizState>((ref) {
  return QuizStateNotifier(ref.watch(quizRepositoryProvider));
});
