import 'package:aura_bac/data/models/series_model.dart';
import 'package:aura_bac/data/models/subject_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('SeriesModel', () {
    test('defaultSeries contains all 9 BAC series', () {
      final series = SeriesModel.defaultSeries;
      expect(series.length, 9);
      final ids = series.map((s) => s.id).toSet();
      expect(
        ids,
        {'A1', 'A2', 'C', 'D', 'G1', 'G2', 'F1', 'F2', 'F3'},
      );
    });

    test('each series has at least one subject', () {
      for (final s in SeriesModel.defaultSeries) {
        expect(s.subjectIds, isNotEmpty);
      }
    });
  });

  group('SubjectModel', () {
    test('defaultSubjects contains all 12 required subjects', () {
      final subjects = SubjectModel.defaultSubjects;
      expect(subjects.length, 12);
      final ids = subjects.map((s) => s.id).toSet();
      expect(
        ids,
        {
          'allemand',
          'anglais',
          'comptabilite',
          'economie',
          'espagnol',
          'francais',
          'histoire_geo',
          'informatique',
          'mathematiques',
          'philosophie',
          'physique_chimie',
          'svt',
        },
      );
    });

    test('coefficients are positive', () {
      for (final s in SubjectModel.defaultSubjects) {
        expect(s.coefficient, greaterThan(0));
      }
    });
  });
}