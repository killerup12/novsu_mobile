import 'package:equatable/equatable.dart';
import 'package:novsu_mobile/domain/models/journal.dart';

abstract class JournalState extends Equatable {
  @override
  List<Object?> get props;
}

class InitJournalState extends JournalState {
  @override
  List<Object?> get props => [];
}

class LoadedSubjectsState extends JournalState {
  final List<Journal> journalItems;

  LoadedSubjectsState({
    required this.journalItems
  });

  @override
  List<Object?> get props => [journalItems];
}
