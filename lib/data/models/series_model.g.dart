// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'series_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SeriesModelAdapter extends TypeAdapter<SeriesModel> {
  @override
  final int typeId = 0;

  @override
  SeriesModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SeriesModel(
      id: fields[0] as String,
      name: fields[1] as String,
      description: fields[2] as String,
      colorHex: fields[3] as String,
      subjectIds: (fields[4] as List).cast<String>(),
      category: fields[5] as String,
    );
  }

  @override
  void write(BinaryWriter writer, SeriesModel obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.colorHex)
      ..writeByte(4)
      ..write(obj.subjectIds)
      ..writeByte(5)
      ..write(obj.category);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SeriesModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
