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
        border: Border.all(color: ThemeHelper.getAppTheme().colorStudyDayBorder, width: 4),
        borderRadius: BorderRadius.circular(25),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 30.0),
        child: Column(
          children: [
            _DayInformationPart(dayOfTheWeek: schoolDay.dayOfTheWeek),
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
            lesson: lesson,
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
}

class _DayInformationPart extends StatelessWidget {
  final String dayOfTheWeek;

  const _DayInformationPart({
    Key? key,
    required this.dayOfTheWeek
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const SizedBox(width: 20),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(dayOfTheWeek, style: ThemeHelper.getAppTheme().textStyleForDayOfTheWeek,)
          ],
        ),
      ],
    );;
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
  final Lesson lesson;

  final bool hasNotTeacher;
  final bool hasNotRoom;

  _LessonWidget({
    Key? key,
    required this.lesson
  }) :
      hasNotTeacher = (lesson.teacher.isEmpty) ? true : false,
      hasNotRoom = (lesson.room.isEmpty) ? true : false,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Widget> lessonTypes = [];

    lessonTypes.add(const SizedBox(width: 75));
    for (LessonTypes lessonType in lesson.lessonType) {
      lessonTypes.add(_LessonTypeWidget(
          lessonType: lessonType
      ));
      if (lessonType != lesson.lessonType.last) {
        lessonTypes.add(const SizedBox(width: 5));
      }
    }

    return Column(
      children: [
        Row(
          children: lessonTypes,
        ),
        const SizedBox(height: 7),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              width: 65,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(lesson.time.first, style: ThemeHelper.getAppTheme().textStyleForStartingLessonTime),
                  Text(lesson.time.last, style: ThemeHelper.getAppTheme().textStyleForEndingLessonTime,)
                ],
              ),
            ),
            const SizedBox(width: 10),
            Flexible(
              child: SizedBox(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(lesson.name, style: ThemeHelper.getAppTheme().textStyleForDisciplineName),
                    const SizedBox(height: 5),
                    (hasNotTeacher) ? Container() : Row(
                      children: [
                        Icon(Icons.person,  color: ThemeHelper.getAppTheme().colorDisciplineDetails, size: 14),
                        const SizedBox(width: 5),
                        Text(lesson.teacher, style: ThemeHelper.getAppTheme().textStyleForDisciplineDetails),
                      ],
                    ),
                    const SizedBox(height: 3),
                    (hasNotRoom) ? Container() : Row(
                      children: [
                        Icon(Icons.location_on,  color: ThemeHelper.getAppTheme().colorDisciplineDetails, size: 14),
                        const SizedBox(width: 5),
                        Text(lesson.room, style: ThemeHelper.getAppTheme().textStyleForDisciplineDetails),
                      ],
                    ) //TODO add TextStyle to app_theme
                  ],
                ),
              ),
            )
          ],
        ),
      ],
    );
  }
}

class _LessonTypeWidget extends StatelessWidget {
  final LessonTypes lessonType;

  const _LessonTypeWidget({
    Key? key,
    required this.lessonType
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 3),
      decoration: BoxDecoration(
          color: selectLessonTypeColor(lessonType),
          borderRadius: BorderRadius.circular(90),
          boxShadow: [
            BoxShadow(
              color: selectLessonTypeColor(lessonType),
              spreadRadius: 0.01,
              blurRadius: 12,
              offset: const Offset(0, 5),
            )
          ]
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 2.5, horizontal: 5),
        child: Text(selectLessonType(lessonType), style: ThemeHelper.getAppTheme().textStyleForLessonTypeName),
      ),
    );
  }

  String selectLessonType(LessonTypes lessonType) {
    switch (lessonType) {
      case LessonTypes.lecture:
        return 'Lecture'; //TODO i18n
      case LessonTypes.practice:
        return 'Practice'; //TODO i18n
      case LessonTypes.laboratory:
        return 'Laboratory'; //TODO i18n
      default:
        return 'Something Interesting...'; //TODO i18n
    }
  }

  Color selectLessonTypeColor(LessonTypes lessonType) {
    switch (lessonType) {
      case LessonTypes.lecture:
        return ThemeHelper.getAppTheme().colorLessonTypeLecture;
      case LessonTypes.practice:
        return ThemeHelper.getAppTheme().colorLessonTypePractice;
      case LessonTypes.laboratory:
        return ThemeHelper.getAppTheme().colorLessonTypeLaboratory;
      default:
        return ThemeHelper.getAppTheme().colorLessonTypeUnknown;
    }
  }
}

