import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

part '../hive_adapters/lesson.g.dart';

@HiveType(typeId: 3)
class Lesson extends Equatable {
  @HiveField(0)
  final String name;
  @HiveField(1)
  final String teacher;
  @HiveField(2)
  final List<String> time;
  @HiveField(3)
  final String room;
  @HiveField(4)
  final String lessonType;

  const Lesson({
    required this.name,
    required this.teacher,
    required this.time,
    required this.room,
    required this.lessonType
  });

  @override
  List<Object?> get props => [
    name,
    teacher,
    time,
    room,
    lessonType
  ];
}