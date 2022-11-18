import 'package:equatable/equatable.dart';
import 'package:novsu_mobile/domain/models/news_item.dart';
import 'package:novsu_mobile/domain/models/study_day.dart';
import 'package:flutter/cupertino.dart';

abstract class TopicalState extends Equatable {
  @override
  List<Object?> get props;
}

class InitTopicalState extends TopicalState {
  @override
  List<Object?> get props => [];
}

class DataIsReadyForUsingState extends TopicalState {
  final StudyDay schoolDay;
  final List<News> news;

  DataIsReadyForUsingState({
    required this.schoolDay,
    required this.news
  });

  @override
  List<Object?> get props => [schoolDay, news];
}