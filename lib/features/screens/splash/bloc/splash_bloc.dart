import 'package:novsu_mobile/data/api/novsu_api.dart';
import 'package:novsu_mobile/domain/exceptions/exceptions.dart';
import 'package:novsu_mobile/domain/utils/memory_access_provider.dart';
import 'package:novsu_mobile/features/navigation/navigation_manager.dart';
import 'package:novsu_mobile/features/navigation/routes.dart';
import 'package:novsu_mobile/features/screens/splash/bloc/splash_events.dart';
import 'package:novsu_mobile/features/screens/splash/bloc/splash_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  final NovsuApi novsuApi;
  final NavigationManager navigationManager;
  final MemoryAccessProvider memoryAccessProviderl;

  SplashBloc({
    required this.navigationManager,
    required this.novsuApi,
    required this.memoryAccessProviderl
  }) : super(InitSplashState()) {
    on<GoToTheNextScreenEvent>((event, emit) => _goToTheNextScreen(emit));
  }


  _goToTheNextScreen(Emitter emit) {
    Future.delayed(const Duration(seconds: 2), () async {
      try {
        await novsuApi.getMainProfilePage(); //TODO rework
        memoryAccessProviderl.setTimetable(
              await novsuApi.getTimetable(memoryAccessProviderl.getUser().uid
            )); //TODO rework this shit
        navigationManager.pushRouteWithReplacement(Routes.home);
      } on NetworkException catch(e) {
        navigationManager.pushRoute(Routes.login);
      } on MemoryException catch(e) {
        navigationManager.pushRoute(Routes.login);
      }
    });
  }
}