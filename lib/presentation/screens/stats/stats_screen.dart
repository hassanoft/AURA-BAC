import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax/iconsax.dart';
import 'package:percent_indicator/percent_indicator.dart';
import '../../../core/constants/app_colors.dart';
import '../../providers/providers.dart';
import '../../widgets/common/common_widgets.dart';
import '../../widgets/common/subject_color.dart';

class StatsScreen extends ConsumerWidget {
  const StatsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final results = ref.watch(quizResultsProvider);
    final averageScore = ref.watch(averageScoreProvider);
    final totalQuizzes = ref.watch(totalQuizzesProvider);
    final allSubjects = ref.watch(allSubjectsProvider);
    final progressRepo = ref.watch(progressRepositoryProvider);

    final totalMinutes = ref.watch(quizRepositoryProvider).getTotalTimeTaken() ~/ 60;

    return Scaffold(
      appBar: AppBar(title: const Text('Statistiques')),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 100),
        children: [
          // Top stats grid
          Row(
            children: [
              Expanded(
                child: _BigStatCard(
                  icon: Iconsax.award,
                  label: 'Moyenne Générale',
                  value: '${averageScore.toStringAsFixed(0)}%',
                  color: AppColors.primary,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _BigStatCard(
                  icon: Iconsax.teacher,
                  label: 'Quiz Réalisés',
                  value: '$totalQuizzes',
                  color: AppColors.secondary,
                ),
              ),
            ],
          ).animate().fadeIn(),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _BigStatCard(
                  icon: Iconsax.timer_1,
                  label: 'Temps de Travail',
                  value: '${totalMinutes}min',
                  color: AppColors.accent,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _BigStatCard(
                  icon: Iconsax.chart_success,
                  label: 'Progression',
                  value: '${(ref.watch(overallProgressProvider) * 100).toStringAsFixed(0)}%',
                  color: AppColors.success,
                ),
              ),
            ],
          ).animate().fadeIn(delay: 100.ms),

          const SizedBox(height: 28),

          // Score Evolution Chart
          if (results.length >= 2) ...[
            const SectionTitle(title: 'Évolution des Scores'),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.fromLTRB(8, 20, 20, 8),
              height: 220,
              decoration: BoxDecoration(
                color: AppColors.backgroundLight,
                borderRadius: BorderRadius.circular(18),
                boxShadow: AppColors.cardShadow,
              ),
              child: LineChart(
                LineChartData(
                  gridData: const FlGridData(show: false),
                  titlesData: FlTitlesData(
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 32,
                        interval: 25,
                        getTitlesWidget: (value, meta) => Text(
                          '${value.toInt()}%',
                          style: const TextStyle(
                            fontSize: 10,
                            color: AppColors.textSecondaryLight,
                          ),
                        ),
                      ),
                    ),
                    rightTitles: const AxisTitles(
                        sideTitles: SideTitles(showTitles: false)),
                    topTitles: const AxisTitles(
                        sideTitles: SideTitles(showTitles: false)),
                    bottomTitles: const AxisTitles(
                        sideTitles: SideTitles(showTitles: false)),
                  ),
                  borderData: FlBorderData(show: false),
                  minY: 0,
                  maxY: 100,
                  lineBarsData: [
                    LineChartBarData(
                      spots: results
                          .take(10)
                          .toList()
                          .reversed
                          .toList()
                          .asMap()
                          .entries
                          .map((e) =>
                              FlSpot(e.key.toDouble(), (e.value as dynamic).percentage))
                          .toList(),
                      isCurved: true,
                      color: AppColors.primary,
                      barWidth: 3,
                      dotData: const FlDotData(show: true),
                      belowBarData: BarAreaData(
                        show: true,
                        color: AppColors.primary.withOpacity(0.1),
                      ),
                    ),
                  ],
                ),
              ),
            ).animate().fadeIn(delay: 150.ms),
            const SizedBox(height: 28),
          ],

          // Subject progress bars
          const SectionTitle(title: 'Progression par Matière'),
          const SizedBox(height: 12),
          ...allSubjects.take(8).map((subject) {
            final typedSubject = subject as dynamic;
            final progress = progressRepo.getProgress(typedSubject.id);
            final color = SubjectColor.forId(typedSubject.id);
            return Container(
              margin: const EdgeInsets.only(bottom: 14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(SubjectColor.iconForId(typedSubject.id),
                          size: 16, color: color),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          typedSubject.name ?? 'Matière',
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                        ),
                      ),
                      Text(
                        '${(progress.overallProgress * 100).toStringAsFixed(0)}%',
                        style: TextStyle(
                          color: color,
                          fontWeight: FontWeight.w700,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  LinearPercentIndicator(
                    lineHeight: 8,
                    percent: progress.overallProgress.clamp(0, 1),
                    backgroundColor: AppColors.borderLight,
                    progressColor: color,
                    barRadius: const Radius.circular(8),
                    padding: EdgeInsets.zero,
                  ),
                ],
              ),
            );
          }),

          const SizedBox(height: 28),

          // Recent results list
          const SectionTitle(title: 'Historique Récent'),
          const SizedBox(height: 12),
          if (results.isEmpty)
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: EmptyState(
                icon: Iconsax.chart,
                title: 'Aucun quiz réalisé',
                subtitle: 'Faites un quiz pour voir vos statistiques ici.',
              ),
            )
          else
            ...results.take(10).map((result) {
              final typedResult = result as dynamic;
              final percentage = (typedResult.percentage as num?)?.toDouble() ?? 0;
              final color = percentage >= 50
                  ? AppColors.success
                  : AppColors.error;
              return Container(
                margin: const EdgeInsets.only(bottom: 10),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: AppColors.backgroundLight,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: AppColors.borderLight),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: color.withOpacity(0.12),
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Text(
                          '${percentage.toStringAsFixed(0)}%',
                          style: TextStyle(
                            color: color,
                            fontWeight: FontWeight.w800,
                            fontSize: 11,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            typedResult.quizTitle ?? 'Quiz',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(fontWeight: FontWeight.w600),
                          ),
                          Text(
                            'Score : ${percentage.toStringAsFixed(0)}%',
                            style: const TextStyle(
                              fontSize: 11,
                              color: AppColors.textSecondaryLight,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }),
        ],
      ),
    );
  }
}

class _BigStatCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color color;

  const _BigStatCard({
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColors.backgroundLight,
        borderRadius: BorderRadius.circular(18),
        boxShadow: AppColors.cardShadow,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: color.withOpacity(0.12),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: color, size: 20),
          ),
          const SizedBox(height: 12),
          Text(
            value,
            style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 24),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              color: AppColors.textSecondaryLight,
            ),
          ),
        ],
      ),
    );
  }
}