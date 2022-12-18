import 'package:flutter/material.dart';

abstract class AppTheme {
  ThemeData get theme;

  Color get colorLessonTypeLecture;

  Color get colorLessonTypePractice;

  Color get colorLessonTypeUnknown;

  Color get colorStudyDayBorder;

  Color get colorDisciplineDetails;

  TextStyle get textStyleForDayOfTheWeek;

  TextStyle get textStyleForLessonTypeName;

  TextStyle get textStyleForDisciplineName;

  TextStyle get textStyleForDisciplineDetails;

  TextStyle get textStyleForStartingLessonTime;

  TextStyle get textStyleForEndingLessonTime;
}