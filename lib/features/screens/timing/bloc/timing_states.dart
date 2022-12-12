import 'package:equatable/equatable.dart';
import 'package:novsu_mobile/domain/models/models.dart';

abstract class TimingState extends Equatable {
  @override
  List<Object?> get props;
}

class InitTimingState extends TimingState {
  @override
  List<Object?> get props => [];
}

class LoadedSchoolDaysState extends TimingState {
  final Timetable timetable;

  LoadedSchoolDaysState({required this.timetable});

  @override
  List<Object?> get props => [timetable];
}