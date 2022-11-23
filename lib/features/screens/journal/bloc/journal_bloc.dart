import 'package:novsu_mobile/domain/models/journal_HARDCODED.dart';
import 'package:novsu_mobile/features/screens/journal/bloc/journal_events.dart';
import 'package:novsu_mobile/features/screens/journal/bloc/journal_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class JournalBloc extends Bloc<JournalEvent, JournalState> {
  JournalBloc() : super(InitJournalState()) {
    on<LoadJournalEvent>((event, emit) => emit(_loadJournal()));
  }

  LoadedSubjectsState _loadJournal() {
    return LoadedSubjectsState(journalItems: JournalHerdCode.journalItems);
  }
}