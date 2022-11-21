import 'package:equatable/equatable.dart';
import 'package:novsu_mobile/domain/models/study_day.dart';

class Timetable extends Equatable {
  final String forGroup;
  final String relevancePeriod;
  final List<StudyDay> studyDays;


  const Timetable({
    required this.forGroup,
    required this.relevancePeriod,
    required this.studyDays
  });

  @override
  List<Object?> get props => [
    forGroup,
    relevancePeriod,
    studyDays
  ];
}