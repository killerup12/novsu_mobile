import 'package:cookie_jar/cookie_jar.dart';
import 'package:hive/hive.dart';
import 'package:novsu_mobile/domain/exceptions/exceptions.dart';
import 'package:novsu_mobile/domain/models/timetable.dart';
import 'package:novsu_mobile/domain/models/user.dart';
import 'package:novsu_mobile/domain/utils/memory_access_provider.dart';

class MemoryAccessProviderImpl extends MemoryAccessProvider {
  static const String boxName = 'studentData';
  static const String _user = 'user';
  static const String _timetable = 'timetable';

  final CookieJar cookieJar;

  MemoryAccessProviderImpl({
    required this.cookieJar
  });

  @override
  Future removeAccountData() async {
    await Hive.box(boxName).clear();
    await cookieJar.deleteAll();
  }

  @override
  User getUser() {
    return _returnData(Hive.box('studentData').get(_user));
  }

  @override
  void setUser(User user) {
    Hive.box(boxName).put(_user, user);
  }

  @override
  Timetable getTimetable() {
    return _returnData(Hive.box(boxName).get(_timetable));
  }

  @override
  void setTimetable(Timetable timetable) {
    Hive.box(boxName).put(_timetable, timetable);
  }

  _returnData(data) {
    if (data != null) {
      return data;
    } else {
      throw NotFoundInDeviceMemoryException();
    }
  }
}
