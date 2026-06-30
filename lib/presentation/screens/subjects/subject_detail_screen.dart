import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import '../../../core/constants/app_colors.dart';
import '../../providers/providers.dart';
import '../../widgets/common/common_widgets.dart';
import '../../widgets/common/subject_color.dart';

class SubjectDetailScreen extends ConsumerWidget {
  final String subjectId;

  const SubjectDetailScreen({super.key, required this.subjectId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final subject = ref.watch(subjectByIdProvider(subjectId));
    final courses = ref.watch(coursesBySubjectProvider(subjectId));
    final exercises = ref.watch(exercisesBySubjectProvider(subjectId));
    final quizzes = ref.watch(quizzesBySubjectProvider(subjectId));
    final color = SubjectColor.forId(subjectId);

    if (subject == null) {
      return const Scaffold(body: Center(child: Text('Matière introuvable')));
    }

    return DefaultTabController(
      length: 4,
      child: Scaffold(
        body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) => [
            SliverAppBar(
              pinned: true,
              expandedHeight: 140,
              backgroundColor: color,
              foregroundColor: Colors.white,
              iconTheme: const IconThemeData(color: Colors.white),
              flexibleSpace: FlexibleSpaceBar(
                titlePadding: const EdgeInsets.only(left: 56, bottom: 16),
                title: Text(
                  subject.name,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                  ),
                ),
                background: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [color, color.withOpacity(0.7)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 16, bottom: 50),
                      child: Icon(
                        SubjectColor.iconForId(subjectId),
                        color: Colors.white24,
                        size: 64,
                      ),
                    ),
                  ),
                ),
              ),
              bottom: TabBar(
                isScrollable: true,
                labelColor: Colors.white,
                unselectedLabelColor: Colors.white70,
                indicatorColor: Colors.white,
                tabs: const [
                  Tab(text: 'Cours'),
                  Tab(text: 'Exercices'),
                  Tab(text: 'Quiz'),
                  Tab(text: 'Conseils'),
                ],
              ),
            ),
          ],
          body: TabBarView(
            children: [
              _CoursesTab(courses: courses),
              _ExercisesTab(exercises: exercises),
              _QuizzesTab(quizzes: quizzes),
              _TipsTab(subjectId: subjectId),
            ],
          ),
        ),
      ),
    );
  }
}

class _CoursesTab extends StatelessWidget {
  final List<dynamic> courses;
  const _CoursesTab({required this.courses});

  @override
  Widget build(BuildContext context) {
    if (courses.isEmpty) {
      return const EmptyState(
        icon: Iconsax.book,
        title: 'Aucun cours disponible',
        subtitle: 'Les cours pour cette matière arrivent bientôt.',
      );
    }
    return ListView.builder(
      padding: const EdgeInsets.all(20),
      itemCount: courses.length,
      itemBuilder: (context, i) {
        final course = courses[i];
        return AuraCard(
          onTap: () => context.push('/courses/${course.id}'),
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: AppColors.primaryContainer,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Text(
                    '${course.orderIndex}',
                    style: const TextStyle(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      course.title,
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      course.chapter,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: AppColors.textSecondaryLight,
                          ),
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        DifficultyBadge(difficulty: course.difficulty),
                        const SizedBox(width: 8),
                        Icon(Iconsax.clock,
                            size: 12, color: AppColors.textSecondaryLight),
                        const SizedBox(width: 4),
                        Text(
                          '${course.estimatedMinutes} min',
                          style: const TextStyle(
                            fontSize: 11,
                            color: AppColors.textSecondaryLight,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              if (course.isCompleted)
                const Icon(Iconsax.tick_circle5,
                    color: AppColors.success, size: 20)
              else
                const Icon(Iconsax.arrow_right_3,
                    size: 16, color: AppColors.textSecondaryLight),
            ],
          ),
        );
      },
    );
  }
}

class _ExercisesTab extends StatelessWidget {
  final List<dynamic> exercises;
  const _ExercisesTab({required this.exercises});

  @override
  Widget build(BuildContext context) {
    if (exercises.isEmpty) {
      return const EmptyState(
        icon: Iconsax.edit,
        title: 'Aucun exercice disponible',
        subtitle: 'Les exercices pour cette matière arrivent bientôt.',
      );
    }
    return ListView.builder(
      padding: const EdgeInsets.all(20),
      itemCount: exercises.length,
      itemBuilder: (context, i) {
        final ex = exercises[i];
        return AuraCard(
          onTap: () => context.push('/exercises/${ex.id}'),
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: AppColors.secondaryContainer,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(Iconsax.edit_2,
                    color: AppColors.secondary, size: 18),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      ex.title,
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        DifficultyBadge(difficulty: ex.difficulty),
                        const SizedBox(width: 8),
                        Text(
                          '${ex.points} pts',
                          style: const TextStyle(
                            fontSize: 11,
                            color: AppColors.textSecondaryLight,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const Icon(Iconsax.arrow_right_3,
                  size: 16, color: AppColors.textSecondaryLight),
            ],
          ),
        );
      },
    );
  }
}

class _QuizzesTab extends ConsumerWidget {
  final List<dynamic> quizzes;
  const _QuizzesTab({required this.quizzes});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (quizzes.isEmpty) {
      return const EmptyState(
        icon: Iconsax.teacher,
        title: 'Aucun quiz disponible',
        subtitle: 'Les quiz pour cette matière arrivent bientôt.',
      );
    }
    return ListView.builder(
      padding: const EdgeInsets.all(20),
      itemCount: quizzes.length,
      itemBuilder: (context, i) {
        final quiz = quizzes[i];
        return AuraCard(
          onTap: () => context.push('/quiz/play/${quiz.id}'),
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: AppColors.accentContainer,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(Iconsax.teacher,
                    color: AppColors.accent, size: 18),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      quiz.title,
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      '${quiz.questions.length} questions',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: AppColors.textSecondaryLight,
                          ),
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        DifficultyBadge(difficulty: quiz.difficulty),
                        if (quiz.bestScore > 0) ...[
                          const SizedBox(width: 8),
                          Icon(Iconsax.award5,
                              size: 12, color: AppColors.accent),
                          const SizedBox(width: 2),
                          Text(
                            '${quiz.bestScore.toStringAsFixed(0)}%',
                            style: const TextStyle(
                              fontSize: 11,
                              color: AppColors.accent,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ],
                ),
              ),
              const Icon(Iconsax.play_circle,
                  size: 24, color: AppColors.primary),
            ],
          ),
        );
      },
    );
  }
}

class _TipsTab extends StatelessWidget {
  final String subjectId;
  const _TipsTab({required this.subjectId});

  @override
  Widget build(BuildContext context) {
    final tips = _getTipsForSubject(subjectId);
    return ListView.builder(
      padding: const EdgeInsets.all(20),
      itemCount: tips.length,
      itemBuilder: (context, i) {
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.accentContainer,
            borderRadius: BorderRadius.circular(14),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(Iconsax.lamp_on, color: AppColors.accentDark, size: 20),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  tips[i],
                  style: const TextStyle(
                    color: AppColors.accentDark,
                    fontWeight: FontWeight.w500,
                    height: 1.5,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  List<String> _getTipsForSubject(String subjectId) => [
    'Révisez régulièrement plutôt qu\'intensément la veille de l\'examen.',
    'Faites des fiches de synthèse pour chaque chapitre.',
    'Entraînez-vous sur des sujets BAC des années précédentes.',
    'Identifiez vos points faibles et concentrez-vous dessus.',
    'Travaillez en groupe pour échanger sur les notions difficiles.',
    'Gérez bien votre temps le jour de l\'examen.',
  ];
}
