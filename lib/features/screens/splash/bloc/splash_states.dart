import 'package:equatable/equatable.dart';

abstract class SplashState extends Equatable {
  @override
  List<Object?> get props;
}

class InitSplashState extends SplashState {
  @override
  List<Object?> get props => [];
}

class InternetConnectionError extends SplashState {
  @override
  List<Object?> get props => [];
}

class WrongUsernameOrPassword extends SplashState {
  @override
  List<Object?> get props => [];
}

class StepEvent extends SplashState { //TODO remove
  final String step;


  StepEvent({
    required this.step
  });

  @override
  List<Object?> get props => [];
}