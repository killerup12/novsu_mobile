import 'dart:async';

import 'package:flutter/widgets.dart';

abstract class NavigationManager {
  Future<dynamic> pushRoute(String route, [arguments]);

  Future<dynamic> pushRouteWithReplacement(String route, [arguments]);

  void goBack([arguments]);

  BuildContext? getGlobalContext();
}