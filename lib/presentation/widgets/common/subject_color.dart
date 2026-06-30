import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';

/// Utility to get a color and icon for a given subject ID
class SubjectColor {
  SubjectColor._();

  static Color forId(String subjectId) {
    switch (subjectId) {
      case 'francais':
        return AppColors.frenchColor;
      case 'mathematiques':
        return AppColors.mathColor;
      case 'philosophie':
        return AppColors.philosophyColor;
      case 'histoire_geo':
        return AppColors.histgeoColor;
      case 'svt':
        return AppColors.svtColor;
      case 'physique_chimie':
        return AppColors.physicsColor;
      case 'anglais':
        return AppColors.englishColor;
      case 'espagnol':
        return AppColors.spanishColor;
      case 'allemand':
        return AppColors.germanColor;
      case 'economie':
        return AppColors.economyColor;
      case 'comptabilite':
        return AppColors.accountingColor;
      case 'informatique':
        return AppColors.computerColor;
      default:
        return AppColors.primary;
    }
  }

  static IconData iconForId(String subjectId) {
    switch (subjectId) {
      case 'francais':
        return Icons.menu_book_outlined;
      case 'mathematiques':
        return Icons.calculate_outlined;
      case 'philosophie':
        return Icons.psychology_outlined;
      case 'histoire_geo':
        return Icons.public_outlined;
      case 'svt':
        return Icons.biotech_outlined;
      case 'physique_chimie':
        return Icons.science_outlined;
      case 'anglais':
      case 'espagnol':
      case 'allemand':
        return Icons.translate_outlined;
      case 'economie':
        return Icons.trending_up_outlined;
      case 'comptabilite':
        return Icons.account_balance_outlined;
      case 'informatique':
        return Icons.computer_outlined;
      default:
        return Icons.book_outlined;
    }
  }
}
