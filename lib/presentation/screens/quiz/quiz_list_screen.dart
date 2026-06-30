import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import '../../../core/constants/app_colors.dart';
import '../../providers/providers.dart';
import '../../widgets/common/common_widgets.dart';
import '../../widgets/common/subject_color.dart';

class QuizListScreen extends ConsumerStatefulWidget {
  const QuizListScreen({super.key});

  @override
  ConsumerState<QuizListScreen> createState() => _QuizListScreenState();
}

class _QuizListScreenState extends ConsumerState<QuizListScreen> {
  String _selectedDifficulty = 'Tous';
  final List<String> _difficulties = ['Tous', 'Facile', 'Moyen', 'Difficile'];

  @override
  Widget build(BuildContext context) {
    final allQuizzes = ref.watch(allQuizzesProvider);
    final filtered = _selectedDifficulty == 'Tous'
        ? allQuizzes
        : allQuizzes.where((q) => q.difficulty == _selectedDifficulty).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Quiz'),
        actions: [
          IconButton(
            onPressed: () => context.push('/favorites'),
            icon: const Icon(Iconsax.chart),
            tooltip: 'Historique',
          ),
        ],
      ),
      body: Column(
        children: [
          SizedBox(
            height: 44,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
              itemCount: _difficulties.length,
              separatorBuilder: (_, __) => const SizedBox(width: 8),
              itemBuilder: (context, i) {
                final diff = _difficulties[i];
                final isSelected = diff == _selectedDifficulty;
                return ChoiceChip(
                  label: Text(diff),
                  selected: isSelected,
                  onSelected: (_) =>
                      setState(() => _selectedDifficulty = diff),
                  selectedColor: AppColors.primaryContainer,
                  labelStyle: TextStyle(
                    color: isSelected
                        ? AppColors.primary
                        : AppColors.textSecondaryLight,
                    fontWeight: FontWeight.w600,
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: filtered.isEmpty
                ? const EmptyState(
                    icon: Iconsax.teacher,
                    title: 'Aucun quiz trouvé',
                    subtitle: 'Essayez un autre niveau de difficulté.',
                  )
                : ListView.builder(
                    padding: const EdgeInsets.fromLTRB(20, 8, 20, 100),
                    itemCount: filtered.length,
                    itemBuilder: (context, i) {
                      final quiz = filtered[i];
                      final color = SubjectColor.forId(quiz.subjectId);
                      return Container(
                        margin: const EdgeInsets.only(bottom: 12),
                        child: AuraCard(
                          onTap: () => context.push('/quiz/play/${quiz.id}'),
                          child: Row(
                            children: [
                              Container(
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(
                                  color: color.withOpacity(0.12),
                                  borderRadius: BorderRadius.circular(14),
                                ),
                                child: Icon(
                                  SubjectColor.iconForId(quiz.subjectId),
                                  color: color,
                                ),
                              ),
                              const SizedBox(width: 14),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      quiz.title,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleSmall
                                          ?.copyWith(
                                              fontWeight: FontWeight.w700),
                                    ),
                                    const SizedBox(height: 2),
                                    Text(
                                      quiz.description,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall
                                          ?.copyWith(
                                              color: AppColors
                                                  .textSecondaryLight),
                                    ),
                                    const SizedBox(height: 8),
                                    Row(
                                      children: [
                                        DifficultyBadge(
                                            difficulty: quiz.difficulty),
                                        const SizedBox(width: 8),
                                        Icon(Iconsax.message_question,
                                            size: 12,
                                            color: AppColors
                                                .textSecondaryLight),
                                        const SizedBox(width: 2),
                                        Text(
                                          '${quiz.questions.length}',
                                          style: const TextStyle(
                                            fontSize: 11,
                                            color:
                                                AppColors.textSecondaryLight,
                                          ),
                                        ),
                                        const SizedBox(width: 8),
                                        Icon(Iconsax.timer,
                                            size: 12,
                                            color: AppColors
                                                .textSecondaryLight),
                                        const SizedBox(width: 2),
                                        Text(
                                          '${quiz.timeLimitSeconds}s',
                                          style: const TextStyle(
                                            fontSize: 11,
                                            color:
                                                AppColors.textSecondaryLight,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.all(10),
                                decoration: const BoxDecoration(
                                  color: AppColors.primary,
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
                                  Iconsax.play5,
                                  color: Colors.white,
                                  size: 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ).animate().fadeIn(delay: (40 * i).ms);
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
