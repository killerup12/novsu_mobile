import 'package:novsu_mobile/data/api/novsu_api.dart';
import 'package:novsu_mobile/features/screens/services/bloc/services_events.dart';
import 'package:novsu_mobile/features/screens/services/bloc/services_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ServicesBloc extends Bloc<ServicesEvent, ServicesState> {
  final NovsuApi novsuApi;

  ServicesBloc({
    required this.novsuApi
  }) : super(InitServicesState()) {
    on<Login>((event, emit) async => await novsuApi.getTimetable());
  }
}