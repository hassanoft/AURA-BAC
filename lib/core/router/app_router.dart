import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../presentation/screens/home/home_screen.dart';
import '../../presentation/screens/series/series_screen.dart';
import '../../presentation/screens/subjects/subject_detail_screen.dart';
import '../../presentation/screens/subjects/course_detail_screen.dart';
import '../../presentation/screens/quiz/quiz_list_screen.dart';
import '../../presentation/screens/quiz/quiz_play_screen.dart';
import '../../presentation/screens/quiz/quiz_result_screen.dart';
import '../../presentation/screens/stats/stats_screen.dart';
import '../../presentation/screens/favorites/favorites_screen.dart';
import '../../presentation/screens/search/search_screen.dart';
import '../../presentation/screens/settings/settings_screen.dart';
import '../../presentation/screens/home/main_shell_screen.dart';
import '../../presentation/screens/subjects/subjects_screen.dart';
import '../../presentation/screens/subjects/exercise_detail_screen.dart';
import '../../presentation/screens/subjects/bac_subjects_screen.dart';
import '../../data/models/quiz_model.dart';

/// Application route names
class AppRoutes {
  AppRoutes._();

  static const String home = '/';
  static const String series = '/series';
  static const String subjects = '/subjects';
  static const String subjectDetail = '/subjects/:id';
  static const String courseDetail = '/courses/:id';
  static const String exerciseDetail = '/exercises/:id';
  static const String bacSubjects = '/bac-subjects/:seriesId';
  static const String quizList = '/quiz';
  static const String quizPlay = '/quiz/play/:id';
  static const String quizResult = '/quiz/result';
  static const String stats = '/stats';
  static const String favorites = '/favorites';
  static const String search = '/search';
  static const String settings = '/settings';
}

/// Main application router configuration
final GoRouter appRouter = GoRouter(
  initialLocation: AppRoutes.home,
  debugLogDiagnostics: false,
  routes: [
    // Main shell with bottom navigation
    ShellRoute(
      builder: (context, state, child) => MainShellScreen(child: child),
      routes: [
        GoRoute(
          path: AppRoutes.home,
          pageBuilder: (context, state) => const NoTransitionPage(
            child: HomeScreen(),
          ),
        ),
        GoRoute(
          path: AppRoutes.series,
          pageBuilder: (context, state) => const NoTransitionPage(
            child: SeriesScreen(),
          ),
        ),
        GoRoute(
          path: AppRoutes.quizList,
          pageBuilder: (context, state) => const NoTransitionPage(
            child: QuizListScreen(),
          ),
        ),
        GoRoute(
          path: AppRoutes.stats,
          pageBuilder: (context, state) => const NoTransitionPage(
            child: StatsScreen(),
          ),
        ),
        GoRoute(
          path: AppRoutes.favorites,
          pageBuilder: (context, state) => const NoTransitionPage(
            child: FavoritesScreen(),
          ),
        ),
      ],
    ),

    // Full-screen routes (no bottom nav)
    GoRoute(
      path: AppRoutes.search,
      pageBuilder: (context, state) => _slideTransitionPage(
        const SearchScreen(),
        state,
      ),
    ),
    GoRoute(
      path: AppRoutes.settings,
      pageBuilder: (context, state) => _slideTransitionPage(
        const SettingsScreen(),
        state,
      ),
    ),
    GoRoute(
      path: '/subjects/:seriesId',
      pageBuilder: (context, state) {
        final seriesId = state.pathParameters['seriesId'] ?? '';
        final seriesName = state.uri.queryParameters['name'] ?? seriesId;
        return _slideTransitionPage(
          SubjectsScreen(seriesId: seriesId, seriesName: seriesName),
          state,
        );
      },
    ),
    GoRoute(
      path: AppRoutes.subjectDetail,
      pageBuilder: (context, state) {
        final id = state.pathParameters['id'] ?? '';
        return _slideTransitionPage(
          SubjectDetailScreen(subjectId: id),
          state,
        );
      },
    ),
    GoRoute(
      path: AppRoutes.courseDetail,
      pageBuilder: (context, state) {
        final id = state.pathParameters['id'] ?? '';
        return _slideTransitionPage(
          CourseDetailScreen(courseId: id),
          state,
        );
      },
    ),
    GoRoute(
      path: AppRoutes.exerciseDetail,
      pageBuilder: (context, state) {
        final id = state.pathParameters['id'] ?? '';
        return _slideTransitionPage(
          ExerciseDetailScreen(exerciseId: id),
          state,
        );
      },
    ),
    GoRoute(
      path: '/bac-subjects/:seriesId',
      pageBuilder: (context, state) {
        final seriesId = state.pathParameters['seriesId'] ?? '';
        return _slideTransitionPage(
          BacSubjectsScreen(seriesId: seriesId),
          state,
        );
      },
    ),
    GoRoute(
      path: '/quiz/play/:id',
      pageBuilder: (context, state) {
        final id = state.pathParameters['id'] ?? '';
        return _fadeTransitionPage(
          QuizPlayScreen(quizId: id),
          state,
        );
      },
    ),
    GoRoute(
      path: AppRoutes.quizResult,
      pageBuilder: (context, state) {
        final result = state.extra as QuizResult?;
        return _fadeTransitionPage(
          QuizResultScreen(result: result),
          state,
        );
      },
    ),
  ],

  errorBuilder: (context, state) => Scaffold(
    body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error_outline, size: 64, color: Colors.red),
          const SizedBox(height: 16),
          Text('Page introuvable', style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: 8),
          Text(state.error.toString()),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () => context.go(AppRoutes.home),
            child: const Text('Retour à l\'accueil'),
          ),
        ],
      ),
    ),
  ),
);

/// Slide transition from right
CustomTransitionPage _slideTransitionPage(Widget child, GoRouterState state) {
  return CustomTransitionPage(
    key: state.pageKey,
    child: child,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      final tween = Tween(
        begin: const Offset(1.0, 0.0),
        end: Offset.zero,
      ).chain(CurveTween(curve: Curves.easeInOutCubic));
      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}

/// Fade transition
CustomTransitionPage _fadeTransitionPage(Widget child, GoRouterState state) {
  return CustomTransitionPage(
    key: state.pageKey,
    child: child,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return FadeTransition(opacity: animation, child: child);
    },
  );
}
