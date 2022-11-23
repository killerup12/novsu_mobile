import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String uid;
  final String personId;
  final String firstName;
  final String lastName;
  final String midName;
  final String email;

  const User({
    required this.uid,
    required this.personId,
    required this.firstName,
    required this.lastName,
    required this.midName,
    required this.email
  });

  @override
  List<Object?> get props => [
    uid,
    personId,
    firstName,
    lastName,
    midName,
    email
  ];
}