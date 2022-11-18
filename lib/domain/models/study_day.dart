import 'package:equatable/equatable.dart';
import 'package:novsu_mobile/domain/models/lesson_item.dart';

class StudyDay extends Equatable {
  final String dayOfTheWeek;
  final List<Lesson>? lessons;

  const StudyDay({
    required this.dayOfTheWeek,
    required this.lessons
  });

  @override
  List<Object?> get props => [
    dayOfTheWeek,
    lessons
  ];
}