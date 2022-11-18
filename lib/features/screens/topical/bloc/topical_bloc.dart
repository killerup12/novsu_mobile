import 'package:novsu_mobile/features/screens/topical/bloc/topical_events.dart';
import 'package:novsu_mobile/features/screens/topical/bloc/topical_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TopicalBloc extends Bloc<TopicalEvent, TopicalState> {
  TopicalBloc() : super(InitTopicalState()){
    on<LoadDataEvent>((event, emit) => emit(_mapLoadDataEvent(event)));
  }

  TopicalState _mapLoadDataEvent(TopicalEvent event) {
    return InitTopicalState(); //TODO rework
  }
}