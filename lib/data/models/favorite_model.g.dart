// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favorite_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FavoriteModelAdapter extends TypeAdapter<FavoriteModel> {
  @override
  final int typeId = 6;

  @override
  FavoriteModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FavoriteModel(
      id: fields[0] as String,
      itemId: fields[1] as String,
      itemTitle: fields[2] as String,
      subjectId: fields[3] as String,
      subjectName: fields[4] as String,
      typeIndex: fields[5] as int,
      savedAt: fields[6] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, FavoriteModel obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.itemId)
      ..writeByte(2)
      ..write(obj.itemTitle)
      ..writeByte(3)
      ..write(obj.subjectId)
      ..writeByte(4)
      ..write(obj.subjectName)
      ..writeByte(5)
      ..write(obj.typeIndex)
      ..writeByte(6)
      ..write(obj.savedAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FavoriteModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class ProgressModelAdapter extends TypeAdapter<ProgressModel> {
  @override
  final int typeId = 7;

  @override
  ProgressModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ProgressModel(
      subjectId: fields[0] as String,
      coursesCompleted: fields[1] as int,
      totalCourses: fields[2] as int,
      exercisesCompleted: fields[3] as int,
      totalExercises: fields[4] as int,
      quizzesTaken: fields[5] as int,
      averageScore: fields[6] as double,
      studyMinutes: fields[7] as int,
      lastStudied: fields[8] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, ProgressModel obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.subjectId)
      ..writeByte(1)
      ..write(obj.coursesCompleted)
      ..writeByte(2)
      ..write(obj.totalCourses)
      ..writeByte(3)
      ..write(obj.exercisesCompleted)
      ..writeByte(4)
      ..write(obj.totalExercises)
      ..writeByte(5)
      ..write(obj.quizzesTaken)
      ..writeByte(6)
      ..write(obj.averageScore)
      ..writeByte(7)
      ..write(obj.studyMinutes)
      ..writeByte(8)
      ..write(obj.lastStudied);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProgressModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
