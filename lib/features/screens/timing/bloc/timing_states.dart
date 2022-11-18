import 'package:equatable/equatable.dart';
import 'package:novsu_mobile/domain/models/study_day.dart';

abstract class TimingState extends Equatable {
  @override
  List<Object?> get props;
}

class InitTimingState extends TimingState {
  @override
  List<Object?> get props => [];
}

class LoadedSchoolDaysState extends TimingState {
  final List<StudyDay> schoolDays;

  LoadedSchoolDaysState({required this.schoolDays});

  @override
  List<Object?> get props => [schoolDays];
}