import 'package:novsu_mobile/domain/models/timetable.dart';

abstract class HtmlConverter {
  String extractTimetableLink(String html);

  Timetable convertHtmlTimetable(String html);
}