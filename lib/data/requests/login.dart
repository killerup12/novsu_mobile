import 'package:equatable/equatable.dart';

class Login extends Equatable {
  final String uid;
  final String password;
  final String redirect;
  final String json;
  final String remember;


  const Login({
    required this.uid,
    required this.password,
    this.redirect = '',
    this.json = '1',
    this.remember = ''
  });

  @override
  List<Object?> get props => [
    uid,
    password,
    redirect,
    json,
    remember
  ];
}