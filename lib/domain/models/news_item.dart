import 'package:equatable/equatable.dart';

class News extends Equatable {
  final String image;
  final String description;

  const News({
    required this.image,
    required this.description
  });

  @override
  List<Object?> get props => [image, description];
}