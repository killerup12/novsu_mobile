import 'package:flutter/material.dart';
import 'package:novsu_mobile/domain/models/lesson.dart';
import 'package:novsu_mobile/domain/models/study_day.dart';
import 'package:novsu_mobile/features/theme/theme_helper.dart';
import 'package:flutter/widgets.dart';

class SchoolDayWidget extends StatelessWidget {
  final StudyDay schoolDay;

  const SchoolDayWidget({
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

        lessonsWidgets.add(_LessonWidget(
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
      return const _DayOffWidget();
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
}

class _DayOffWidget extends StatelessWidget {
  const _DayOffWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Text('Today you can rest'); //TODO i18n
  }
}


class _LessonWidget extends StatelessWidget {
  final String name;
  final String teacher;
  final String room;
  final List<String> time;
  final String lessonType;

  const _LessonWidget({
    Key? key,
    required this.name,
    required this.teacher,
    required this.room,
    required this.time,
    required this.lessonType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Text> lessonTime = [];
    for (var element in time) {lessonTime.add(Text(element));} //TODO add TextStyle to app_theme

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
        Flexible(
          child: SizedBox(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name),  //TODO add TextStyle to app_theme
                const SizedBox(height: 8),
                Text(teacher), //TODO add TextStyle to app_theme
                const SizedBox(height: 8),
                Text(room) //TODO add TextStyle to app_theme
              ],
            ),
          ),
        )
      ],
    );
  }
}
