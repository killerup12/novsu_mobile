import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

abstract class HomeState extends Equatable {
  final Widget page;

  const HomeState({required this.page});

  @override
  List<Object?> get props;
}

class InitHomeState extends HomeState {
  const InitHomeState({
    required Widget page
  }) : super(page: page);

  @override
  List<Object?> get props => [super.page];
}

class SelectedPageState extends HomeState {
  const SelectedPageState({
    required Widget page
  }) : super(page: page);

  @override
  List<Object?> get props => [super.page];
}