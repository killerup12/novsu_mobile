import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

abstract class HomeState extends Equatable {
  @override
  List<Object?> get props;
}

class InitHomeState extends HomeState {
  @override
  List<Object?> get props => [];
}

class SelectedPageState extends HomeState {
  @override
  List<Object?> get props => [];
}