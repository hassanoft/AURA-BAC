import 'package:hive/hive.dart';

part 'subject_model.g.dart';

/// Subject (Matière) model
@HiveType(typeId: 1)
class SubjectModel extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String description;

  @HiveField(3)
  final String colorHex;

  @HiveField(4)
  final String iconName;

  @HiveField(5)
  final List<String> seriesIds;

  @HiveField(6)
  final int coefficient;

  SubjectModel({
    required this.id,
    required this.name,
    required this.description,
    required this.colorHex,
    required this.iconName,
    required this.seriesIds,
    required this.coefficient,
  });

  static List<SubjectModel> get defaultSubjects => [
    SubjectModel(
      id: 'francais',
      name: 'Français',
      description: 'Littérature, expression écrite et orale',
      colorHex: '#2563EB',
      iconName: 'book_outlined',
      seriesIds: ['A1', 'A2', 'C', 'D', 'G1', 'G2', 'F1', 'F2', 'F3'],
      coefficient: 5,
    ),
    SubjectModel(
      id: 'philosophie',
      name: 'Philosophie',
      description: 'Pensée critique, éthique et logique',
      colorHex: '#0891B2',
      iconName: 'psychology_outlined',
      seriesIds: ['A1', 'A2', 'C', 'D', 'G1', 'G2', 'F1', 'F2', 'F3'],
      coefficient: 4,
    ),
    SubjectModel(
      id: 'mathematiques',
      name: 'Mathématiques',
      description: 'Algèbre, analyse, géométrie et probabilités',
      colorHex: '#7C3AED',
      iconName: 'calculate_outlined',
      seriesIds: ['C', 'D', 'G1', 'G2', 'F1', 'F2', 'F3'],
      coefficient: 7,
    ),
    SubjectModel(
      id: 'histoire_geo',
      name: 'Histoire-Géographie',
      description: 'Histoire du monde et géographie humaine',
      colorHex: '#059669',
      iconName: 'public_outlined',
      seriesIds: ['A1', 'A2', 'C', 'D', 'G1', 'G2'],
      coefficient: 3,
    ),
    SubjectModel(
      id: 'svt',
      name: 'SVT',
      description: 'Sciences de la Vie et de la Terre',
      colorHex: '#16A34A',
      iconName: 'biotech_outlined',
      seriesIds: ['C', 'D'],
      coefficient: 6,
    ),
    SubjectModel(
      id: 'physique_chimie',
      name: 'Physique-Chimie',
      description: 'Mécanique, électricité, thermodynamique et chimie',
      colorHex: '#EA580C',
      iconName: 'science_outlined',
      seriesIds: ['C', 'D', 'F1', 'F2', 'F3'],
      coefficient: 6,
    ),
    SubjectModel(
      id: 'anglais',
      name: 'Anglais',
      description: 'Langue anglaise – compréhension et expression',
      colorHex: '#DC2626',
      iconName: 'translate_outlined',
      seriesIds: ['A1', 'A2', 'C', 'D', 'G1', 'G2', 'F1', 'F2', 'F3'],
      coefficient: 3,
    ),
    SubjectModel(
      id: 'espagnol',
      name: 'Espagnol',
      description: 'Langue espagnole – compréhension et expression',
      colorHex: '#CA8A04',
      iconName: 'translate_outlined',
      seriesIds: ['A1', 'A2'],
      coefficient: 2,
    ),
    SubjectModel(
      id: 'allemand',
      name: 'Allemand',
      description: 'Langue allemande – compréhension et expression',
      colorHex: '#7C2D12',
      iconName: 'translate_outlined',
      seriesIds: ['A1'],
      coefficient: 2,
    ),
    SubjectModel(
      id: 'economie',
      name: 'Économie',
      description: 'Microéconomie, macroéconomie et commerce',
      colorHex: '#0369A1',
      iconName: 'trending_up_outlined',
      seriesIds: ['G1', 'G2'],
      coefficient: 5,
    ),
    SubjectModel(
      id: 'comptabilite',
      name: 'Comptabilité',
      description: 'Comptabilité générale et analytique',
      colorHex: '#4338CA',
      iconName: 'account_balance_outlined',
      seriesIds: ['G1', 'G2'],
      coefficient: 6,
    ),
    SubjectModel(
      id: 'informatique',
      name: 'Informatique',
      description: 'Algorithmique, programmation et réseaux',
      colorHex: '#0F766E',
      iconName: 'computer_outlined',
      seriesIds: ['G1', 'G2', 'F1', 'F2', 'F3'],
      coefficient: 4,
    ),
  ];
}
