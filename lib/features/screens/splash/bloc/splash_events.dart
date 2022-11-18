import 'package:equatable/equatable.dart';

abstract class SplashEvent extends Equatable {
  @override
  List<Object?> get props;
}

class GoToTheNextScreenEvent extends SplashEvent {
  @override
  List<Object?> get props => [];
}