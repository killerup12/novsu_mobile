import 'package:novsu_mobile/domain/utils/memory_access_provider.dart';
import 'package:novsu_mobile/features/navigation/navigation_manager.dart';
import 'package:novsu_mobile/features/navigation/routes.dart';
import 'package:novsu_mobile/features/screens/topical/bloc/topical_events.dart';
import 'package:novsu_mobile/features/screens/topical/bloc/topical_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TopicalBloc extends Bloc<TopicalEvent, TopicalState> {
  final MemoryAccessProvider memoryAccessProvider;
  final NavigationManager navigationManager;

  TopicalBloc({
    required this.memoryAccessProvider,
    required this.navigationManager
  }) : super(InitTopicalState()){
    on<LoadDataEvent>((event, emit) => emit(_mapLoadDataEvent(event)));
    // on<LogOutEvent>((event, emit) => _mapLogOutEvent(event, emit));
  }

  TopicalState _mapLoadDataEvent(TopicalEvent event) {
    return InitTopicalState(); //TODO rework
  }

  // _mapLogOutEvent(LogOutEvent event, Emitter emit) {
  //   memoryAccessProvider.removeAccountData();
  //   navigationManager.pushRouteWithReplacement(Routes.login);
  // }
}