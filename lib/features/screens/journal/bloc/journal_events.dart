import 'package:equatable/equatable.dart';

abstract class JournalEvent extends Equatable {
  @override
  List<Object?> get props;
}

class LoadJournalEvent extends JournalEvent {
  @override
  List<Object?> get props => [];
}