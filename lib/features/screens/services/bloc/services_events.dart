import 'package:equatable/equatable.dart';

abstract class ServicesEvent extends Equatable {
  @override
  List<Object?> get props;
}

class Login extends ServicesEvent {
  @override
  List<Object?> get props => [];
}