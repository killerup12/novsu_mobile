import 'package:novsu_mobile/features/navigation/router.dart';
import 'package:novsu_mobile/features/navigation/routes.dart';
import 'package:novsu_mobile/features/theme/theme_helper.dart';
import 'package:novsu_mobile/features/utils/simple_bloc_delegate.dart';
import 'package:flutter/material.dart' hide Router;
import 'package:flutter_bloc/flutter_bloc.dart';

import 'di/locator.dart';


void main() async {

  WidgetsFlutterBinding.ensureInitialized();

  //TODO remove Landscape mode from this app

  await initLocator();

  Bloc.observer = SimpleBlocDelegate();

  runApp(FivePlus());
}

class FivePlus extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
          debugShowCheckedModeBanner: true,
          title: "FivePlus",
          theme: ThemeHelper.getAppTheme().theme,
          navigatorKey: locator(),
          initialRoute: Routes.splash,
          onGenerateRoute: locator<Router>().onGenerateRoute
        );
  }
}