import 'package:novsu_mobile/domain/models/timeable_item.dart';
import 'package:novsu_mobile/domain/models/user.dart';

abstract class MemoryAccessProvider {
  User getUser();

  void setUser(User user);

  Timetable getTimetable();

  void setTimetable(Timetable timetable);
}