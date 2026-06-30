// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quiz_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class QuizQuestionAdapter extends TypeAdapter<QuizQuestion> {
  @override
  final int typeId = 4;

  @override
  QuizQuestion read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return QuizQuestion(
      id: fields[0] as String,
      question: fields[1] as String,
      options: (fields[2] as List).cast<String>(),
      correctIndex: fields[3] as int,
      explanation: fields[4] as String,
      difficulty: fields[5] as String,
      points: fields[6] as int,
    );
  }

  @override
  void write(BinaryWriter writer, QuizQuestion obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.question)
      ..writeByte(2)
      ..write(obj.options)
      ..writeByte(3)
      ..write(obj.correctIndex)
      ..writeByte(4)
      ..write(obj.explanation)
      ..writeByte(5)
      ..write(obj.difficulty)
      ..writeByte(6)
      ..write(obj.points);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is QuizQuestionAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class QuizModelAdapter extends TypeAdapter<QuizModel> {
  @override
  final int typeId = 3;

  @override
  QuizModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return QuizModel(
      id: fields[0] as String,
      subjectId: fields[1] as String,
      title: fields[2] as String,
      description: fields[3] as String,
      questions: (fields[4] as List).cast<QuizQuestion>(),
      difficulty: fields[5] as String,
      timeLimitSeconds: fields[6] as int,
      seriesIds: (fields[7] as List).cast<String>(),
      timesPlayed: fields[8] as int,
      bestScore: fields[9] as double,
    );
  }

  @override
  void write(BinaryWriter writer, QuizModel obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.subjectId)
      ..writeByte(2)
      ..write(obj.title)
      ..writeByte(3)
      ..write(obj.description)
      ..writeByte(4)
      ..write(obj.questions)
      ..writeByte(5)
      ..write(obj.difficulty)
      ..writeByte(6)
      ..write(obj.timeLimitSeconds)
      ..writeByte(7)
      ..write(obj.seriesIds)
      ..writeByte(8)
      ..write(obj.timesPlayed)
      ..writeByte(9)
      ..write(obj.bestScore);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is QuizModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class QuizResultAdapter extends TypeAdapter<QuizResult> {
  @override
  final int typeId = 5;

  @override
  QuizResult read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return QuizResult(
      id: fields[0] as String,
      quizId: fields[1] as String,
      quizTitle: fields[2] as String,
      subjectId: fields[3] as String,
      score: fields[4] as int,
      totalPoints: fields[5] as int,
      correctAnswers: fields[6] as int,
      totalQuestions: fields[7] as int,
      timeTakenSeconds: fields[8] as int,
      completedAt: fields[9] as DateTime,
      userAnswers: (fields[10] as List).cast<int>(),
      difficulty: fields[11] as String,
    );
  }

  @override
  void write(BinaryWriter writer, QuizResult obj) {
    writer
      ..writeByte(12)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.quizId)
      ..writeByte(2)
      ..write(obj.quizTitle)
      ..writeByte(3)
      ..write(obj.subjectId)
      ..writeByte(4)
      ..write(obj.score)
      ..writeByte(5)
      ..write(obj.totalPoints)
      ..writeByte(6)
      ..write(obj.correctAnswers)
      ..writeByte(7)
      ..write(obj.totalQuestions)
      ..writeByte(8)
      ..write(obj.timeTakenSeconds)
      ..writeByte(9)
      ..write(obj.completedAt)
      ..writeByte(10)
      ..write(obj.userAnswers)
      ..writeByte(11)
      ..write(obj.difficulty);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is QuizResultAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class StudySessionAdapter extends TypeAdapter<StudySession> {
  @override
  final int typeId = 8;

  @override
  StudySession read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return StudySession(
      id: fields[0] as String,
      subjectId: fields[1] as String,
      date: fields[2] as DateTime,
      durationMinutes: fields[3] as int,
    );
  }

  @override
  void write(BinaryWriter writer, StudySession obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.subjectId)
      ..writeByte(2)
      ..write(obj.date)
      ..writeByte(3)
      ..write(obj.durationMinutes);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StudySessionAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
