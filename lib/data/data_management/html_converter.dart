import 'package:novsu_mobile/domain/models/lesson_item.dart';
import 'package:novsu_mobile/domain/models/study_day.dart';
import 'package:novsu_mobile/domain/models/timeable_item.dart';

abstract class HtmlConverter {
  String extractTimetableLink(String html);

  Timetable convertHtmlTimetable(String html);
}