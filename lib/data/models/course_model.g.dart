// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'course_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CourseModelAdapter extends TypeAdapter<CourseModel> {
  @override
  final int typeId = 2;

  @override
  CourseModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CourseModel(
      id: fields[0] as String,
      subjectId: fields[1] as String,
      title: fields[2] as String,
      summary: fields[3] as String,
      content: fields[4] as String,
      chapter: fields[5] as String,
      orderIndex: fields[6] as int,
      tags: (fields[7] as List).cast<String>(),
      difficulty: fields[8] as String,
      estimatedMinutes: fields[9] as int,
      lastConsulted: fields[10] as DateTime,
      isCompleted: fields[11] as bool,
      tips: (fields[12] as List).cast<String>(),
    );
  }

  @override
  void write(BinaryWriter writer, CourseModel obj) {
    writer
      ..writeByte(13)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.subjectId)
      ..writeByte(2)
      ..write(obj.title)
      ..writeByte(3)
      ..write(obj.summary)
      ..writeByte(4)
      ..write(obj.content)
      ..writeByte(5)
      ..write(obj.chapter)
      ..writeByte(6)
      ..write(obj.orderIndex)
      ..writeByte(7)
      ..write(obj.tags)
      ..writeByte(8)
      ..write(obj.difficulty)
      ..writeByte(9)
      ..write(obj.estimatedMinutes)
      ..writeByte(10)
      ..write(obj.lastConsulted)
      ..writeByte(11)
      ..write(obj.isCompleted)
      ..writeByte(12)
      ..write(obj.tips);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CourseModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class ExerciseModelAdapter extends TypeAdapter<ExerciseModel> {
  @override
  final int typeId = 9;

  @override
  ExerciseModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ExerciseModel(
      id: fields[0] as String,
      subjectId: fields[1] as String,
      courseId: fields[2] as String,
      title: fields[3] as String,
      statement: fields[4] as String,
      solution: fields[5] as String,
      difficulty: fields[6] as String,
      steps: (fields[7] as List).cast<String>(),
      points: fields[8] as int,
      isCompleted: fields[9] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, ExerciseModel obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.subjectId)
      ..writeByte(2)
      ..write(obj.courseId)
      ..writeByte(3)
      ..write(obj.title)
      ..writeByte(4)
      ..write(obj.statement)
      ..writeByte(5)
      ..write(obj.solution)
      ..writeByte(6)
      ..write(obj.difficulty)
      ..writeByte(7)
      ..write(obj.steps)
      ..writeByte(8)
      ..write(obj.points)
      ..writeByte(9)
      ..write(obj.isCompleted);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ExerciseModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class BacSubjectModelAdapter extends TypeAdapter<BacSubjectModel> {
  @override
  final int typeId = 10;

  @override
  BacSubjectModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return BacSubjectModel(
      id: fields[0] as String,
      subjectId: fields[1] as String,
      seriesId: fields[2] as String,
      year: fields[3] as int,
      title: fields[4] as String,
      content: fields[5] as String,
      correction: fields[6] as String,
      session: fields[7] as String,
    );
  }

  @override
  void write(BinaryWriter writer, BacSubjectModel obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.subjectId)
      ..writeByte(2)
      ..write(obj.seriesId)
      ..writeByte(3)
      ..write(obj.year)
      ..writeByte(4)
      ..write(obj.title)
      ..writeByte(5)
      ..write(obj.content)
      ..writeByte(6)
      ..write(obj.correction)
      ..writeByte(7)
      ..write(obj.session);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BacSubjectModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
