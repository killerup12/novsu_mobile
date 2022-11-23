// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../models/timetable.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TimetableAdapter extends TypeAdapter<Timetable> {
  @override
  final int typeId = 1;

  @override
  Timetable read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Timetable(
      forGroup: fields[0] as String,
      relevancePeriod: fields[1] as String,
      studyDays: (fields[2] as List).cast<StudyDay>(),
    );
  }

  @override
  void write(BinaryWriter writer, Timetable obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.forGroup)
      ..writeByte(1)
      ..write(obj.relevancePeriod)
      ..writeByte(2)
      ..write(obj.studyDays);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TimetableAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
