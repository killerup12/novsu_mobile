import 'package:novsu_mobile/data/api/novsu_api.dart';
import 'package:novsu_mobile/domain/exceptions/exceptions.dart';
import 'package:novsu_mobile/domain/utils/memory_access_provider.dart';
import 'package:novsu_mobile/features/navigation/navigation_manager.dart';
import 'package:novsu_mobile/features/navigation/routes.dart';
import 'package:novsu_mobile/features/screens/splash/bloc/splash_events.dart';
import 'package:novsu_mobile/features/screens/splash/bloc/splash_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

export 'splash_events.dart';
export 'splash_states.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  final NovsuApi novsuApi;
  final NavigationManager navigationManager;
  final MemoryAccessProvider memoryAccessProvider;

  SplashBloc({
    required this.navigationManager,
    required this.novsuApi,
    required this.memoryAccessProvider
  }) : super(InitSplashState()) {
    on<GoToTheNextScreenEvent>((event, emit) async {
      await _goToTheNextScreen(emit);
    });
  }


  _goToTheNextScreen(Emitter<SplashState> emit) async {
        try {
          emit(StepEvent(
              step: 'await novsuApi.getMainProfilePage(); //TODO rework')); //TODO remove
          await novsuApi.getMainProfilePage(); //TODO rework
          emit(StepEvent(step: 'memoryAccessProviderl.setTimetable')); //TODO remove
          memoryAccessProvider.setTimetable(await novsuApi.getTimetable(
              memoryAccessProvider.getUser().uid)); //TODO rework this shit
          navigationManager.pushRouteWithReplacement(Routes.home);
        } on NetworkException catch (e) {
          emit(StepEvent(
              step: 'NetworkException')); //TODO remove
          navigationManager.pushRouteWithReplacement(Routes.login);
        } on MemoryException catch (e) {
          emit(StepEvent(
              step: 'MemoryException')); //TODO remove
          navigationManager.pushRouteWithReplacement(Routes.login);
        }
      }
  }