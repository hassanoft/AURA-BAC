import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import '../../providers/providers.dart';
import '../../../core/constants/app_colors.dart';

/// Main shell screen with bottom navigation bar
class MainShellScreen extends ConsumerWidget {
  final Widget child;

  const MainShellScreen({super.key, required this.child});

  static const List<_NavItem> _navItems = [
    _NavItem(
      icon: Iconsax.home,
      activeIcon: Iconsax.home_15,
      label: 'Accueil',
      route: '/',
    ),
    _NavItem(
      icon: Iconsax.book,
      activeIcon: Iconsax.book_15,
      label: 'Séries',
      route: '/series',
    ),
    _NavItem(
      icon: Iconsax.teacher,
      activeIcon: Iconsax.teacher5,
      label: 'Quiz',
      route: '/quiz',
    ),
    _NavItem(
      icon: Iconsax.chart,
      activeIcon: Iconsax.chart_15,
      label: 'Stats',
      route: '/stats',
    ),
    _NavItem(
      icon: Iconsax.heart,
      activeIcon: Iconsax.heart5,
      label: 'Favoris',
      route: '/favorites',
    ),
  ];

  int _getIndex(BuildContext context) {
    final location = GoRouterState.of(context).matchedLocation;
    for (int i = 0; i < _navItems.length; i++) {
      if (location == _navItems[i].route) return i;
    }
    return 0;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentIndex = _getIndex(context);
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      body: child,
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: isDark ? AppColors.surfaceDark : AppColors.backgroundLight,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 20,
              offset: const Offset(0, -4),
            ),
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(_navItems.length, (i) {
                final item = _navItems[i];
                final isActive = currentIndex == i;
                return _NavBarItem(
                  item: item,
                  isActive: isActive,
                  onTap: () => context.go(item.route),
                );
              }),
            ),
          ),
        ),
      ),
    );
  }
}

class _NavBarItem extends StatelessWidget {
  final _NavItem item;
  final bool isActive;
  final VoidCallback onTap;

  const _NavBarItem({
    required this.item,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeInOut,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isActive
              ? AppColors.primary.withOpacity(0.12)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              isActive ? item.activeIcon : item.icon,
              color: isActive
                  ? AppColors.primary
                  : AppColors.textSecondaryLight,
              size: 22,
            ),
            const SizedBox(height: 4),
            AnimatedDefaultTextStyle(
              duration: const Duration(milliseconds: 250),
              style: TextStyle(
                fontSize: 11,
                fontWeight:
                    isActive ? FontWeight.w700 : FontWeight.w400,
                color: isActive
                    ? AppColors.primary
                    : AppColors.textSecondaryLight,
              ),
              child: Text(item.label),
            ),
          ],
        ),
      ),
    );
  }
}

class _NavItem {
  final IconData icon;
  final IconData activeIcon;
  final String label;
  final String route;

  const _NavItem({
    required this.icon,
    required this.activeIcon,
    required this.label,
    required this.route,
  });
}
