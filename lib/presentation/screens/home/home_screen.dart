import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import 'package:percent_indicator/percent_indicator.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/router/app_router.dart';
import '../../providers/providers.dart';
import '../../widgets/common/subject_color.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final quote = ref.watch(dailyQuoteProvider);
    final recentCourses = ref.watch(recentCoursesProvider);
    final averageScore = ref.watch(averageScoreProvider);
    final totalQuizzes = ref.watch(totalQuizzesProvider);
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: CustomScrollView(
        slivers: [
          // ── App Bar ──
          SliverAppBar(
            expandedHeight: 0,
            floating: true,
            snap: true,
            backgroundColor: theme.scaffoldBackgroundColor,
            elevation: 0,
            title: Row(
              children: [
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    gradient: AppColors.primaryGradient,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Center(
                    child: Text(
                      'A',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w800,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Text(
                  AppConstants.appName,
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w800,
                    color: AppColors.primary,
                  ),
                ),
              ],
            ),
            actions: [
              IconButton(
                onPressed: () => context.push(AppRoutes.search),
                icon: const Icon(Iconsax.search_normal),
                tooltip: 'Rechercher',
              ),
              IconButton(
                onPressed: () => context.push(AppRoutes.settings),
                icon: const Icon(Iconsax.setting_2),
                tooltip: 'Paramètres',
              ),
              const SizedBox(width: 8),
            ],
          ),

          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ── Greeting ──
                  Text(
                    _getGreeting(),
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: AppColors.textSecondaryLight,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Prêt à réviser ?',
                    style: theme.textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.w800,
                    ),
                  ).animate().fadeIn(duration: 400.ms).slideY(begin: 0.2),

                  const SizedBox(height: 20),

                  // ── Search Bar ──
                  _SearchBar(onTap: () => context.push(AppRoutes.search))
                      .animate()
                      .fadeIn(delay: 100.ms),

                  const SizedBox(height: 24),

                  // ── Quote Card ──
                  _QuoteCard(quote: quote)
                      .animate()
                      .fadeIn(delay: 150.ms)
                      .slideY(begin: 0.1),

                  const SizedBox(height: 24),

                  // ── Stats Row ──
                  _StatsRow(
                    averageScore: averageScore,
                    totalQuizzes: totalQuizzes,
                  ).animate().fadeIn(delay: 200.ms),

                  const SizedBox(height: 24),

                  // ── Quick Access ──
                  _SectionHeader(
                    title: 'Accès Rapide',
                    subtitle: 'Toutes les séries',
                    onMore: () => context.go(AppRoutes.series),
                  ),
                  const SizedBox(height: 12),
                  _QuickAccessGrid()
                      .animate()
                      .fadeIn(delay: 250.ms),

                  const SizedBox(height: 24),

                  // ── Recent Courses ──
                  if (recentCourses.isNotEmpty) ...[
                    _SectionHeader(
                      title: 'Derniers Cours Consultés',
                      subtitle: 'Reprendre où j\'en étais',
                    ),
                    const SizedBox(height: 12),
                    ...recentCourses.map(
                      (course) => _RecentCourseCard(course: course)
                          .animate()
                          .fadeIn(delay: 300.ms),
                    ),
                  ] else ...[
                    _SectionHeader(
                      title: 'Commencer à Apprendre',
                      subtitle: 'Choisissez votre série',
                    ),
                    const SizedBox(height: 12),
                    _EmptyRecentCard(
                      onTap: () => context.go(AppRoutes.series),
                    ).animate().fadeIn(delay: 300.ms),
                  ],

                  const SizedBox(height: 100),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _getGreeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) return 'Bonjour 👋';
    if (hour < 18) return 'Bon après-midi 👋';
    return 'Bonsoir 👋';
  }
}

// ── Search Bar ──────────────────────────────────────────────────────────────

class _SearchBar extends StatelessWidget {
  final VoidCallback onTap;
  const _SearchBar({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: AppColors.backgroundLight,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: AppColors.borderLight),
          boxShadow: AppColors.cardShadow,
        ),
        child: Row(
          children: [
            const Icon(Iconsax.search_normal,
                color: AppColors.textSecondaryLight, size: 20),
            const SizedBox(width: 12),
            Text(
              'Rechercher cours, exercices, quiz...',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.textHintLight,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Quote Card ──────────────────────────────────────────────────────────────

class _QuoteCard extends StatelessWidget {
  final String quote;
  const _QuoteCard({required this.quote});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: AppColors.primaryGradient,
        borderRadius: BorderRadius.circular(20),
        boxShadow: AppColors.elevatedShadow,
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  '💡 Citation du jour',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  '"$quote"',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          const Icon(Iconsax.quote_up_square,
              color: Colors.white38, size: 48),
        ],
      ),
    );
  }
}

// ── Stats Row ───────────────────────────────────────────────────────────────

class _StatsRow extends StatelessWidget {
  final double averageScore;
  final int totalQuizzes;

  const _StatsRow({required this.averageScore, required this.totalQuizzes});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _StatCard(
            icon: Iconsax.award,
            iconColor: AppColors.accent,
            iconBg: AppColors.accentContainer,
            title: 'Moyenne',
            value: '${averageScore.toStringAsFixed(0)}%',
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _StatCard(
            icon: Iconsax.teacher,
            iconColor: AppColors.secondary,
            iconBg: AppColors.secondaryContainer,
            title: 'Quiz',
            value: '$totalQuizzes',
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _StatCard(
            icon: Iconsax.book,
            iconColor: AppColors.primary,
            iconBg: AppColors.primaryContainer,
            title: 'Cours',
            value: '12',
          ),
        ),
      ],
    );
  }
}

class _StatCard extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final Color iconBg;
  final String title;
  final String value;

  const _StatCard({
    required this.icon,
    required this.iconColor,
    required this.iconBg,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.backgroundLight,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.borderLight),
        boxShadow: AppColors.cardShadow,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: iconBg,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: iconColor, size: 18),
          ),
          const SizedBox(height: 10),
          Text(
            value,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w800,
                  fontSize: 22,
                ),
          ),
          Text(
            title,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppColors.textSecondaryLight,
                ),
          ),
        ],
      ),
    );
  }
}

// ── Section Header ──────────────────────────────────────────────────────────

class _SectionHeader extends StatelessWidget {
  final String title;
  final String? subtitle;
  final VoidCallback? onMore;

  const _SectionHeader({
    required this.title,
    this.subtitle,
    this.onMore,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
            ),
            if (subtitle != null)
              Text(
                subtitle!,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppColors.textSecondaryLight,
                    ),
              ),
          ],
        ),
        if (onMore != null)
          TextButton(
            onPressed: onMore,
            child: const Text('Voir tout'),
          ),
      ],
    );
  }
}

// ── Quick Access Grid ────────────────────────────────────────────────────────

class _QuickAccessGrid extends StatelessWidget {
  final List<_QuickItem> items = const [
    _QuickItem('Série C', Iconsax.book, AppColors.mathColor, 'C'),
    _QuickItem('Série D', Iconsax.leaf_1, AppColors.svtColor, 'D'),
    _QuickItem('Série A1', Iconsax.language_square, AppColors.frenchColor, 'A1'),
    _QuickItem('Série G2', Iconsax.chart_2, AppColors.accountingColor, 'G2'),
  ];

  const _QuickAccessGrid();

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 0.85,
      ),
      itemCount: items.length,
      itemBuilder: (context, i) => _QuickAccessItem(item: items[i]),
    );
  }
}

class _QuickItem {
  final String label;
  final IconData icon;
  final Color color;
  final String seriesId;
  const _QuickItem(this.label, this.icon, this.color, this.seriesId);
}

class _QuickAccessItem extends StatelessWidget {
  final _QuickItem item;
  const _QuickAccessItem({required this.item});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.push(
        '/subjects/${item.seriesId}?name=${Uri.encodeComponent(item.label)}',
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: item.color.withOpacity(0.12),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: item.color.withOpacity(0.2)),
            ),
            child: Icon(item.icon, color: item.color, size: 24),
          ),
          const SizedBox(height: 6),
          Text(
            item.label,
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimaryLight,
                ),
            textAlign: TextAlign.center,
            maxLines: 2,
          ),
        ],
      ),
    );
  }
}

// ── Recent Course Card ───────────────────────────────────────────────────────

class _RecentCourseCard extends StatelessWidget {
  final dynamic course; // CourseModel

  const _RecentCourseCard({required this.course});

  @override
  Widget build(BuildContext context) {
    final color = SubjectColor.forId(course.subjectId);
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        onTap: () => context.push('/courses/${course.id}'),
        tileColor: AppColors.backgroundLight,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
          side: BorderSide(color: AppColors.borderLight),
        ),
        leading: Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: color.withOpacity(0.12),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(Iconsax.book_1, color: color, size: 20),
        ),
        title: Text(
          course.title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context).textTheme.titleSmall,
        ),
        subtitle: Text(
          course.chapter,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: AppColors.textSecondaryLight,
              ),
        ),
        trailing: const Icon(
          Iconsax.arrow_right_3,
          size: 16,
          color: AppColors.textSecondaryLight,
        ),
      ),
    );
  }
}

class _EmptyRecentCard extends StatelessWidget {
  final VoidCallback onTap;
  const _EmptyRecentCard({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: AppColors.primaryContainer,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.primary.withOpacity(0.2)),
        ),
        child: Row(
          children: [
            const Icon(Iconsax.book_1, color: AppColors.primary, size: 32),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Commencez à apprendre !',
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          color: AppColors.primary,
                          fontWeight: FontWeight.w700,
                        ),
                  ),
                  Text(
                    'Choisissez une série pour accéder aux cours.',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColors.primaryDark,
                        ),
                  ),
                ],
              ),
            ),
            const Icon(Iconsax.arrow_right_3, color: AppColors.primary),
          ],
        ),
      ),
    );
  }
}
