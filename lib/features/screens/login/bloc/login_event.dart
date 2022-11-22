import 'package:equatable/equatable.dart';

abstract class LoginEvent extends Equatable {}

class LoginToTheAccount extends LoginEvent {
  final String userName;
  final String password;


  LoginToTheAccount({
    required this.userName,
    required this.password,
  });

  @override
  List<Object?> get props => [
    userName,
    password,
  ];
}