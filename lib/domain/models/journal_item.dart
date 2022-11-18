import 'package:equatable/equatable.dart';

class JournalItem extends Equatable {
  final String subject;
  final double grade;


  const JournalItem({
    required this.subject,
    required this.grade
  });

  @override
  List<Object?> get props => [
    subject,
    grade
  ];
}