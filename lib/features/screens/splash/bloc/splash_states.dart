import 'package:equatable/equatable.dart';

abstract class SplashState extends Equatable {
  @override
  List<Object?> get props;
}

class InitSplashState extends SplashState {
  @override
  List<Object?> get props => [];
}