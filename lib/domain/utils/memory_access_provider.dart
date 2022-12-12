import 'package:novsu_mobile/domain/models/timetable.dart';
import 'package:novsu_mobile/domain/models/user.dart';

abstract class MemoryAccessProvider {
  Future removeAccountData();

  User getUser();

  void setUser(User user);

  Timetable getTimetable();

  void setTimetable(Timetable timetable);
}