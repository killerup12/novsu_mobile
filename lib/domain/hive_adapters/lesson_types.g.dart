// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../enums/lesson_types.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LessonTypesAdapter extends TypeAdapter<LessonTypes> {
  @override
  final int typeId = 4;

  @override
  LessonTypes read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return LessonTypes.lecture;
      case 1:
        return LessonTypes.practice;
      case 2:
        return LessonTypes.lecture;
      default:
        return LessonTypes.unknown;
    }
  }

  @override
  void write(BinaryWriter writer, LessonTypes obj) {
    switch (obj) {
      case LessonTypes.lecture:
        writer.writeByte(0);
        break;
      case LessonTypes.practice:
        writer.writeByte(1);
        break;
      case LessonTypes.laboratory:
        writer.writeByte(2);
        break;
      case LessonTypes.unknown:
        writer.writeByte(3);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LessonTypesAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
