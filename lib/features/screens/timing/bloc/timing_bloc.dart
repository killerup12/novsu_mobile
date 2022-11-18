import 'package:novsu_mobile/features/screens/timing/bloc/timing_events.dart';
import 'package:novsu_mobile/features/screens/timing/bloc/timing_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TimingBloc extends Bloc<TimingEvent, TimingState> {

  TimingBloc() : super(InitTimingState()) {
    on<GetSchoolDaysEvent>((event, emit) => emit(_mapGetLessonsEvent()));
  }

  TimingState _mapGetLessonsEvent() {
    return InitTimingState(); //TODO rework
  }
}