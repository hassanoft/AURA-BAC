import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import 'package:percent_indicator/percent_indicator.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/router/app_router.dart';
import '../../../data/models/quiz_model.dart';

class QuizResultScreen extends StatelessWidget {
  final QuizResult? result;
  const QuizResultScreen({super.key, required this.result});

  Color get _gradeColor {
    if (result == null) return AppColors.primary;
    if (result!.percentage >= 75) return AppColors.success;
    if (result!.percentage >= 50) return AppColors.accent;
    return AppColors.error;
  }

  @override
  Widget build(BuildContext context) {
    if (result == null) {
      return Scaffold(
        body: Center(
          child: ElevatedButton(
            onPressed: () => context.go(AppRoutes.home),
            child: const Text('Retour à l\'accueil'),
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: AppColors.surfaceLight,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              const SizedBox(height: 20),
              Text(
                result!.percentage >= 50 ? '🎉 Bravo !' : '💪 Continuez !',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.w800,
                    ),
              ).animate().fadeIn().scale(delay: 100.ms),

              const SizedBox(height: 8),
              Text(
                result!.quizTitle,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppColors.textSecondaryLight,
                    ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 32),

              CircularPercentIndicator(
                radius: 90,
                lineWidth: 16,
                percent: (result!.percentage / 100).clamp(0, 1),
                animation: true,
                animationDuration: 1200,
                circularStrokeCap: CircularStrokeCap.round,
                backgroundColor: AppColors.borderLight,
                progressColor: _gradeColor,
                center: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      '${result!.percentage.toStringAsFixed(0)}%',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.w800,
                        color: _gradeColor,
                      ),
                    ),
                    Text(
                      result!.grade,
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: _gradeColor,
                      ),
                    ),
                  ],
                ),
              ).animate().fadeIn(delay: 200.ms).scale(),

              const SizedBox(height: 32),

              Row(
                children: [
                  Expanded(
                    child: _ResultStatCard(
                      icon: Iconsax.tick_circle,
                      label: 'Correctes',
                      value: '${result!.correctAnswers}/${result!.totalQuestions}',
                      color: AppColors.success,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _ResultStatCard(
                      icon: Iconsax.medal_star,
                      label: 'Points',
                      value: '${result!.score}/${result!.totalPoints}',
                      color: AppColors.accent,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _ResultStatCard(
                      icon: Iconsax.timer,
                      label: 'Temps',
                      value: '${result!.timeTakenSeconds}s',
                      color: AppColors.primary,
                    ),
                  ),
                ],
              ).animate().fadeIn(delay: 300.ms),

              const Spacer(),

              SizedBox(
                width: double.infinity,
                child: FilledButton.icon(
                  onPressed: () => context
                      .pushReplacement('/quiz/play/${result!.quizId}'),
                  icon: const Icon(Iconsax.refresh),
                  label: const Text('Réessayer'),
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () => context.go(AppRoutes.home),
                  child: const Text('Retour à l\'accueil'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ResultStatCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color color;

  const _ResultStatCard({
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
      decoration: BoxDecoration(
        color: AppColors.backgroundLight,
        borderRadius: BorderRadius.circular(14),
        boxShadow: AppColors.cardShadow,
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 20),
          const SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              fontWeight: FontWeight.w800,
              fontSize: 15,
              color: color,
            ),
          ),
          Text(
            label,
            style: const TextStyle(
              fontSize: 11,
              color: AppColors.textSecondaryLight,
            ),
          ),
        ],
      ),
    );
  }
}
