import 'package:equatable/equatable.dart';
import 'package:novsu_mobile/domain/models/lesson_item.dart';

class StudyDay extends Equatable {
  final String dayOfTheWeek;
  final List<Lesson>? lessons;

  const StudyDay._local({
    required this.dayOfTheWeek,
    required this.lessons
  });

  factory StudyDay({ required String shortWeekDay, required List<Lesson> lessons}) {
    convertWeekDay(String weekDay) {
      switch (weekDay) {
        case 'Пн':
          return 'Понедельник';
        case 'Вт':
          return 'Вторник';
        case 'Ср':
          return 'Среда';
        case 'Чт':
          return 'Четверг';
        case 'Пт':
          return 'Пятница';
        case 'Сб':
          return 'Суббота';
        case 'Вс':
          return 'Воскресеье';
        default:
          throw Exception(); // TODO add custom Error for this one
      }
    }

    return StudyDay._local(
        dayOfTheWeek: convertWeekDay(shortWeekDay),
        lessons: lessons
    );
  }

  String convertWeekDay(String shortWeekDay) {
    return shortWeekDay;
  }

  @override
  List<Object?> get props => [
    dayOfTheWeek,
    lessons
  ];
}