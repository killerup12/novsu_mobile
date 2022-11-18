import 'package:flutter/widgets.dart';

import 'navigation_manager.dart';

class NavigationManagerImpl implements NavigationManager {
  final GlobalKey<NavigatorState> navigatorKey;

  NavigationManagerImpl({
    required this.navigatorKey
  });

  @override
  Future<dynamic> pushRoute(String route, [arguments]) async {
    return navigatorKey.currentState?.pushNamed(route, arguments: arguments);
  }

  @override
  Future<dynamic> pushRouteWithReplacement(String route, [arguments]) async {
    while (navigatorKey.currentState?.canPop() ?? false) {
      navigatorKey.currentState?.pop();
    }

    return navigatorKey.currentState?.pushReplacementNamed(route, arguments: arguments);
  }

  @override
  void goBack([arguments]) {
    navigatorKey.currentState?.pop(arguments);
  }

  @override
  BuildContext? getGlobalContext() {
    return navigatorKey.currentContext;
  }
}