// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../models/study_day.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class StudyDayAdapter extends TypeAdapter<StudyDay> {
  @override
  final int typeId = 2;

  @override
  StudyDay read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return StudyDay._local(
      dayOfTheWeek: fields[0] as String,
      lessons: (fields[1] as List).cast<Lesson>(),
    );
  }

  @override
  void write(BinaryWriter writer, StudyDay obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.dayOfTheWeek)
      ..writeByte(1)
      ..write(obj.lessons);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StudyDayAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
