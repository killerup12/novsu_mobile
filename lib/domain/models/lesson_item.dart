import 'package:equatable/equatable.dart';

class Lesson extends Equatable {
  final String name;
  final String teacher;
  final List<String> time;
  final String room;
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