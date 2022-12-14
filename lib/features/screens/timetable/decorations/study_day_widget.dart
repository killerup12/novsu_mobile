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
    for (var element in time) {lessonTime.add(Text(element));} //TODO add TextStyle to app_theme

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Flexible(
          child: SizedBox(
            width: 65,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: lessonTime,
            ),
          ),
        ),
        const SizedBox(width: 10),
        Flexible(
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
        )
      ],
    );
  }

  Widget _buildDayOffWidget() {
    return const Text('Today you can rest'); //TODO i18n
  }

  String _convertIntWeekdayToString(int weekday) {
    switch (weekday) {
      case 1:
        return 'Monday';  //TODO i18n
      case 2:
        return 'Tuesday'; //TODO i18n
      case 3:
        return 'Wednesday'; //TODO i18n
      case 4:
        return 'Thursday';  //TODO i18n
      case 5:
        return 'Friday';  //TODO i18n
      case 6:
        return 'Saturday';  //TODO i18n
      case 7:
        return 'Sunday';  //TODO i18n
      default:
        return '';
    }
  }

  String _convertIntMonthToString(int month) {
    switch (month) {
      case 1:
        return 'January'; //TODO i18n
      case 2:
        return 'February';  //TODO i18n
      case 3:
        return 'March'; //TODO i18n
      case 4:
        return 'April'; //TODO i18n
      case 5:
        return 'May'; //TODO i18n
      case 6:
        return 'June';  //TODO i18n
      case 7:
        return 'July';  //TODO i18n
      case 8:
        return 'August';  //TODO i18n
      case 9:
        return 'September'; //TODO i18n
      case 10:
        return 'October'; //TODO i18n
      case 11:
        return 'November';  //TODO i18n
      case 12:
        return 'December';  //TODO i18n
      default:
        return '';
    }
  }
}
