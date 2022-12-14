import 'package:novsu_mobile/data/api/novsu_api.dart';
import 'package:novsu_mobile/domain/utils/memory_access_provider.dart';
import 'package:novsu_mobile/features/navigation/navigation_manager.dart';
import 'package:novsu_mobile/features/navigation/routes.dart';
import 'package:novsu_mobile/features/screens/services/bloc/services_events.dart';
import 'package:novsu_mobile/features/screens/services/bloc/services_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

export 'services_events.dart';
export 'services_states.dart';

class ServicesBloc extends Bloc<ServicesEvent, ServicesState> {
  final NovsuApi novsuApi;
  final MemoryAccessProvider memoryAccessProvider;
  final NavigationManager navigationManager;

  ServicesBloc({
    required this.novsuApi,
    required this.memoryAccessProvider,
    required this.navigationManager
  }) : super(InitServicesState()) {
    on<LogOutEvent>((event, emit) => _mapLogOutEvent(event, emit));
  }

  _mapLogOutEvent(LogOutEvent event, Emitter emit) {
    memoryAccessProvider.removeAccountData();
    navigationManager.pushRouteWithReplacement(Routes.login);
  }
}