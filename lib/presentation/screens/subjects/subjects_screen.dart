import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import 'package:percent_indicator/percent_indicator.dart';
import '../../../core/constants/app_colors.dart';
import '../../providers/providers.dart';
import '../../widgets/common/subject_color.dart';

class SubjectsScreen extends ConsumerWidget {
  final String seriesId;
  final String seriesName;

  const SubjectsScreen({
    super.key,
    required this.seriesId,
    required this.seriesName,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final subjects = ref.watch(subjectsBySeriesProvider(seriesId));
    final series = ref.watch(seriesByIdProvider(seriesId));

    return Scaffold(
      appBar: AppBar(title: Text(seriesName)),
      body: CustomScrollView(
        slivers: [
          if (series != null)
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
              sliver: SliverToBoxAdapter(
                child: Container(
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        series.color,
                        series.color.withOpacity(0.7),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              series.name,
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w800,
                                fontSize: 18,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              series.description,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(Iconsax.book_1, color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
            sliver: SliverToBoxAdapter(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Matières (${subjects.length})',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                  ),
                  TextButton.icon(
                    onPressed: () =>
                        context.push('/bac-subjects/$seriesId'),
                    icon: const Icon(Iconsax.document_text, size: 16),
                    label: const Text('Sujets BAC'),
                  ),
                ],
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 100),
            sliver: SliverList.builder(
              itemCount: subjects.length,
              itemBuilder: (context, i) {
                final subject = subjects[i];
                final progress = ref.watch(progressRepositoryProvider)
                    .getProgress(subject.id);
                final color = SubjectColor.forId(subject.id);

                return Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(16),
                      onTap: () => context.push(
                        '/subjects/${subject.id}',
                        extra: subject,
                      ),
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: AppColors.backgroundLight,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: AppColors.borderLight),
                          boxShadow: AppColors.cardShadow,
                        ),
                        child: Row(
                          children: [
                            CircularPercentIndicator(
                              radius: 28,
                              lineWidth: 5,
                              percent: progress.overallProgress.clamp(0, 1),
                              progressColor: color,
                              backgroundColor: color.withOpacity(0.12),
                              circularStrokeCap: CircularStrokeCap.round,
                              center: Icon(
                                SubjectColor.iconForId(subject.id),
                                color: color,
                                size: 20,
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    subject.name,
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleSmall
                                        ?.copyWith(fontWeight: FontWeight.w700),
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    subject.description,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall
                                        ?.copyWith(
                                            color:
                                                AppColors.textSecondaryLight),
                                  ),
                                  const SizedBox(height: 4),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8, vertical: 2),
                                    decoration: BoxDecoration(
                                      color: color.withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    child: Text(
                                      'Coef. ${subject.coefficient}',
                                      style: TextStyle(
                                        color: color,
                                        fontSize: 10,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const Icon(
                              Iconsax.arrow_right_3,
                              size: 18,
                              color: AppColors.textSecondaryLight,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ).animate().fadeIn(delay: (40 * i).ms).slideX(begin: 0.05);
              },
            ),
          ),
        ],
      ),
    );
  }
}
