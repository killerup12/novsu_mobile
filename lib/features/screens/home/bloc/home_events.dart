import 'package:equatable/equatable.dart';

abstract class HomeEvent extends Equatable {
  @override
  List<Object?> get props;
}

class ChangeSelectedScreenEvent extends HomeEvent {
  final int index;

  ChangeSelectedScreenEvent({
    required this.index
  });

  @override
  List<Object?> get props => [
    index
  ];
}