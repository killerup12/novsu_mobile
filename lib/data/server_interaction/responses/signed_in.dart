import 'package:equatable/equatable.dart';
import 'package:novsu_mobile/domain/models/response_fields/user.dart';

class SignedIn extends Equatable {
  final User user;

  const SignedIn({
    required this.user
  });

  factory SignedIn.fromJSON(json) {
    return SignedIn(
        user: User(
            uid: json['user']['uid'],
            personId: json['user']['personId'],
            firstName: json['user']['firstName'],
            lastName: json['user']['lastName'],
            midName: json['user']['midName'],
            email: json['user']['email']
        )
    );
  }

  @override
  List<Object?> get props => [
    user
  ];
}