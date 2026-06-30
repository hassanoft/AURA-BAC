import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax/iconsax.dart';
import '../../../core/constants/app_colors.dart';
import '../../providers/providers.dart';
import '../../widgets/common/common_widgets.dart';
import '../../widgets/common/subject_color.dart';

class BacSubjectsScreen extends ConsumerWidget {
  final String seriesId;
  const BacSubjectsScreen({super.key, required this.seriesId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bacSubjects = ref.watch(bacSubjectsBySeriesProvider(seriesId));

    return Scaffold(
      appBar: AppBar(title: Text('Sujets BAC – Série $seriesId')),
      body: bacSubjects.isEmpty
          ? const EmptyState(
              icon: Iconsax.document_text,
              title: 'Aucun sujet disponible',
              subtitle: 'Les sujets BAC pour cette série arrivent bientôt.',
            )
          : ListView.builder(
              padding: const EdgeInsets.all(20),
              itemCount: bacSubjects.length,
              itemBuilder: (context, i) {
                final subject = bacSubjects[i];
                final color = SubjectColor.forId(subject.subjectId);
                return AuraCard(
                  onTap: () => _showBacSubjectSheet(context, subject, color),
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                              color: color.withOpacity(0.12),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              '${subject.year}',
                              style: TextStyle(
                                color: color,
                                fontWeight: FontWeight.w700,
                                fontSize: 12,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            subject.session,
                            style: const TextStyle(
                              fontSize: 11,
                              color: AppColors.textSecondaryLight,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Text(
                        subject.title,
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                              fontWeight: FontWeight.w700,
                            ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Icon(Iconsax.document, size: 14, color: color),
                          const SizedBox(width: 6),
                          Text(
                            'Sujet + Corrigé inclus',
                            style: TextStyle(
                              fontSize: 12,
                              color: color,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }

  void _showBacSubjectSheet(BuildContext context, dynamic subject, Color color) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.85,
        maxChildSize: 0.95,
        minChildSize: 0.5,
        expand: false,
        builder: (context, scrollController) => Container(
          decoration: const BoxDecoration(
            color: AppColors.backgroundLight,
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
          ),
          child: DefaultTabController(
            length: 2,
            child: Column(
              children: [
                const SizedBox(height: 12),
                Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: AppColors.borderLight,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    subject.title,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                    textAlign: TextAlign.center,
                  ),
                ),
                TabBar(
                  labelColor: color,
                  indicatorColor: color,
                  tabs: const [
                    Tab(text: 'Sujet'),
                    Tab(text: 'Corrigé'),
                  ],
                ),
                Expanded(
                  child: TabBarView(
                    children: [
                      SingleChildScrollView(
                        controller: scrollController,
                        padding: const EdgeInsets.all(20),
                        child: Text(subject.content,
                            style: const TextStyle(height: 1.6)),
                      ),
                      SingleChildScrollView(
                        padding: const EdgeInsets.all(20),
                        child: Text(subject.correction,
                            style: const TextStyle(height: 1.6)),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
