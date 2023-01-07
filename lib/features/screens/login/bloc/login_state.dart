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

class ErrorLoginScreenState extends LoginState {
  final String message;

  ErrorLoginScreenState({
    required this.message
  });

  @override
  List<Object?> get props => [
    message
  ];
}