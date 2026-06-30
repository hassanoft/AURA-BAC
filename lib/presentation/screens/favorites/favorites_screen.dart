import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import '../../../core/constants/app_colors.dart';
import '../../providers/providers.dart';
import '../../widgets/common/common_widgets.dart';
import '../../widgets/common/subject_color.dart';
import '../../../data/models/favorite_model.dart';

class FavoritesScreen extends ConsumerWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favorites = ref.watch(favoriteNotifierProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Favoris')),
      body: favorites.isEmpty
          ? const EmptyState(
              icon: Iconsax.heart,
              title: 'Aucun favori',
              subtitle:
                  'Ajoutez des cours, exercices ou sujets BAC à vos favoris pour les retrouver ici.',
            )
          : ListView.builder(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 100),
              itemCount: favorites.length,
              itemBuilder: (context, i) {
                final fav = favorites[i];
                final color = SubjectColor.forId(fav.subjectId);

                return Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  child: AuraCard(
                    onTap: () => _navigateToItem(context, fav),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: color.withOpacity(0.12),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Icon(
                            _iconForType(fav.type),
                            color: color,
                            size: 18,
                          ),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                fav.itemTitle,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleSmall
                                    ?.copyWith(fontWeight: FontWeight.w700),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                _labelForType(fav.type),
                                style: TextStyle(
                                  fontSize: 11,
                                  color: color,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          onPressed: () => ref
                              .read(favoriteNotifierProvider.notifier)
                              .toggle(fav),
                          icon: const Icon(Iconsax.heart5,
                              color: AppColors.error, size: 20),
                        ),
                      ],
                    ),
                  ),
                ).animate().fadeIn(delay: (40 * i).ms);
              },
            ),
    );
  }

  IconData _iconForType(FavoriteType type) {
    switch (type) {
      case FavoriteType.course:
        return Iconsax.book_1;
      case FavoriteType.exercise:
        return Iconsax.edit_2;
      case FavoriteType.bacSubject:
        return Iconsax.document_text;
    }
  }

  String _labelForType(FavoriteType type) {
    switch (type) {
      case FavoriteType.course:
        return 'Cours';
      case FavoriteType.exercise:
        return 'Exercice';
      case FavoriteType.bacSubject:
        return 'Sujet BAC';
    }
  }

  void _navigateToItem(BuildContext context, FavoriteModel fav) {
    switch (fav.type) {
      case FavoriteType.course:
        context.push('/courses/${fav.itemId}');
        break;
      case FavoriteType.exercise:
        context.push('/exercises/${fav.itemId}');
        break;
      case FavoriteType.bacSubject:
        break;
    }
  }
}
