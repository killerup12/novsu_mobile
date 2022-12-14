import 'package:equatable/equatable.dart';

abstract class ServicesEvent extends Equatable {
  @override
  List<Object?> get props;
}

class LogOutEvent extends ServicesEvent {
  @override
  List<Object?> get props => [];
}