import 'package:novsu_mobile/features/theme/app_theme.dart';
import 'package:novsu_mobile/features/utils/hex_color.dart';
import 'package:flutter/material.dart';

Map<int, Color> _colorMaterialDarkBlue = {
  50:  const  Color.fromRGBO(1, 86, 151, .1),
  100: const  Color.fromRGBO(1, 86, 151, .2),
  200: const  Color.fromRGBO(1, 86, 151, .3),
  300: const  Color.fromRGBO(1, 86, 151, .4),
  500: const  Color.fromRGBO(1, 86, 151, .6),
  400: const  Color.fromRGBO(1, 86, 151, .5),
  600: const  Color.fromRGBO(1, 86, 151, .7),
  700: const  Color.fromRGBO(1, 86, 151, .8),
  800: const  Color.fromRGBO(1, 86, 151, .9),
  900: const  Color.fromRGBO(1, 86, 151, 1),
};

final MaterialColor _materialColorGreen = MaterialColor(0xFF0F6C4F, _colorMaterialDarkBlue);


class MainTheme implements AppTheme {
  final Color _colorLightGreen = HexColor('#88BD32');
  final Color _colorGreen = HexColor('#A8D793');
  final Color _colorRed = HexColor('#C62828');
  final Color _colorLightRed = HexColor('#EA4752');
  final Color _colorWhite = HexColor('#FFFFFF');
  final Color _colorBlue = HexColor('#0093FF');
  final Color _colorPurple = HexColor('#A008FF');
  final Color _colorSkyBlue = HexColor('#56BDE9');
  final Color _colorDarkBlue = HexColor('#015697');
  final Color _colorBlack = HexColor('#000000');
  final Color _colorGray = HexColor('#8D8D8D');
  final Color _colorYellow = HexColor('#FEC222');

  ThemeData? _themeDataInstance;

  ThemeData _getThemeData() {
    _themeDataInstance ??= ThemeData(
        primaryColor: _materialColorGreen,
        brightness: Brightness.light,
        textTheme: TextTheme(
          headline1: TextStyle(
              fontSize: 29, fontWeight: FontWeight.bold, color: _colorWhite),
          headline2: TextStyle(
              fontSize: 23, fontWeight: FontWeight.bold, color: _colorWhite),
          headline3: TextStyle(
              fontSize: 17, fontWeight: FontWeight.w600, color: _colorWhite),
          headline4: TextStyle(
              fontSize: 17, fontWeight: FontWeight.normal, color: _colorWhite),
          button: const TextStyle(fontSize: 17),
        ),
        appBarTheme: AppBarTheme(
            color: _colorWhite,
            iconTheme: IconThemeData(
              color: _colorWhite,
            ),
            actionsIconTheme: IconThemeData(
              color: _colorDarkBlue,
            ),
            titleTextStyle: TextStyle(
              fontSize: 30,
              color: _colorDarkBlue,
            ),
            elevation: 0
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          type: BottomNavigationBarType.fixed,
          backgroundColor: _colorWhite,
          selectedItemColor: _colorDarkBlue,
        ),
        scaffoldBackgroundColor: _colorWhite,
        errorColor: _colorRed,
        colorScheme: ColorScheme.fromSwatch().copyWith(secondary: _materialColorGreen),
      );

    return _themeDataInstance!;  //TODO needs be refactored
  }

  @override
  ThemeData get theme => _getThemeData();

  @override
  Color get colorLessonTypeLecture => _colorBlue;

  @override
  Color get colorLessonTypeLaboratory => _colorPurple;

  @override
  Color get colorLessonTypePractice => _colorYellow;

  @override
  Color get colorLessonTypeUnknown => _colorLightGreen;

  @override
  Color get colorStudyDayBorder => _colorSkyBlue;

  @override
  Color get colorDisciplineDetails => _colorGray;

  @override
  TextStyle get textStyleForDayOfTheWeek => TextStyle(
    color: _colorDarkBlue,
    fontSize: 20,
    fontWeight: FontWeight.bold
  );

  @override
  TextStyle get textStyleForLessonTypeName => TextStyle(
    color: _colorWhite,
    fontSize: 14,
    fontWeight: FontWeight.w500
  );

  @override
  TextStyle get textStyleForDisciplineName => TextStyle(
    color: _colorBlack,
    fontSize: 16,
    fontWeight: FontWeight.bold
  );

  @override
  TextStyle get textStyleForDisciplineDetails => TextStyle(
    color: _colorGray,
    fontSize: 14,
    fontWeight: FontWeight.w400
  );

  @override
  TextStyle get textStyleForStartingLessonTime => TextStyle(
      color: _colorBlack,
      fontSize: 16,
      fontWeight: FontWeight.bold
  );

  @override
  TextStyle get textStyleForEndingLessonTime => TextStyle(
      color: _colorGray,
      fontSize: 14,
      fontWeight: FontWeight.w400
  );

}