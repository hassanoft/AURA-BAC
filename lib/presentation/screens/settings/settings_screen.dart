import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:iconsax/iconsax.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_constants.dart';
import '../../providers/providers.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeProvider);
    final isDark = themeMode == ThemeMode.dark;

    return Scaffold(
      appBar: AppBar(title: const Text('Paramètres')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          _SettingsSection(
            title: 'Apparence',
            children: [
              _SettingsTile(
                icon: Iconsax.moon,
                iconColor: AppColors.secondary,
                title: 'Mode sombre',
                trailing: Switch(
                  value: isDark,
                  onChanged: (_) =>
                      ref.read(themeProvider.notifier).toggleTheme(),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          _SettingsSection(
            title: 'Langue',
            children: [
              _SettingsTile(
                icon: Iconsax.global,
                iconColor: AppColors.primary,
                title: 'Langue de l\'application',
                subtitle: 'Français',
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                          'Seul le français est disponible pour le moment.'),
                    ),
                  );
                },
              ),
            ],
          ),
          const SizedBox(height: 24),
          _SettingsSection(
            title: 'Données',
            children: [
              _SettingsTile(
                icon: Iconsax.trash,
                iconColor: AppColors.error,
                title: 'Réinitialiser les données',
                subtitle: 'Effacer toute la progression et l\'historique',
                onTap: () => _confirmReset(context, ref),
              ),
            ],
          ),
          const SizedBox(height: 24),
          _SettingsSection(
            title: 'À propos',
            children: [
              _SettingsTile(
                icon: Iconsax.info_circle,
                iconColor: AppColors.info,
                title: 'Version de l\'application',
                subtitle: AppConstants.appVersion,
              ),
              _SettingsTile(
                icon: Iconsax.heart,
                iconColor: AppColors.error,
                title: 'Développé avec passion',
                subtitle: AppConstants.developerName,
              ),
              _SettingsTile(
                icon: Iconsax.message_question,
                iconColor: AppColors.accent,
                title: 'Nous contacter',
                subtitle: AppConstants.contactEmail,
              ),
            ],
          ),
          const SizedBox(height: 32),
          Center(
            child: Column(
              children: [
                Text(
                  AppConstants.appName,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w800,
                        color: AppColors.primary,
                      ),
                ),
                const SizedBox(height: 4),
                Text(
                  AppConstants.appSlogan,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColors.textSecondaryLight,
                      ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }

  void _confirmReset(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Réinitialiser les données ?'),
        content: const Text(
            'Cette action effacera définitivement votre progression, vos favoris et votre historique de quiz. Cette action est irréversible.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Annuler'),
          ),
          TextButton(
            onPressed: () async {
              await Hive.box(AppConstants.favoritesBox).clear();
              await Hive.box(AppConstants.quizResultsBox).clear();
              await Hive.box(AppConstants.progressBox).clear();
              await Hive.box(AppConstants.studySessionsBox).clear();
              if (context.mounted) {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                      content: Text('Données réinitialisées avec succès.')),
                );
              }
            },
            child: const Text('Réinitialiser',
                style: TextStyle(color: AppColors.error)),
          ),
        ],
      ),
    );
  }
}

class _SettingsSection extends StatelessWidget {
  final String title;
  final List<Widget> children;

  const _SettingsSection({required this.title, required this.children});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4, bottom: 8),
          child: Text(
            title.toUpperCase(),
            style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w700,
              color: AppColors.textSecondaryLight,
              letterSpacing: 0.5,
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: AppColors.backgroundLight,
            borderRadius: BorderRadius.circular(16),
            boxShadow: AppColors.cardShadow,
          ),
          child: Column(children: children),
        ),
      ],
    );
  }
}

class _SettingsTile extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final String? subtitle;
  final Widget? trailing;
  final VoidCallback? onTap;

  const _SettingsTile({
    required this.icon,
    required this.iconColor,
    required this.title,
    this.subtitle,
    this.trailing,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: iconColor.withOpacity(0.12),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(icon, color: iconColor, size: 18),
      ),
      title: Text(title),
      subtitle: subtitle != null ? Text(subtitle!) : null,
      trailing: trailing ??
          (onTap != null
              ? const Icon(Iconsax.arrow_right_3,
                  size: 16, color: AppColors.textSecondaryLight)
              : null),
    );
  }
}
