// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subject_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SubjectModelAdapter extends TypeAdapter<SubjectModel> {
  @override
  final int typeId = 1;

  @override
  SubjectModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SubjectModel(
      id: fields[0] as String,
      name: fields[1] as String,
      description: fields[2] as String,
      colorHex: fields[3] as String,
      iconName: fields[4] as String,
      seriesIds: (fields[5] as List).cast<String>(),
      coefficient: fields[6] as int,
    );
  }

  @override
  void write(BinaryWriter writer, SubjectModel obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.colorHex)
      ..writeByte(4)
      ..write(obj.iconName)
      ..writeByte(5)
      ..write(obj.seriesIds)
      ..writeByte(6)
      ..write(obj.coefficient);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SubjectModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
