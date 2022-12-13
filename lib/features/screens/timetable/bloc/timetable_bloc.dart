import 'package:novsu_mobile/domain/utils/memory_access_provider.dart';
import 'package:novsu_mobile/features/screens/timetable/bloc/timetable_events.dart';
import 'package:novsu_mobile/features/screens/timetable/bloc/timetable_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TimingBloc extends Bloc<TimingEvent, TimingState> {
  final MemoryAccessProvider memoryAccessProvider;

  TimingBloc({
    required this.memoryAccessProvider
  }) : super(InitTimingState()) {
    on<GetSchoolDaysEvent>((event, emit) => emit(_mapGetLessonsEvent(event, emit)));
  }

  _mapGetLessonsEvent(TimingEvent event, Emitter emit) {
    final timetable = memoryAccessProvider.getTimetable();

    emit(LoadedSchoolDaysState(
        timetable: timetable
    ));
  }
}