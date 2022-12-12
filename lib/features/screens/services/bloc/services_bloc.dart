import 'package:novsu_mobile/data/api/novsu_api.dart';
import 'package:novsu_mobile/domain/utils/memory_access_provider.dart';
import 'package:novsu_mobile/features/screens/services/bloc/services_events.dart';
import 'package:novsu_mobile/features/screens/services/bloc/services_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ServicesBloc extends Bloc<ServicesEvent, ServicesState> {
  final NovsuApi novsuApi;
  final MemoryAccessProvider memoryAccessProvider;

  ServicesBloc({
    required this.novsuApi,
    required this.memoryAccessProvider
  }) : super(InitServicesState()) {

  }
}