import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:novsu_mobile/domain/models/lesson.dart';

part '../hive_adapters/study_day.g.dart';

@HiveType(typeId: 2)
class StudyDay extends Equatable {
  @HiveField(0)
  final String dayOfTheWeek;
  @HiveField(1)
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