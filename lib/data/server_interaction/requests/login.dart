import 'package:equatable/equatable.dart';

class Login extends Equatable {
  final String uid;
  final String password;


  const Login({
    required this.uid,
    required this.password,
  });

  @override
  List<Object?> get props => [
    uid,
    password,
  ];
}