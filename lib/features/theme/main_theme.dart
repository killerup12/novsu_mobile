import 'package:novsu_mobile/features/theme/app_theme.dart';
import 'package:novsu_mobile/features/utils/hex_color.dart';
import 'package:flutter/material.dart';

Map<int, Color> _colorGreen = {
  50:  const  Color.fromRGBO(208, 230, 205, .1),
  100: const  Color.fromRGBO(208, 230, 205, .2),
  200: const  Color.fromRGBO(208, 230, 205, .3),
  300: const  Color.fromRGBO(208, 230, 205, .4),
  500: const  Color.fromRGBO(208, 230, 205, .6),
  400: const  Color.fromRGBO(208, 230, 205, .5),
  600: const  Color.fromRGBO(208, 230, 205, .7),
  700: const  Color.fromRGBO(208, 230, 205, .8),
  800: const  Color.fromRGBO(208, 230, 205, .9),
  900: const  Color.fromRGBO(208, 230, 205, 1),
};

final MaterialColor _materialColorGreen = MaterialColor(0xFF0F6C4F, _colorGreen);


class MainTheme implements AppTheme {
  final Color _colorLightGreen = HexColor('#D0E6CD');
  final Color _colorGreen = HexColor('#A8D793');
  final Color _colorRed = HexColor('#C62828');
  final Color _colorLightRed = HexColor('#EA4752');
  final Color _colorWhite = HexColor('#FFFFFF');

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
            color: _colorLightGreen,
            iconTheme: IconThemeData(
              color: _colorWhite,
            ),
            actionsIconTheme: IconThemeData(
              color: _materialColorGreen,
            ),
            titleTextStyle: TextStyle(
              fontSize: 30,
              color: _colorLightRed,
              //TODO add style
            ),
            elevation: 0
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          type: BottomNavigationBarType.fixed,
          backgroundColor: _colorGreen,
            selectedItemColor: _colorLightRed,
        ),
        scaffoldBackgroundColor: _colorLightGreen,
        errorColor: _colorRed,
        colorScheme: ColorScheme.fromSwatch().copyWith(secondary: _materialColorGreen),
      );

    return _themeDataInstance!;  //TODO needs be refactored
  }

  @override
  ThemeData get theme => _getThemeData();

  @override
  Color get colorRed => _colorRed;

  @override
  Color get colorGreen => _colorGreen;

  @override
  Color get colorLightGreen => _colorLightGreen;
}