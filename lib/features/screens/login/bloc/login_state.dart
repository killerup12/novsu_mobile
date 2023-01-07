import 'package:equatable/equatable.dart';

abstract class LoginState extends Equatable {}

class InitLoginState extends LoginState {
  @override
  List<Object?> get props => [];
}

class WaitingResponseLoginState extends LoginState {
  @override
  List<Object?> get props => [];
}

class WrongLoginOrPasswordState extends LoginState {
  final String message;

  WrongLoginOrPasswordState({
    required this.message
  });

  @override
  List<Object?> get props => [
    message
  ];
}