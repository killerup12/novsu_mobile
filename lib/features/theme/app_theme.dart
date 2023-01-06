import 'package:flutter/material.dart';

abstract class AppTheme {
  ThemeData get theme;

  Color get enableActionButton;

  Color get disableActionButton;

  Color get errorActionButton;

  Color get colorShadowForLoginButton;

  Color get colorErrorShadowForLoginButton;

  Color get colorLessonTypeLecture;

  Color get colorLessonTypeLaboratory;

  Color get colorLessonTypePractice;

  Color get colorLessonTypeUnknown;

  Color get colorStudyDayBorder;

  Color get colorDisciplineDetails;

  TextStyle get textStyleForLoginButton;

  TextStyle get textStyleForDayOfTheWeek;

  TextStyle get textStyleForLessonTypeName;

  TextStyle get textStyleForDisciplineName;

  TextStyle get textStyleForDisciplineDetails;

  TextStyle get textStyleForStartingLessonTime;

  TextStyle get textStyleForEndingLessonTime;
}