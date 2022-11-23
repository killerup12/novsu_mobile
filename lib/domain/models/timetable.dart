import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:novsu_mobile/domain/models/study_day.dart';

part '../hive_adapters/timetable.g.dart';

@HiveType(typeId: 1)
class Timetable extends Equatable {
  @HiveField(0)
  final String forGroup;
  @HiveField(1)
  final String relevancePeriod;
  @HiveField(2)
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