import 'package:equatable/equatable.dart';

abstract class TopicalEvent extends Equatable {
  @override
  List<Object?> get props;
}

class LoadDataEvent extends TopicalEvent {
  @override
  List<Object?> get props => [];
}