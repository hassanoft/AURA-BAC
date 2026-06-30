import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax/iconsax.dart';
import '../../../core/constants/app_colors.dart';
import '../../providers/providers.dart';
import '../../widgets/common/common_widgets.dart';
import '../../widgets/common/subject_color.dart';
import '../../../data/models/favorite_model.dart';

class CourseDetailScreen extends ConsumerStatefulWidget {
  final String courseId;

  const CourseDetailScreen({super.key, required this.courseId});

  @override
  ConsumerState<CourseDetailScreen> createState() =>
      _CourseDetailScreenState();
}

class _CourseDetailScreenState extends ConsumerState<CourseDetailScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(courseRepositoryProvider).markConsulted(widget.courseId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final course = ref.watch(courseByIdProvider(widget.courseId));
    if (course == null) {
      return const Scaffold(body: Center(child: Text('Cours introuvable')));
    }

    final color = SubjectColor.forId(course.subjectId);
    final isFav = ref.watch(favoriteNotifierProvider.select(
        (favs) => favs.any((f) => f.itemId == course.id)));

    return Scaffold(
      appBar: AppBar(
        title: Text(
          course.chapter,
          style: const TextStyle(fontSize: 14),
        ),
        actions: [
          IconButton(
            onPressed: () {
              ref.read(favoriteNotifierProvider.notifier).toggle(
                    FavoriteModel(
                      id: course.id,
                      itemId: course.id,
                      itemTitle: course.title,
                      subjectId: course.subjectId,
                      subjectName: course.subjectId,
                      typeIndex: 0,
                      savedAt: DateTime.now(),
                    ),
                  );
            },
            icon: Icon(
              isFav ? Iconsax.heart5 : Iconsax.heart,
              color: isFav ? AppColors.error : null,
            ),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          // Title section
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  SubjectColor.iconForId(course.subjectId),
                  color: color,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  course.title,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.w800,
                      ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              DifficultyBadge(difficulty: course.difficulty),
              const SizedBox(width: 8),
              Icon(Iconsax.clock, size: 14, color: AppColors.textSecondaryLight),
              const SizedBox(width: 4),
              Text(
                '${course.estimatedMinutes} min de lecture',
                style: const TextStyle(
                  fontSize: 12,
                  color: AppColors.textSecondaryLight,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Summary card
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: color.withOpacity(0.08),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Text(
              course.summary,
              style: TextStyle(
                color: color,
                fontWeight: FontWeight.w500,
                height: 1.5,
              ),
            ),
          ),
          const SizedBox(height: 24),

          // Markdown-like content
          _ContentRenderer(content: course.content),

          const SizedBox(height: 24),

          // Tips section
          if (course.tips.isNotEmpty) ...[
            Row(
              children: [
                const Icon(Iconsax.lamp_on, color: AppColors.accent, size: 20),
                const SizedBox(width: 8),
                Text(
                  'Conseils pratiques',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            ...course.tips.map((tip) => Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: AppColors.accentContainer,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('✓ ',
                          style: TextStyle(
                              color: AppColors.accentDark,
                              fontWeight: FontWeight.w800)),
                      Expanded(
                        child: Text(
                          tip,
                          style: const TextStyle(
                            color: AppColors.accentDark,
                            fontWeight: FontWeight.w500,
                            height: 1.4,
                          ),
                        ),
                      ),
                    ],
                  ),
                )),
          ],

          const SizedBox(height: 24),

          // Mark as completed button
          SizedBox(
            width: double.infinity,
            child: FilledButton.icon(
              onPressed: () {
                ref
                    .read(courseRepositoryProvider)
                    .markCompleted(course.id, !course.isCompleted);
                setState(() {});
              },
              icon: Icon(course.isCompleted
                  ? Iconsax.tick_circle5
                  : Iconsax.tick_circle),
              label: Text(course.isCompleted
                  ? 'Cours terminé ✓'
                  : 'Marquer comme terminé'),
              style: FilledButton.styleFrom(
                backgroundColor:
                    course.isCompleted ? AppColors.success : color,
              ),
            ),
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }
}

/// Renders simple markdown-style content (headers, bold, lists)
class _ContentRenderer extends StatelessWidget {
  final String content;
  const _ContentRenderer({required this.content});

  @override
  Widget build(BuildContext context) {
    final lines = content.split('\n');
    final widgets = <Widget>[];

    for (final line in lines) {
      if (line.trim().isEmpty) {
        widgets.add(const SizedBox(height: 8));
      } else if (line.startsWith('### ')) {
        widgets.add(Padding(
          padding: const EdgeInsets.only(top: 12, bottom: 6),
          child: Text(
            line.substring(4),
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: AppColors.primary,
                ),
          ),
        ));
      } else if (line.startsWith('## ')) {
        widgets.add(Padding(
          padding: const EdgeInsets.only(top: 16, bottom: 8),
          child: Text(
            line.substring(3),
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w800,
                ),
          ),
        ));
      } else if (line.startsWith('# ')) {
        widgets.add(Padding(
          padding: const EdgeInsets.only(top: 16, bottom: 8),
          child: Text(
            line.substring(2),
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w800,
                ),
          ),
        ));
      } else if (line.startsWith('- ') || line.startsWith('* ')) {
        widgets.add(Padding(
          padding: const EdgeInsets.only(left: 8, bottom: 4),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('•  ', style: TextStyle(fontWeight: FontWeight.w700)),
              Expanded(child: _RichTextLine(text: line.substring(2))),
            ],
          ),
        ));
      } else if (line.startsWith('```')) {
        // skip code fences, handled as block below if needed
      } else if (RegExp(r'^\d+\)').hasMatch(line.trim())) {
        widgets.add(Padding(
          padding: const EdgeInsets.only(bottom: 4),
          child: _RichTextLine(text: line),
        ));
      } else {
        widgets.add(Padding(
          padding: const EdgeInsets.only(bottom: 6),
          child: _RichTextLine(text: line),
        ));
      }
    }

    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: widgets);
  }
}

/// Renders a line of text with basic **bold** support
class _RichTextLine extends StatelessWidget {
  final String text;
  const _RichTextLine({required this.text});

  @override
  Widget build(BuildContext context) {
    final spans = <TextSpan>[];
    final regex = RegExp(r'\*\*(.+?)\*\*');
    int last = 0;
    for (final match in regex.allMatches(text)) {
      if (match.start > last) {
        spans.add(TextSpan(text: text.substring(last, match.start)));
      }
      spans.add(TextSpan(
        text: match.group(1),
        style: const TextStyle(fontWeight: FontWeight.w800),
      ));
      last = match.end;
    }
    if (last < text.length) {
      spans.add(TextSpan(text: text.substring(last)));
    }

    return RichText(
      text: TextSpan(
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: AppColors.textPrimaryLight,
              height: 1.6,
            ),
        children: spans,
      ),
    );
  }
}
