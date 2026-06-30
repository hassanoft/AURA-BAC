import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax/iconsax.dart';
import '../../../core/constants/app_colors.dart';
import '../../providers/providers.dart';
import '../../widgets/common/common_widgets.dart';

class ExerciseDetailScreen extends ConsumerStatefulWidget {
  final String exerciseId;
  const ExerciseDetailScreen({super.key, required this.exerciseId});

  @override
  ConsumerState<ExerciseDetailScreen> createState() =>
      _ExerciseDetailScreenState();
}

class _ExerciseDetailScreenState extends ConsumerState<ExerciseDetailScreen> {
  bool _showSolution = false;

  @override
  Widget build(BuildContext context) {
    final exercise = ref.watch(exerciseByIdProvider(widget.exerciseId));
    if (exercise == null) {
      return const Scaffold(body: Center(child: Text('Exercice introuvable')));
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Exercice')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Text(
            exercise.title,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w800,
                ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              DifficultyBadge(difficulty: exercise.difficulty),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.primaryContainer,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  '${exercise.points} points',
                  style: const TextStyle(
                    color: AppColors.primary,
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // Statement
          AuraCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(Iconsax.document_text,
                        color: AppColors.primary, size: 18),
                    const SizedBox(width: 8),
                    Text(
                      'Énoncé',
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  exercise.statement,
                  style: const TextStyle(height: 1.6, fontSize: 14),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // Steps
          if (exercise.steps.isNotEmpty) ...[
            Text(
              'Méthode suggérée',
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
            ),
            const SizedBox(height: 10),
            ...List.generate(exercise.steps.length, (i) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 24,
                      height: 24,
                      decoration: const BoxDecoration(
                        color: AppColors.secondary,
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Text(
                          '${i + 1}',
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        exercise.steps[i],
                        style: const TextStyle(height: 1.4),
                      ),
                    ),
                  ],
                ),
              );
            }),
            const SizedBox(height: 16),
          ],

          // Solution toggle
          SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              onPressed: () => setState(() => _showSolution = !_showSolution),
              icon: Icon(_showSolution ? Iconsax.eye_slash : Iconsax.eye),
              label: Text(_showSolution
                  ? 'Masquer la correction'
                  : 'Afficher la correction'),
            ),
          ),

          if (_showSolution) ...[
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.successLight,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: AppColors.success.withOpacity(0.3)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Iconsax.tick_circle,
                          color: AppColors.success, size: 18),
                      const SizedBox(width: 8),
                      Text(
                        'Correction détaillée',
                        style: Theme.of(context)
                            .textTheme
                            .titleSmall
                            ?.copyWith(
                                fontWeight: FontWeight.w700,
                                color: AppColors.success),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(
                    exercise.solution,
                    style: const TextStyle(height: 1.6, fontSize: 14),
                  ),
                ],
              ),
            ),
          ],

          const SizedBox(height: 40),
        ],
      ),
    );
  }
}
