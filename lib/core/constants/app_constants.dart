/// Application-wide constants for AURA BAC
library;

class AppConstants {
  AppConstants._();

  // App Info
  static const String appName = 'AURA';
  static const String appSlogan = 'Réussis ton BAC avec confiance.';
  static const String appVersion = '1.0.0';
  static const String appBuildNumber = '1';
  static const String developerName = 'AURA Team';
  static const String contactEmail = 'contact@aura-bac.ci';

  // Hive Box Names
  static const String subjectsBox = 'subjects_box';
  static const String coursesBox = 'courses_box';
  static const String quizzesBox = 'quizzes_box';
  static const String quizResultsBox = 'quiz_results_box';
  static const String favoritesBox = 'favorites_box';
  static const String progressBox = 'progress_box';
  static const String settingsBox = 'settings_box';
  static const String studySessionsBox = 'study_sessions_box';

  // Shared Preferences Keys
  static const String prefThemeMode = 'theme_mode';
  static const String prefLanguage = 'language';
  static const String prefFirstLaunch = 'first_launch';
  static const String prefOnboardingDone = 'onboarding_done';
  static const String prefTotalStudyTime = 'total_study_time';

  // Hive Type IDs
  static const int seriesTypeId = 0;
  static const int subjectTypeId = 1;
  static const int courseTypeId = 2;
  static const int quizTypeId = 3;
  static const int questionTypeId = 4;
  static const int quizResultTypeId = 5;
  static const int favoriteTypeId = 6;
  static const int progressTypeId = 7;
  static const int studySessionTypeId = 8;
  static const int exerciseTypeId = 9;
  static const int bacSubjectTypeId = 10;

  // BAC Series
  static const List<String> bacSeries = [
    'A1', 'A2', 'C', 'D', 'G1', 'G2', 'F1', 'F2', 'F3'
  ];

  // Difficulty Levels
  static const String difficultyEasy = 'Facile';
  static const String difficultyMedium = 'Moyen';
  static const String difficultyHard = 'Difficile';

  // Quiz Settings
  static const int quizDefaultTimeSeconds = 30;
  static const int quizDefaultQuestionCount = 10;

  // Animation Durations
  static const Duration animFast = Duration(milliseconds: 200);
  static const Duration animNormal = Duration(milliseconds: 350);
  static const Duration animSlow = Duration(milliseconds: 600);

  // Motivational Quotes
  static const List<String> motivationalQuotes = [
    'Le succès n\'est pas final, l\'échec n\'est pas fatal : c\'est le courage de continuer qui compte.',
    'L\'éducation est l\'arme la plus puissante pour changer le monde.',
    'Chaque expert a été un débutant un jour. Continuez à apprendre.',
    'Le travail d\'aujourd\'hui est le succès de demain.',
    'Croyez en vous-même et en votre capacité à réussir.',
    'La persévérance est la clé du succès au BAC.',
    'Chaque heure d\'étude vous rapproche de votre objectif.',
    'Votre avenir dépend de ce que vous faites aujourd\'hui.',
    'La discipline est la meilleure amie du succès.',
    'N\'abandonnez jamais vos rêves. Le BAC est votre premier grand pas.',
    'L\'intelligence, c\'est la capacité de s\'adapter au changement.',
    'La réussite appartient à ceux qui n\'abandonnent pas.',
    'Chaque matière maîtrisée est une victoire de plus.',
    'Votre potentiel est illimité. Travaillez avec passion.',
    'Le BAC n\'est pas une fin, c\'est un début.',
  ];
}
