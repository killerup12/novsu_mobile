import 'package:novsu_mobile/domain/models/lesson_item.dart';
import 'package:novsu_mobile/domain/models/study_day.dart';

abstract class HtmlConverter {
  String extractTimetableLink(String html);

  List<StudyDay> convertHtmlTimetable(String html);
}