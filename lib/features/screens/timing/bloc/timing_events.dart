import 'package:equatable/equatable.dart';

abstract class TimingEvent extends Equatable {
  @override
  List<Object?> get props;
}

class GetSchoolDaysEvent extends TimingEvent {
  @override
  List<Object?> get props => [];
}