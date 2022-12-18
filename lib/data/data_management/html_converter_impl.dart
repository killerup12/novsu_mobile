import 'package:html/parser.dart' as parser;
import 'package:html/dom.dart' as dom;
import 'package:novsu_mobile/domain/enums/lesson_types.dart';

import 'package:novsu_mobile/domain/models/lesson.dart';
import 'package:novsu_mobile/domain/models/study_day.dart';
import 'package:novsu_mobile/domain/utils/html_converter.dart';
import 'package:novsu_mobile/domain/models/timetable.dart';

class HtmlConverterImpl implements HtmlConverter {

  @override
  String extractTimetableLink(String html) {
    final pars = parser.parse(html)
        .getElementsByTagName('html iframe')[0]
        .attributes['src'];

    return pars ?? ''; //TODO add an exception
  }

  @override
  Timetable convertHtmlTimetable(String html) {
    final pars = parser.parse(html);

    final aboutStudentsGroup = pars.getElementsByTagName('html h3');
    final List<dom.Element> domTiming = pars.getElementsByTagName('tr')
      ..removeRange(0, 3);

    String studentsGroup = formatter(aboutStudentsGroup.first.nodes[0].toString());
    String relevancePeriod = formatter(aboutStudentsGroup.last.nodes[0].toString());

    List<StudyDay> studyDays = [];

    List<Lesson> lessons = [];

    late String dayOfTheWeek;

    for (dom.Node node in domTiming) {

      if (node.attributes['style'] == 'border-bottom: 1px solid #404040') {//Here we get day of the week
        if ((lessons.isNotEmpty)) {
          final localList = [...lessons];
          studyDays.add(StudyDay(
              shortWeekDay: dayOfTheWeek,
              lessons: localList
          ));
          lessons.clear();
        }
        dayOfTheWeek = formatter(node.nodes[1].nodes[0].toString());
      } else {
        List<String> time = [];
        for (var element in node.nodes[1].nodes) {
          if ((element is dom.Text) & (formatter(element.toString()).isNotEmpty)) {
            time.add(formatter(element.toString()));
          }
        }

        final separate = node.nodes[5].nodes[0].toString().split('\t\t\t\t\t\t\t\t');

        late final String name;
        late final String lessonType;

        try {
          name = formatter(separate[1]);

          lessonType = formatter(separate[0]);
        } catch (e) {
          name = formatter(separate[0]);

          lessonType = ''; //TODO Think about that
        }

        final String teacher = formatter(node.nodes[5].nodes[3].nodes[0].toString());

        final String room = formatter(node.nodes[5].nodes[5].nodes[0].toString());

        lessons.add(Lesson(
            time: time,
            name: name,
            teacher: teacher,
            room: room,
            lessonType: _selectLessonType(lessonType)
        ));
      }
    }

    final localList = [...lessons];
    studyDays.add(StudyDay(
        shortWeekDay: dayOfTheWeek,
        lessons: localList
    ));

    return Timetable(
        forGroup: studentsGroup,
        relevancePeriod: relevancePeriod,
        studyDays: studyDays
    );
  }

  _selectLessonType(String lessonType) {
    switch (lessonType) {
      case 'лек.':
        return LessonTypes.lecture;
      case 'пр.':
        return LessonTypes.practice;
      default:
        return LessonTypes.unknown;
    }
  }

  String formatter(String string) {
    return string
        .replaceAll('\n', ' ')
        .replaceAll('\t', ' ')
        .replaceAll('\"', ' ')
        .trim();
  }
}