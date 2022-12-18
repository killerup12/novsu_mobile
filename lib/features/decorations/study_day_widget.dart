import 'package:flutter/material.dart';
import 'package:novsu_mobile/domain/enums/lesson_types.dart';
import 'package:novsu_mobile/domain/models/lesson.dart';
import 'package:novsu_mobile/domain/models/study_day.dart';
import 'package:novsu_mobile/features/theme/theme_helper.dart';

class StudyDayWidget extends StatelessWidget {
  final StudyDay schoolDay;

  const StudyDayWidget({
    Key? key,
    required this.schoolDay
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      foregroundDecoration: BoxDecoration(
        border: Border.all(color: ThemeHelper.getAppTheme().colorGreen, width: 4),
        borderRadius: BorderRadius.circular(25),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 30.0),
        child: Column(
          children: [
            _buildDayInformationPart(schoolDay.dayOfTheWeek),
            const SizedBox(height: 10),
            _buildLessonsPart(schoolDay.lessons)
          ],
        ),
      )
    );
  }

  Widget _buildLessonsPart(List<Lesson>? lessons) {
    if (lessons != null) {
      final List<Widget> lessonsWidgets = [];

      for (int i = 0; i < lessons.length; i++) {
        Lesson lesson = lessons[i];

        lessonsWidgets.add(_buildLessonWidget(
            name: lesson.name,
            teacher: lesson.teacher,
            room: lesson.room,
            time: lesson.time,
            lessonType: lesson.lessonType
        ));

        if (i != lessons.length - 1) {
          lessonsWidgets.add(const SizedBox(height: 20));
        }
      }

      return Column(children: lessonsWidgets);
    } else {
      return _buildDayOffWidget();
    }

  }

  Widget _buildDayInformationPart(String dayOfTheWeek) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const SizedBox(width: 20),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(dayOfTheWeek), //TODO add TextStyle to app_theme
          ],
        ),
      ],
    );
  }

  Widget _buildLessonWidget({
    required String name,
    required String teacher,
    required String room,
    required List<String> time,
    required String lessonType
  }) {
    final List<Text> lessonTime = [];
    for (String element in time) {
      lessonTime.add(Text(element));  //TODO add TextStyle to app_theme
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(
          width: 65,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: lessonTime,
          ),
        ),
        const SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(name),  //TODO add TextStyle to app_theme
            Text(teacher), //TODO add TextStyle to app_theme
            Text(room) //TODO add TextStyle to app_theme
          ],
        )
      ],
    );
  }

  String selectLessonType(LessonTypes lessonType) {
    switch (lessonType) {
      case LessonTypes.lecture:
        return 'Lecture'; //TODO i18n
      case LessonTypes.practice:
        return 'Practice'; //TODO i18n
      default:
        return 'Elective'; //TODO i18n
    }
  }

  Color selectLessonTypeColor(LessonTypes lessonType) {
    switch (lessonType) {
      case LessonTypes.lecture:
        return ThemeHelper.getAppTheme().colorLessonTypeLecture;
      case LessonTypes.practice:
        return ThemeHelper.getAppTheme().colorLessonTypePractice;
      default:
        return '';
    }
  }
}
