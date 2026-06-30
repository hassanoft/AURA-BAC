import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import '../../../core/constants/app_colors.dart';
import '../../providers/providers.dart';
import '../../widgets/common/common_widgets.dart';
import '../../widgets/common/subject_color.dart';
import '../../../data/models/course_model.dart';

class SearchScreen extends ConsumerStatefulWidget {
  const SearchScreen({super.key});

  @override
  ConsumerState<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen> {
  final _controller = TextEditingController();
  final _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _focusNode.requestFocus();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final results = ref.watch(searchResultsProvider);
    final query = ref.watch(searchQueryProvider);

    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _controller,
          focusNode: _focusNode,
          onChanged: (value) =>
              ref.read(searchQueryProvider.notifier).updateQuery(value),
          decoration: const InputDecoration(
            hintText: 'Rechercher...',
            border: InputBorder.none,
          ),
        ),
        actions: [
          if (query.isNotEmpty)
            IconButton(
              icon: const Icon(Iconsax.close_circle),
              onPressed: () {
                _controller.clear();
                ref.read(searchQueryProvider.notifier).clear();
              },
            ),
        ],
      ),
      body: query.isEmpty
          ? const EmptyState(
              icon: Iconsax.search_normal,
              title: 'Recherchez du contenu',
              subtitle:
                  'Tapez un mot-clé pour trouver des cours, exercices ou sujets BAC.',
            )
          : results.isEmpty
              ? const EmptyState(
                  icon: Iconsax.search_status,
                  title: 'Aucun résultat',
                  subtitle: 'Essayez avec d\'autres mots-clés.',
                )
              : ListView.builder(
                  padding: const EdgeInsets.all(20),
                  itemCount: results.length,
                  itemBuilder: (context, i) {
                    final item = results[i];
                    final isCourse = item is CourseModel;
                    final subjectId =
                        isCourse ? item.subjectId : (item as ExerciseModel).subjectId;
                    final color = SubjectColor.forId(subjectId);
                    final title = isCourse ? item.title : (item as ExerciseModel).title;

                    return Container(
                      margin: const EdgeInsets.only(bottom: 12),
                      child: AuraCard(
                        onTap: () {
                          if (isCourse) {
                            context.push('/courses/${item.id}');
                          } else {
                            context.push('/exercises/${(item as ExerciseModel).id}');
                          }
                        },
                        child: Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: color.withOpacity(0.12),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Icon(
                                isCourse
                                    ? Iconsax.book_1
                                    : Iconsax.edit_2,
                                color: color,
                                size: 18,
                              ),
                            ),
                            const SizedBox(width: 14),
                            Expanded(
                              child: Column(
                                crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    title,
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleSmall
                                        ?.copyWith(
                                            fontWeight: FontWeight.w700),
                                  ),
                                  Text(
                                    isCourse ? 'Cours' : 'Exercice',
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: color,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
    );
  }
}
