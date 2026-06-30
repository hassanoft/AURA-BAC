import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'core/constants/app_constants.dart';
import 'data/models/series_model.dart';
import 'data/models/subject_model.dart';
import 'data/models/course_model.dart';
import 'data/models/quiz_model.dart';
import 'data/models/favorite_model.dart';
import 'data/datasources/seed_data_service.dart';
import 'app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Lock orientation to portrait for a consistent mobile experience
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  // Initialize Hive local database
  await Hive.initFlutter();

  // Register all Hive type adapters
  Hive.registerAdapter(SeriesModelAdapter());
  Hive.registerAdapter(SubjectModelAdapter());
  Hive.registerAdapter(CourseModelAdapter());
  Hive.registerAdapter(ExerciseModelAdapter());
  Hive.registerAdapter(BacSubjectModelAdapter());
  Hive.registerAdapter(QuizQuestionAdapter());
  Hive.registerAdapter(QuizModelAdapter());
  Hive.registerAdapter(QuizResultAdapter());
  Hive.registerAdapter(StudySessionAdapter());
  Hive.registerAdapter(FavoriteModelAdapter());
  Hive.registerAdapter(ProgressModelAdapter());

  // Open all Hive boxes
  await Hive.openBox(AppConstants.subjectsBox);
  await Hive.openBox(AppConstants.coursesBox);
  await Hive.openBox<QuizModel>(AppConstants.quizzesBox);
  await Hive.openBox<QuizResult>(AppConstants.quizResultsBox);
  await Hive.openBox<FavoriteModel>(AppConstants.favoritesBox);
  await Hive.openBox<ProgressModel>(AppConstants.progressBox);
  await Hive.openBox(AppConstants.settingsBox);
  await Hive.openBox<StudySession>(AppConstants.studySessionsBox);

  // Seed initial sample data on first launch
  await SeedDataService.seedIfNeeded();

  runApp(
    const ProviderScope(
      child: AuraApp(),
    ),
  );
}
