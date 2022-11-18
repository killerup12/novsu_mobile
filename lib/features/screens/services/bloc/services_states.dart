import 'package:equatable/equatable.dart';

abstract class ServicesState extends Equatable {
  @override
  List<Object?> get props;
}

class InitServicesState extends ServicesState {
  @override
  List<Object?> get props => [];
}