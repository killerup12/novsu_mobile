import 'package:equatable/equatable.dart';

class Journal extends Equatable {
  final String subject;
  final double grade;


  const Journal({
    required this.subject,
    required this.grade
  });

  @override
  List<Object?> get props => [
    subject,
    grade
  ];
}