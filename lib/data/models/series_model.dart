import 'package:hive/hive.dart';
import '../../core/constants/app_colors.dart';
import 'package:flutter/material.dart';

part 'series_model.g.dart';

/// BAC Series model
@HiveType(typeId: 0)
class SeriesModel extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String description;

  @HiveField(3)
  final String colorHex;

  @HiveField(4)
  final List<String> subjectIds;

  @HiveField(5)
  final String category; // Littéraire, Scientifique, Technique, Commercial

  SeriesModel({
    required this.id,
    required this.name,
    required this.description,
    required this.colorHex,
    required this.subjectIds,
    required this.category,
  });

  Color get color => Color(int.parse(colorHex.replaceAll('#', '0xFF')));

  static List<SeriesModel> get defaultSeries => [
    SeriesModel(
      id: 'A1',
      name: 'Série A1',
      description: 'Littéraire - Langues vivantes',
      colorHex: '#2563EB',
      subjectIds: ['francais', 'philosophie', 'histoire_geo', 'anglais', 'espagnol', 'allemand'],
      category: 'Littéraire',
    ),
    SeriesModel(
      id: 'A2',
      name: 'Série A2',
      description: 'Littéraire - Langues et Lettres',
      colorHex: '#7C3AED',
      subjectIds: ['francais', 'philosophie', 'histoire_geo', 'anglais', 'espagnol'],
      category: 'Littéraire',
    ),
    SeriesModel(
      id: 'C',
      name: 'Série C',
      description: 'Scientifique - Mathématiques et Physique',
      colorHex: '#059669',
      subjectIds: ['mathematiques', 'physique_chimie', 'svt', 'francais', 'philosophie', 'anglais'],
      category: 'Scientifique',
    ),
    SeriesModel(
      id: 'D',
      name: 'Série D',
      description: 'Scientifique - Sciences de la Vie et de la Terre',
      colorHex: '#16A34A',
      subjectIds: ['mathematiques', 'svt', 'physique_chimie', 'francais', 'philosophie', 'anglais'],
      category: 'Scientifique',
    ),
    SeriesModel(
      id: 'G1',
      name: 'Série G1',
      description: 'Commercial - Gestion Administrative',
      colorHex: '#0369A1',
      subjectIds: ['economie', 'comptabilite', 'mathematiques', 'francais', 'anglais', 'informatique'],
      category: 'Commercial',
    ),
    SeriesModel(
      id: 'G2',
      name: 'Série G2',
      description: 'Commercial - Comptabilité',
      colorHex: '#4338CA',
      subjectIds: ['comptabilite', 'economie', 'mathematiques', 'francais', 'anglais', 'informatique'],
      category: 'Commercial',
    ),
    SeriesModel(
      id: 'F1',
      name: 'Série F1',
      description: 'Technique - Génie Mécanique',
      colorHex: '#EA580C',
      subjectIds: ['mathematiques', 'physique_chimie', 'francais', 'anglais', 'informatique'],
      category: 'Technique',
    ),
    SeriesModel(
      id: 'F2',
      name: 'Série F2',
      description: 'Technique - Génie Électrique',
      colorHex: '#CA8A04',
      subjectIds: ['mathematiques', 'physique_chimie', 'francais', 'anglais', 'informatique'],
      category: 'Technique',
    ),
    SeriesModel(
      id: 'F3',
      name: 'Série F3',
      description: 'Technique - Génie Civil',
      colorHex: '#DC2626',
      subjectIds: ['mathematiques', 'physique_chimie', 'francais', 'anglais', 'informatique'],
      category: 'Technique',
    ),
  ];
}
