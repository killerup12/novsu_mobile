import 'package:novsu_mobile/di/locator.dart';
import 'package:novsu_mobile/domain/exceptions/exceptions.dart';
import 'package:novsu_mobile/features/navigation/routes.dart';
import 'package:novsu_mobile/features/screens/blocs.dart';
import 'package:novsu_mobile/features/screens/login/bloc/login_bloc.dart';
import 'package:novsu_mobile/features/screens/login/login_screen.dart';
import 'package:novsu_mobile/features/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Router {
  Route<dynamic> onGenerateRoute(RouteSettings routeSettings) {
    final route = routeSettings.name;
    final args = routeSettings.arguments;

    switch (route) {

      case Routes.splash:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => locator<SplashBloc>(),
            child: const SplashScreen(),
          ),
          settings: routeSettings
        );

      case Routes.home:
        return MaterialPageRoute(
            builder: (context) => BlocProvider(
              create: (context) => locator<HomeBloc>(),
              child: const HomeScreen(),
            ),
          settings: routeSettings
        );

      case Routes.login:
        return MaterialPageRoute(
            builder: (context) => BlocProvider(
              create: (context) => locator<LoginBloc>(),
              child: const LoginScreen(),
            ),
          settings: routeSettings
        );

      default:
        if (route != null) {
          throw RouteNotFoundException(route);
        } else {
          throw RouteDoesNotExistException();
        }
    }
  }
}