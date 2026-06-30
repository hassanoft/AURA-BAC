import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import '../../../core/constants/app_colors.dart';
import '../../providers/providers.dart';
import '../../../data/models/series_model.dart';

class SeriesScreen extends ConsumerWidget {
  const SeriesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final allSeries = ref.watch(allSeriesProvider);
    final categories = ['Littéraire', 'Scientifique', 'Commercial', 'Technique'];

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            floating: true,
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            elevation: 0,
            title: const Text('Séries BAC'),
          ),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 0),
            sliver: SliverToBoxAdapter(
              child: Text(
                'Choisissez votre série pour accéder aux matières et contenus adaptés.',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppColors.textSecondaryLight,
                    ),
              ),
            ),
          ),
          for (final category in categories) ...[
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 12),
              sliver: SliverToBoxAdapter(
                child: Text(
                  category,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              sliver: SliverList.builder(
                itemCount: allSeries
                    .where((s) => s.category == category)
                    .length,
                itemBuilder: (context, i) {
                  final series = allSeries
                      .where((s) => s.category == category)
                      .toList()[i];
                  return _SeriesCard(series: series)
                      .animate()
                      .fadeIn(delay: (50 * i).ms)
                      .slideX(begin: 0.05);
                },
              ),
            ),
          ],
          const SliverToBoxAdapter(child: SizedBox(height: 100)),
        ],
      ),
    );
  }
}

class _SeriesCard extends StatelessWidget {
  final SeriesModel series;
  const _SeriesCard({required this.series});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(18),
          onTap: () => context.push(
            '/subjects/${series.id}?name=${Uri.encodeComponent(series.name)}',
          ),
          child: Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: AppColors.backgroundLight,
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: AppColors.borderLight),
              boxShadow: AppColors.cardShadow,
            ),
            child: Row(
              children: [
                Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    color: series.color.withOpacity(0.12),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Center(
                    child: Text(
                      series.id,
                      style: TextStyle(
                        color: series.color,
                        fontWeight: FontWeight.w800,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        series.name,
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.w700,
                            ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        series.description,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: AppColors.textSecondaryLight,
                            ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        '${series.subjectIds.length} matières',
                        style: TextStyle(
                          color: series.color,
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
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
    );
  }
}
