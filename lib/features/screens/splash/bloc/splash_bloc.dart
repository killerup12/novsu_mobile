import 'package:novsu_mobile/data/api/novsu_api.dart';
import 'package:novsu_mobile/features/navigation/navigation_manager.dart';
import 'package:novsu_mobile/features/navigation/routes.dart';
import 'package:novsu_mobile/features/screens/splash/bloc/splash_events.dart';
import 'package:novsu_mobile/features/screens/splash/bloc/splash_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  final NavigationManager navigationManager;
  final NovsuApi novsuApi;

  SplashBloc({
    required this.navigationManager,
    required this.novsuApi
  }) : super(InitSplashState()) {
    on<GoToTheNextScreenEvent>((_, __) => _goToTheNextScreen());
  }


  _goToTheNextScreen() {
    Future.delayed(const Duration(seconds: 2), () {
      navigationManager.pushRouteWithReplacement(Routes.home);
    });
  }
}