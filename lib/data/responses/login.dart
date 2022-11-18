import 'package:equatable/equatable.dart';
import 'package:novsu_mobile/domain/models/response_fields/user.dart';

class Login extends Equatable {
  final User user;

  const Login({
    required this.user
  });

  @override
  List<Object?> get props => [
    user
  ];
}