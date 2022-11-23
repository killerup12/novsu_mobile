import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

part '../hive_adapters/user.g.dart';

@HiveType(typeId: 0)
class User extends Equatable {
  @HiveField(0)
  final String uid;
  @HiveField(1)
  final String personId;
  @HiveField(2)
  final String firstName;
  @HiveField(3)
  final String lastName;
  @HiveField(4)
  final String midName;
  @HiveField(5)
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